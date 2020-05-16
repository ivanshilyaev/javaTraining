package ft.training.by.controller.action;

import ft.training.by.bean.Administrator;
import ft.training.by.bean.Student;
import ft.training.by.bean.Tutor;
import ft.training.by.bean.User;
import ft.training.by.bean.enums.Role;
import ft.training.by.service.PasswordUtilities;
import ft.training.by.service.interfaces.AdministratorService;
import ft.training.by.service.interfaces.StudentService;
import ft.training.by.service.interfaces.TutorService;
import ft.training.by.service.interfaces.UserService;
import ft.training.by.service.exception.ServiceException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

public class LoginAction extends Action {
    private static final Logger LOGGER = LogManager.getLogger();

    private static String address = "Адрес: ул. Октябрьская, 10, 220030, г. Минск, Республика Беларусь";

    private static final String PARAM_NAME_LOGIN = "login";
    private static final String PARAM_NAME_PASSWORD = "password";

    private static Map<Role, List<MenuItem>> menu = new ConcurrentHashMap<>();

    static {
        menu.put(Role.STUDENT, new ArrayList<>(Arrays.asList(
                new MenuItem("главная страница студента", "/studentCabinet.html")
        )));
        menu.put(Role.ADMINISTRATOR, new ArrayList<>(Arrays.asList(
                new MenuItem("главная страница администатора", "/adminCabinet.html")
        )));
        menu.put(Role.TUTOR, new ArrayList<>(Arrays.asList(
                // !
                new MenuItem("главная страница преподавателя", "/tutorCabinet.html")
        )));
    }

    @Override
    public Set<Role> getAllowedRoles() {
        return null;
    }

    @Override
    public Action.Forward exec(HttpServletRequest request, HttpServletResponse response)
            throws ServiceException {
        String login = request.getParameter(PARAM_NAME_LOGIN);
        String password = request.getParameter(PARAM_NAME_PASSWORD);
        request.getSession().setAttribute("address", address);
        if (login != null && password != null) {
            UserService userService = factory.createService(UserService.class);
            String hashedPassword = PasswordUtilities.hashPassword(password).orElse(null);
            User user = userService.read(login, password.toCharArray()).orElse(null);
            if (user == null) {
                user = userService.read(login, hashedPassword.toCharArray()).orElse(null);
            }
            if (user != null) {
                // для привествия пользователя на главной странице
                request.getSession().setAttribute("username", user.getName() + " " + user.getPatronymic());
                // для разделения пользователей
                request.getSession().setAttribute("authorizedUser", user);
                setAuthorizedUser(user);
                switch (user.getRole()) {
                    case STUDENT:
                        StudentService studentService = factory.createService(StudentService.class);
                        Student student = studentService.findByUserId(user.getId()).orElse(null);
                        if (student != null) {
                            request.getSession().setAttribute("authorizedStudent", student);
                        }
                        break;

                    case ADMINISTRATOR:
                        AdministratorService administratorService = factory.createService(AdministratorService.class);
                        Administrator administrator = administratorService.findByUserId(user.getId()).orElse(null);
                        if (administrator != null) {
                            request.getSession().setAttribute("authorizedAdministrator", administrator);
                        }
                        break;

                    case TUTOR:
                        TutorService tutorService = factory.createService(TutorService.class);
                        Tutor tutor = tutorService.findByUserId(user.getId()).orElse(null);
                        if (tutor != null) {
                            request.getSession().setAttribute("authorizedTutor", tutor);
                        }
                        break;
                    default:
                        break;
                }
                request.getSession().setAttribute("menu", menu.get(user.getRole()));
                LOGGER.info(String.format("User \"%s\" is logged in from %s (%s:%s)",
                        login, request.getRemoteAddr(), request.getRemoteHost(), request.getRemotePort()));
                return new Forward("/index.html");
            } else {
                // "Unknown login or password"
                request.setAttribute("message", "Неверный логин или пароль");
                LOGGER.info(String.format("User \"%s\" unsuccessfully tried to log in from %s (%s:%s)",
                        login, request.getRemoteAddr(), request.getRemoteHost(), request.getRemotePort()));
            }
        }
        return null;
    }
}

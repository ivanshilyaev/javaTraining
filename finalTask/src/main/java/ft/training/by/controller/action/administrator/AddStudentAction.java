package ft.training.by.controller.action.administrator;

import ft.training.by.bean.Group;
import ft.training.by.bean.Student;
import ft.training.by.bean.Subgroup;
import ft.training.by.bean.User;
import ft.training.by.bean.enums.Role;
import ft.training.by.service.exception.ServiceException;
import ft.training.by.service.interfaces.GroupService;
import ft.training.by.service.interfaces.StudentService;
import ft.training.by.service.interfaces.SubgroupService;
import ft.training.by.service.interfaces.UserService;
import ft.training.by.validator.ValidationFactory;
import ft.training.by.validator.Validator;
import ft.training.by.validator.exception.ValidationException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddStudentAction extends AdministratorAction {
    private static final Logger LOGGER = LogManager.getLogger();

    private static final String PARAM_NAME_GROUP_NUMBER = "groupNum";
    private static final String PARAM_NAME_COURSE_NUMBER = "courseNum";
    private static final String PARAM_NAME_SUBGROUP = "subgroup";

    @Override
    public Forward exec(HttpServletRequest request, HttpServletResponse response) throws ServiceException {
        User authorizedUser = (User) request.getSession().getAttribute("authorizedUser");
        int groupNum;
        int courseNum;
        try {
            groupNum = Integer.parseInt(request.getParameter(PARAM_NAME_GROUP_NUMBER));
            courseNum = Integer.parseInt(request.getParameter(PARAM_NAME_COURSE_NUMBER));
            request.getSession().setAttribute(PARAM_NAME_GROUP_NUMBER, groupNum);
            request.getSession().setAttribute(PARAM_NAME_COURSE_NUMBER, courseNum);
        } catch (Exception e) {
            groupNum = (int) request.getSession().getAttribute(PARAM_NAME_GROUP_NUMBER);
            courseNum = (int) request.getSession().getAttribute(PARAM_NAME_COURSE_NUMBER);
        }
        String subgroupNum = request.getParameter(PARAM_NAME_SUBGROUP);
        try {
            Validator<User> userValidator = ValidationFactory.createValidator(User.class);
            User user = userValidator.validate(request);
            UserService userService = factory.createService(UserService.class);
            if (userService.isLoginPresented(user.getLogin())) {
                request.setAttribute("message", "Пользователь с таким логином уже существует");
                LOGGER.warn(String.format("Incorrect data was found when user \"%s\" tried to add user: login %s is already presented", getAuthorizedUser().getLogin(), user.getLogin()));
                return null;
            }
            user.setRole(Role.STUDENT);
            user.setPassword(new char[]{'1', '1', '1', '1', '1'});
            if (userService.create(user) != -1) {
                // группа
                GroupService groupService = factory.createService(GroupService.class);
                Group group = groupService.findByGroupAndCourse(groupNum, courseNum).orElse(null);
                // подгруппа
                SubgroupService subgroupService = factory.createService(SubgroupService.class);
                Subgroup subgroup = subgroupService.findBySubgroupNumberAndGroupId(subgroupNum.charAt(0), group.getId()).orElse(null);
                // студент
                Student student = new Student(user, subgroup);
                StudentService studentService = factory.createService(StudentService.class);
                if (studentService.create(student) != -1) {
                    Forward forward = new Forward("/students/concreteGroup.html");
                    forward.getAttributes().put("message",
                            "Новый студент был успешно добавлен");
                    forward.getAttributes().put("groupNum", groupNum);
                    forward.getAttributes().put("courseNum", courseNum);
                    forward.getAttributes().put("pageNumber", 1);
                    LOGGER.info(String.format("New student \"%s\" with identity %d has been added successfully",
                            student.getUser().getLogin(), student.getId()));
                    return forward;
                }
            }
        } catch (ValidationException e) {
            if (request.getParameter("surname") != null) {
                request.setAttribute("message", "Некорректные данные");
                LOGGER.warn(String.format("Incorrect data was found when user \"%s\" tried to add user: validation error", getAuthorizedUser().getLogin()), e);
            }
            return null;
        }
        request.setAttribute("message",
                "Произошла ошибка ввода данных");
        LOGGER.warn(String.format("Incorrect data was found when user \"%s\" tried to add new student",
                authorizedUser.getLogin()));
        return null;
    }
}

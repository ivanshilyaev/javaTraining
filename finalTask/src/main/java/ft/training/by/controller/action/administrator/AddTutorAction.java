package ft.training.by.controller.action.administrator;

import ft.training.by.bean.Tutor;
import ft.training.by.bean.User;
import ft.training.by.bean.enums.Role;
import ft.training.by.service.exception.ServiceException;
import ft.training.by.service.interfaces.TutorService;
import ft.training.by.service.interfaces.UserService;
import ft.training.by.validator.ValidationFactory;
import ft.training.by.validator.Validator;
import ft.training.by.validator.exception.ValidationException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddTutorAction extends AdministratorAction {
    private static final Logger LOGGER = LogManager.getLogger();

    private static final String PARAM_NAME_POSITION = "position";
    private static final String PARAM_NAME_DEGREE = "degree";

    @Override
    public Forward exec(HttpServletRequest request, HttpServletResponse response) throws ServiceException {
        String position = request.getParameter(PARAM_NAME_POSITION);
        String degree = request.getParameter(PARAM_NAME_DEGREE);

        try {
            Validator<User> userValidator = ValidationFactory.createValidator(User.class);
            User user = userValidator.validate(request);
            UserService userService = factory.createService(UserService.class);
            if (userService.isLoginPresented(user.getLogin())) {
                request.setAttribute("message", "Пользователь с таким логином уже существует");
                LOGGER.warn(String.format("Incorrect data was found when user \"%s\" tried to add user: login %s is already presented", getAuthorizedUser().getLogin(), user.getLogin()));
                return null;
            }
            user.setRole(Role.TUTOR);
            user.setPassword(new char[]{'1', '1', '1', '1', '1'});
            if (userService.create(user) != -1) {
                Tutor tutor = new Tutor(user, position, degree);
                TutorService tutorService = factory.createService(TutorService.class);
                if (tutorService.create(tutor) != -1) {
                    Forward forward = new Forward("/tutors/listTutors.html");
                    forward.getAttributes().put("message",
                            "Новый преподаватель был успешно добавлен");
                    forward.getAttributes().put("pageNumber", 1);
                    LOGGER.info(String.format("New tutor \"%s\" with identity %d has been added successfully",
                            tutor.getUser().getLogin(), tutor.getId()));
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
        LOGGER.warn(String.format("Incorrect data was found when user \"%s\" tried to add new tutor",
                getAuthorizedUser().getLogin()));
        return null;
    }
}

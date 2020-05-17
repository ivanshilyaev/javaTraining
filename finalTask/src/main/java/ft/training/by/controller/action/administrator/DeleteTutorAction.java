package ft.training.by.controller.action.administrator;

import ft.training.by.bean.Tutor;
import ft.training.by.service.exception.ServiceException;
import ft.training.by.service.interfaces.TutorService;
import ft.training.by.service.interfaces.UserService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Comparator;
import java.util.List;

public class DeleteTutorAction extends AdministratorAction {
    private static final Logger LOGGER = LogManager.getLogger();

    private static final String PARAM_NAME_ID = "tutorId";

    @Override
    public Forward exec(HttpServletRequest request, HttpServletResponse response) throws ServiceException {
        try {
            int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
            request.setAttribute("pageNumber", pageNumber);
        } catch (NumberFormatException e) {
            request.setAttribute("pageNumber", 1);
        }
        TutorService tutorService = factory.createService(TutorService.class);
        List<Tutor> listTutors = tutorService.read();
        listTutors.sort(Comparator.comparing(tutor -> tutor.getUser().getSurname()));
        request.setAttribute("listTutors", listTutors);

        String tutorId = request.getParameter(PARAM_NAME_ID);
        if (tutorId != null) {
            int id = Integer.parseInt(tutorId);
            Tutor tutor = tutorService.read(id).orElse(null);
            int userId = tutor.getUser().getId();
            if (tutorService.deleter(id)) {
                UserService userService = factory.createService(UserService.class);
                if (userService.delete(userId)) {
                    Forward forward = new Forward("/tutors/listTutors.html");
                    forward.getAttributes().put("message",
                            "Преподаватель был успешно удалён");
                    LOGGER.info(String.format("User \"%s\" deleted user with identity %d", getAuthorizedUser().getLogin(), id));
                    return forward;
                }
            }
            request.setAttribute("message",
                    "Ошибка при попытке удалить преподавателя");
            LOGGER.warn(String.format("Incorrect data was found when user \"%s\" tried to delete user", getAuthorizedUser().getLogin()));
        }
        return null;
    }
}

package ft.training.by.controller.action.administrator;

import ft.training.by.bean.Tutor;
import ft.training.by.service.exception.ServiceException;
import ft.training.by.service.interfaces.TutorService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Comparator;
import java.util.List;

public class FindAllTutorsAction extends AdministratorAction {
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
        return null;
    }
}

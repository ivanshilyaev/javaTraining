package ft.training.by.controller.action.administrator;

import ft.training.by.bean.Group;
import ft.training.by.bean.Student;
import ft.training.by.bean.Subgroup;
import ft.training.by.service.exception.ServiceException;
import ft.training.by.service.interfaces.GroupService;
import ft.training.by.service.interfaces.StudentService;
import ft.training.by.service.interfaces.SubgroupService;
import ft.training.by.service.interfaces.UserService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class DeleteStudentAction extends AdministratorAction {
    private static final Logger LOGGER = LogManager.getLogger();

    private static final String PARAM_NAME_ID = "studentId";
    private static final String PARAM_NAME_GROUP_NUMBER = "groupNum";
    private static final String PARAM_NAME_COURSE_NUMBER = "courseNum";

    @Override
    public Forward exec(HttpServletRequest request, HttpServletResponse response) throws ServiceException {
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
        try {
            int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
            request.setAttribute("pageNumber", pageNumber);
        } catch (NumberFormatException e) {
            request.setAttribute("pageNumber", 1);
        }
        GroupService groupService = factory.createService(GroupService.class);
        Group group = groupService.findByGroupAndCourse(groupNum, courseNum).orElse(null);
        SubgroupService subgroupService = factory.createService(SubgroupService.class);
        List<Subgroup> subgroups = subgroupService.findByGroupId(group.getId());
        StudentService studentService = factory.createService(StudentService.class);
        List<Student> groupList = new ArrayList<>();
        for (Subgroup subgroup : subgroups) {
            groupList.addAll(studentService.findBySubgroupId(subgroup.getId()));
        }
        groupList.sort(Comparator.comparing(student -> student.getUser().getSurname()));
        request.setAttribute("groupList", groupList);

        String studentId = request.getParameter(PARAM_NAME_ID);
        if (studentId != null) {
            int id = Integer.parseInt(studentId);
            Student student = studentService.read(id).orElse(null);
            int userId = student.getUser().getId();

            boolean studentDeleted = studentService.delete(id);
            if (studentDeleted) {
                UserService userService = factory.createService(UserService.class);
                boolean userDeleted = userService.delete(userId);
                if (userDeleted) {
                    Forward forward = new Forward("/students/concreteGroup.html");
                    forward.getAttributes().put("message",
                            "Студент был успешно удалён");
                    forward.getAttributes().put("groupNum", groupNum);
                    forward.getAttributes().put("courseNum", courseNum);
                    forward.getAttributes().put("pageNumber", 1);
                    LOGGER.info(String.format("User \"%s\" deleted user with identity %d", getAuthorizedUser().getLogin(), id));
                    return forward;
                }
            }
            request.setAttribute("message",
                    "Ошибка при попытке удалить студента");
            LOGGER.warn(String.format("Incorrect data was found when user \"%s\" tried to delete user", getAuthorizedUser().getLogin()));
        }
        return null;
    }
}

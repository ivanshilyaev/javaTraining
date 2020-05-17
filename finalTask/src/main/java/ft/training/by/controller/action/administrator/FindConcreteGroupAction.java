package ft.training.by.controller.action.administrator;

import ft.training.by.bean.Group;
import ft.training.by.bean.Student;
import ft.training.by.bean.Subgroup;
import ft.training.by.service.exception.ServiceException;
import ft.training.by.service.interfaces.GroupService;
import ft.training.by.service.interfaces.StudentService;
import ft.training.by.service.interfaces.SubgroupService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class FindConcreteGroupAction extends AdministratorAction {
    private static final String PARAM_NAME_GROUP_NUMBER = "groupNum";
    private static final String PARAM_NAME_COURSE_NUMBER = "courseNum";

    @Override
    public Forward exec(HttpServletRequest request, HttpServletResponse response) throws ServiceException {
        int groupNum;
        int courseNum;
        try {
            groupNum = Integer.parseInt(request.getParameter(PARAM_NAME_GROUP_NUMBER));
            courseNum = Integer.parseInt(request.getParameter(PARAM_NAME_COURSE_NUMBER));
            request.setAttribute("groupNum", groupNum);
            request.setAttribute("courseNum", courseNum);
        } catch (NumberFormatException e) {
            groupNum = (int) request.getAttribute(PARAM_NAME_GROUP_NUMBER);
            courseNum = (int) request.getAttribute(PARAM_NAME_COURSE_NUMBER);
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
        return null;
    }
}

package ft.training.by.controller.action.student;

import ft.training.by.bean.Student;
import ft.training.by.service.interfaces.StudentService;
import ft.training.by.service.exception.ServiceException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class FindGroupStudentsAction extends StudentAction {
    @Override
    public Forward exec(HttpServletRequest request, HttpServletResponse response) throws ServiceException {
        StudentService studentService = factory.createService(StudentService.class);
        Student student = (Student) request.getSession().getAttribute("authorizedStudent");
        List<Student> groupList = studentService.findByGroupCourseFaculty(student.getSubgroup().getGroup().getGroupNumber(),
                student.getSubgroup().getGroup().getCourseNumber());
        request.setAttribute("groupList", groupList);
        return null;
    }
}

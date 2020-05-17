package ft.training.by.controller.action.tutor;

import ft.training.by.bean.Group;
import ft.training.by.bean.Timetable;
import ft.training.by.bean.TimetableGroup;
import ft.training.by.bean.Tutor;
import ft.training.by.service.exception.ServiceException;
import ft.training.by.service.interfaces.GroupService;
import ft.training.by.service.interfaces.TimetableGroupService;
import ft.training.by.service.interfaces.TimetableService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

public class FindAllClassesAction extends TutorAction {
    @Override
    public Forward exec(HttpServletRequest request, HttpServletResponse response) throws ServiceException {
        try {
            int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
            request.setAttribute("pageNumber", pageNumber);
        } catch (NumberFormatException e) {
            request.setAttribute("pageNumber", 1);
        }
        Tutor tutor = (Tutor) request.getSession().getAttribute("authorizedTutor");
        TimetableService timetableService = factory.createService(TimetableService.class);
        List<Timetable> timetableList = timetableService.findByTutorId(tutor.getId());
        List<Group> groupList = new ArrayList<>();
        TimetableGroupService timetableGroupService = factory.createService(TimetableGroupService.class);
        GroupService groupService = factory.createService(GroupService.class);
        for (Timetable timetable : timetableList) {
            List<TimetableGroup> timetableGroups = timetableGroupService.findByTimetableId(timetable.getId());
            Group group = groupService.read(timetableGroups.get(0).getSubgroup().getGroup().getId()).orElse(null);
            groupList.add(group);
        }
        request.setAttribute("timetableList", timetableList);
        request.setAttribute("groupList", groupList);
        return null;
    }
}

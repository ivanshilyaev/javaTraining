package ft.training.by.controller;

import ft.training.by.controller.action.*;
import ft.training.by.controller.action.administrator.*;
import ft.training.by.controller.action.student.FindGroupStudentsAction;
import ft.training.by.controller.action.student.PerformanceAction;
import ft.training.by.controller.action.student.ScheduleAction;
import ft.training.by.controller.action.student.StudentMainAction;
import ft.training.by.controller.action.tutor.FindAllClassesAction;
import ft.training.by.controller.action.tutor.TutorMainAction;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class ActionFromUriFilter implements Filter {
    private static final Logger LOGGER = LogManager.getLogger();

    private static Map<String, Action> actions = new ConcurrentHashMap<>();

    static {
        /*
         * В зависимости от того, на какой путь мы идём,
         * вызывается нужный обработчик (Action)
         */
        actions.put("/", new UnauthorizedUserAction());
        actions.put("/index", new MainAction());
        actions.put("/login", new LoginAction());
        actions.put("/logout", new LogoutAction());
        actions.put("/password", new ChangePasswordAction());

        // student
        actions.put("/studentCabinet", new StudentMainAction());
        actions.put("/search/group", new FindGroupStudentsAction());
        actions.put("/study/schedule", new ScheduleAction());
        actions.put("/study/performance", new PerformanceAction());

        // administrator
        actions.put("/adminCabinet", new AdministratorMainAction());
        actions.put("/search/listUsers", new FindAllUsersAction());
        actions.put("/tutors/listTutors", new FindAllTutorsAction());

        actions.put("/students/listGroups", new FindAllGroupsAction());
        actions.put("/students/concreteGroup", new FindConcreteGroupAction());
        actions.put("/students/addStudent", new AddStudentAction());
        actions.put("/students/deleteStudent", new DeleteStudentAction());

        actions.put("/tutors/addTutor", new AddTutorAction());
        actions.put("/tutors/deleteTutor", new DeleteTutorAction());

        // tutor
        actions.put("/tutorCabinet", new TutorMainAction());
        actions.put("/search/listClasses", new FindAllClassesAction());
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        if (servletRequest instanceof HttpServletRequest) {
            HttpServletRequest httpRequest = (HttpServletRequest) servletRequest;
            String contextPath = httpRequest.getContextPath();
            String uri = httpRequest.getRequestURI();
            LOGGER.debug(String.format("Starting to process request for URI \"%s\"", uri));
            int beginAction = contextPath.length();
            int endAction = uri.lastIndexOf('.');
            String actionName;
            if (endAction >= 0) {
                actionName = uri.substring(beginAction, endAction);
            } else {
                actionName = uri.substring(beginAction);
            }
            try {
                Action action = actions.get(actionName);
                action.setName(actionName);
                httpRequest.setAttribute("action", action);
                filterChain.doFilter(servletRequest, servletResponse);
            } catch (NullPointerException e) {
                LOGGER.error("Impossible to create action handler object", e);
                httpRequest.setAttribute("error", String.format("Requested address %s can't be processed by the server", uri));
                httpRequest.getServletContext().getRequestDispatcher("/WEB-INF/jsp/error404.jsp").forward(servletRequest, servletResponse);
            }
        } else {
            LOGGER.error("Impossible to use HTTP filter");
            servletRequest.getServletContext().getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(servletRequest, servletResponse);
        }
    }

    @Override
    public void destroy() {

    }
}

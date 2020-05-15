package ft.training.by.controller;

import ft.training.by.bean.User;
import ft.training.by.bean.enums.Role;
import ft.training.by.controller.action.Action;
import ft.training.by.controller.action.MainAction;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Set;

public class SecurityFilter implements Filter {
    private static Logger LOGGER = LogManager.getLogger();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        if (request instanceof HttpServletRequest && response instanceof HttpServletResponse) {
            HttpServletRequest httpRequest = (HttpServletRequest) request;
            HttpServletResponse httpResponse = (HttpServletResponse) response;
            Action action = (Action) httpRequest.getAttribute("action");
            Set<Role> allowedRoles = action.getAllowedRoles();
            String userName = "unauthorized user";
            HttpSession session = httpRequest.getSession(false);
            User user = null;
            if (session != null) {
                user = (User) session.getAttribute("authorizedUser");
                action.setAuthorizedUser(user);
                String errorMessage = (String) session.getAttribute("SecurityFilterMessage");
                if (errorMessage != null) {
                    httpRequest.setAttribute("message", errorMessage);
                    session.removeAttribute("SecurityFilterMessage");
                }
            }
            /*
             * Исправить это место, когда появятся общие действия,
             * которые возможны для неавторизированных пользователей.
             */
            boolean canExecute = (allowedRoles == null);
            if (user != null) {
                userName = "\"" + user.getLogin() + "\" user";
                canExecute = canExecute ||
                        (allowedRoles.contains(user.getRole()));
            }
            if (canExecute) {
                chain.doFilter(request, response);
            } else {
                if (allowedRoles.isEmpty()) {
                    httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.html");
                } else {
                    LOGGER.info(String.format("Trying of %s access forbidden resource \"%s\"", userName, action.getName()));
                    if (session != null && action.getClass() != MainAction.class) {
                        session.setAttribute("SecurityFilterMessage", "Access is forbidden");
                    }
                    request.setAttribute("error", "Access denied");
                    request.getServletContext().getRequestDispatcher("/WEB-INF/jsp/error403.jsp").forward(request, response);
                }
            }
        } else {
            LOGGER.error("Impossible to use HTTP filter");
            request.getServletContext().getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
        }
    }

    @Override
    public void destroy() {
    }
}

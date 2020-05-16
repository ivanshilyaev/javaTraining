package ft.training.by.controller;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(filterName = "CookieLocaleFilter", urlPatterns = {"*.html"})
public class CookieLocaleFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse res = (HttpServletResponse) servletResponse;

        if (req.getParameter("cookieLocale") != null) {
            Cookie cookie = new Cookie("language", req.getParameter("cookieLocale"));
            res.addCookie(cookie);
        } else {
            Cookie[] cookies = req.getCookies();
            if (cookies == null || cookies.length == 0) {
                Cookie cookie = new Cookie("language", "ru_BY");
                res.addCookie(cookie);
            } else {
                boolean notPresented = true;
                for (Cookie cookie : cookies) {
                    res.addCookie(cookie);
                    if (cookie.getName().equals("language")) notPresented = false;
                }
                if (notPresented) {
                    Cookie cookie = new Cookie("language", "ru_BY");
                    res.addCookie(cookie);
                }
            }
        }
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {
    }
}

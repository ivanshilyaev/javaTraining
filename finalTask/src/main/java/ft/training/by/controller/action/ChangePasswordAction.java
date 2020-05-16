package ft.training.by.controller.action;

import ft.training.by.bean.User;
import ft.training.by.service.PasswordUtilities;
import ft.training.by.service.interfaces.UserService;
import ft.training.by.service.exception.ServiceException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ChangePasswordAction extends AuthorizedUserAction {
    private static final Logger LOGGER = LogManager.getLogger();

    private static final String PARAM_NAME_OLD_PASSWORD = "old_password";
    private static final String PARAM_NAME_NEW_PASSWORD = "new_password";
    private static final String PARAM_NAME_NEW_PASSWORD_AGAIN = "new_password_again";

    @Override
    public Forward exec(HttpServletRequest request, HttpServletResponse response) throws ServiceException {
        String oldPassword = request.getParameter(PARAM_NAME_OLD_PASSWORD);
        String newPassword = request.getParameter(PARAM_NAME_NEW_PASSWORD);
        String newPasswordAgain = request.getParameter(PARAM_NAME_NEW_PASSWORD_AGAIN);
        if (oldPassword != null && newPassword != null && newPasswordAgain != null) {
            User currentUser = (User) request.getSession().getAttribute("authorizedUser");
            UserService userService = factory.createService(UserService.class);
            User user = userService.read(currentUser.getId()).orElse(null);
            if (!PasswordUtilities.verifyPassword(oldPassword, String.valueOf(user.getPassword()))) {
                // "Old password was entered incorrectly"
                request.setAttribute("passwordMessage", "Старый пароль был введён неверно");
                return null;
            }
            if (!newPassword.equals(newPasswordAgain)) {
                // "New password was repeated incorrectly"
                request.setAttribute("passwordMessage", "Новый пароль был повторён неверно");
                return null;
            }
            if (oldPassword.equals(newPassword)) {
                // "You've entered the same password"
                request.setAttribute("passwordMessage", "Вы ввели тот же самый пароль");
                return null;
            }
            currentUser.setPassword(newPassword.toCharArray());
            userService.update(currentUser);
            return new Forward("/logout.html");
        }
        return null;
    }
}

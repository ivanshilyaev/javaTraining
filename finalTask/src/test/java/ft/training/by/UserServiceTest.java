package ft.training.by;

import ft.training.by.bean.User;
import ft.training.by.bean.enums.Role;
import ft.training.by.controller.Runner;
import ft.training.by.service.PasswordUtilities;
import ft.training.by.service.exception.ServiceException;
import ft.training.by.service.impl.ServiceFactoryImpl;
import ft.training.by.service.interfaces.ServiceFactory;
import ft.training.by.service.interfaces.UserService;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

import static org.testng.Assert.assertEquals;

public class UserServiceTest {
    private UserService userService;

    @BeforeClass
    public void init() {
        try {
            Runner.initConnectionPool();
            ServiceFactory serviceFactory = new ServiceFactoryImpl();
            userService = serviceFactory.createService(UserService.class);
        } catch (ServiceException e) {
            e.printStackTrace();
        }
    }

    @DataProvider(name = "createPositiveDataForUserTest")
    public Object[] createPositiveDataForUserTest() throws ServiceException {
        return new Object[][]{
                {
                        new User(26, "1823127", PasswordUtilities.hashPassword("11111").orElse(null).toCharArray(),
                                Role.STUDENT, "Шиляев", "Иван", "Владимирович"),
                        userService.read(26).get()
                }
        };
    }

    @Test(description = "Positive scenario of finding concrete user",
            dataProvider = "createPositiveDataForUserTest")
    public void testGroup(User expected, User actual) {
        assertEquals(expected, actual);
    }
}

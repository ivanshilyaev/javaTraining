package ft.training.by;

import static org.testng.Assert.assertEquals;

import ft.training.by.bean.Group;
import ft.training.by.controller.Runner;
import ft.training.by.service.interfaces.GroupService;
import ft.training.by.service.interfaces.ServiceFactory;
import ft.training.by.service.impl.ServiceFactoryImpl;
import ft.training.by.service.exception.ServiceException;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

public class GroupServiceTest {
    private GroupService groupService;

    @BeforeClass
    public void init() {
        try {
            Runner.initConnectionPool();
            ServiceFactory serviceFactory = new ServiceFactoryImpl();
            groupService = serviceFactory.createService(GroupService.class);
        } catch (ServiceException e) {
            e.printStackTrace();
        }
    }

    @DataProvider(name = "createPositiveDataForGroupTest")
    public Object[] createPositiveDataForGroupTest() throws ServiceException {
        return new Object[][]{
                {
                        new Group(1, 9, 2),
                        groupService.read(1).get()
                }
        };
    }

    @Test(description = "Positive scenario of finding all groups",
            dataProvider = "createPositiveDataForGroupTest")
    public void testGroup(Group expected, Group actual) {
        assertEquals(expected, actual);
    }
}

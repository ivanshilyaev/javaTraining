package ft.training.by.controller;

import ft.training.by.dao.exception.DAOException;
import ft.training.by.dao.pool.ConnectionPool;
import ft.training.by.service.exception.ServiceException;
import ft.training.by.service.impl.ServiceFactoryImpl;
import ft.training.by.service.interfaces.*;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class Runner {
    private static final Logger LOGGER = LogManager.getLogger();

    public static final String DB_URL = "jdbc:mysql://localhost:3306/account_db";
    public static final String DB_LOGIN = "application";
    public static final String DB_PASSWORD = "application_password";
    public static final int DB_POOL_START_ACTIVE = 10;
    public static final int DB_POOL_MAX_ACTIVE = 1000;
    public static final int DB_POOL_MAX_WAIT = 0;

    public static void initConnectionPool() {
        try {
            ConnectionPool.getInstance().init(DB_URL,
                    DB_LOGIN, DB_PASSWORD, DB_POOL_START_ACTIVE,
                    DB_POOL_MAX_ACTIVE, DB_POOL_MAX_WAIT);
        } catch (DAOException e) {
            LOGGER.error(e);
        }
    }

    public static void main(String[] args) {
        initConnectionPool();
        try {
            ServiceFactory factory = new ServiceFactoryImpl();
            GroupService service = factory.createService(GroupService.class).orElseThrow(ServiceException::new);
            System.out.println(service.read(1));
            LOGGER.info("success");
        } catch (ServiceException e) {
            LOGGER.error("Service exception in main method", e);
        }
    }
}

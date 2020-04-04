package ft.training.by.service;

import ft.training.by.bean.User;
import ft.training.by.service.exception.ServiceException;

import java.util.List;
import java.util.Optional;

public interface UserService extends Service {
    List<User> findAll() throws ServiceException;

    Optional<User> findEntityById(Integer id) throws ServiceException;

    Optional<User> findByLoginAndPassword(String login, char[] password) throws ServiceException;
}

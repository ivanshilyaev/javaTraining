package ft.training.by.service;

import ft.training.by.bean.Classroom;
import ft.training.by.dao.ClassroomDao;
import ft.training.by.dao.exception.DAOException;
import ft.training.by.service.exception.ServiceException;

import java.util.List;

public class ClassroomServiceImpl extends ServiceImpl implements ClassroomService {
    @Override
    public List<Classroom> findAll() throws ServiceException {
        try {
            ClassroomDao dao = transaction.createDao(ClassroomDao.class);
            return dao.findAll();
        } catch (DAOException e) {
            throw new ServiceException(e);
        }
    }
}
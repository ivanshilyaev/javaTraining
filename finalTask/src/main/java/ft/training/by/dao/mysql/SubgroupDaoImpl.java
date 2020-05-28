package ft.training.by.dao.mysql;

import ft.training.by.bean.Group;
import ft.training.by.bean.Subgroup;
import ft.training.by.dao.interfaces.SubgroupDao;
import ft.training.by.dao.exception.DAOException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class SubgroupDaoImpl extends DaoImpl implements SubgroupDao {
    private static final Logger LOGGER = LogManager.getLogger();

    private static final String SQL_SELECT_ALL_SUBGROUPS =
            "SELECT id, subgroup_number, group_id FROM subgroup;";

    private static final String SQL_SELECT_SUBGROUP_BY_ID =
            "SELECT id, subgroup_number, group_id FROM subgroup WHERE id = ?;";

    private static final String SQL_SELECT_SUBGROUP_BY_NUMBER_AND_GROUP_ID =
            "SELECT id, subgroup_number, group_id FROM subgroup " +
                    "WHERE subgroup_number = ? AND group_id = ?;";

    private static final String SQL_SELECT_SUBGROUPS_BY_GROUP_ID =
            "SELECT id, subgroup_number, group_id FROM subgroup WHERE group_id = ?;";

    @Override
    public Integer create(Subgroup entity) {
        return BAD_CREATION_CODE;
    }

    @Override
    public List<Subgroup> read() throws DAOException {
        List<Subgroup> subgroups = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(SQL_SELECT_ALL_SUBGROUPS)) {
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Subgroup subgroup = new Subgroup();
                fillSubgroup(resultSet, subgroup);
                subgroups.add(subgroup);
            }
            resultSet.close();
        } catch (SQLException e) {
            LOGGER.error("DB connection error", e);
        }
        return subgroups;
    }

    @Override
    public Optional<Subgroup> read(Integer id) throws DAOException {
        Subgroup subgroup = null;
        try (PreparedStatement statement = connection.prepareStatement(SQL_SELECT_SUBGROUP_BY_ID)) {
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                subgroup = new Subgroup();
                fillSubgroup(resultSet, subgroup);
            }
            resultSet.close();
        } catch (SQLException throwables) {
            LOGGER.error("DB connection error", throwables);
        }
        return Optional.ofNullable(subgroup);
    }

    @Override
    public void update(Subgroup entity) {
    }

    @Override
    public boolean delete(Integer id) {
        return false;
    }

    @Override
    public Optional<Subgroup> findBySubgroupNumberAndGroupId(char subgroupNum, Integer id) throws DAOException {
        Subgroup subgroup = null;
        try (PreparedStatement statement = connection.prepareStatement(SQL_SELECT_SUBGROUP_BY_NUMBER_AND_GROUP_ID)) {
            statement.setString(1, String.valueOf(subgroupNum));
            statement.setInt(2, id);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                subgroup = new Subgroup();
                fillSubgroup(resultSet, subgroup);
            }
            resultSet.close();
        } catch (SQLException throwables) {
            LOGGER.error("DB connection error", throwables);
        }
        return Optional.ofNullable(subgroup);
    }

    @Override
    public List<Subgroup> findByGroupId(Integer id) throws DAOException {
        List<Subgroup> subgroups = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(SQL_SELECT_SUBGROUPS_BY_GROUP_ID)) {
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Subgroup subgroup = new Subgroup();
                fillSubgroup(resultSet, subgroup);
                subgroups.add(subgroup);
            }
        } catch (SQLException throwables) {
            LOGGER.error("DB connection error", throwables);
        }
        return subgroups;
    }

    private void fillSubgroup(ResultSet resultSet, Subgroup subgroup) throws SQLException, DAOException {
        subgroup.setId(resultSet.getInt(1));
        subgroup.setSubgroupNumber(resultSet.getString(2).charAt(0));
        int groupID = resultSet.getInt(3);
        GroupDaoImpl groupDao = new GroupDaoImpl();
        groupDao.setConnection(connection);
        Group group = groupDao.read(groupID).orElse(null);
        subgroup.setGroup(group);
    }
}

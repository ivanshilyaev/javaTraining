package ft.training.by.bean;

import ft.training.by.bean.enums.Role;
import java.util.Arrays;
import java.util.Objects;

public class User extends Entity {
    private String login;
    private char[] password;
    private Role role;
    private String surname;
    private String name;
    private String patronymic;

    public User() {
    }

    public User(int id) {
        super(id);
    }

    public User(String login, char[] password, Role role,
                String surname, String name, String patronymic) {
        this.login = login;
        this.password = password;
        this.role = role;
        this.surname = surname;
        this.name = name;
        this.patronymic = patronymic;
    }

    public User(int id, String login, char[] password, Role role,
                String surname, String name, String patronymic) {
        super(id);
        this.login = login;
        this.password = password;
        this.role = role;
        this.surname = surname;
        this.name = name;
        this.patronymic = patronymic;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public char[] getPassword() {
        return password;
    }

    public void setPassword(char[] password) {
        this.password = password;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPatronymic() {
        return patronymic;
    }

    public void setPatronymic(String patronymic) {
        this.patronymic = patronymic;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return Objects.equals(login, user.login) &&
                Arrays.equals(password, user.password) &&
                role == user.role &&
                Objects.equals(surname, user.surname) &&
                Objects.equals(name, user.name) &&
                Objects.equals(patronymic, user.patronymic);
    }

    @Override
    public int hashCode() {
        int result = Objects.hash(login, role, surname, name, patronymic);
        result = 31 * result + Arrays.hashCode(password);
        return result;
    }

    @Override
    public String toString() {
        return "User{" +
                "id='" + getId() + '\'' +
                ", login='" + login + '\'' +
                ", password=" + Arrays.toString(password) +
                ", role=" + role +
                ", surname='" + surname + '\'' +
                ", name='" + name + '\'' +
                ", patronymic='" + patronymic + '\'' +
                '}';
    }
}

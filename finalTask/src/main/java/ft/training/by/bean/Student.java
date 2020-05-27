package ft.training.by.bean;

import java.util.Objects;

/**
 * The {@code Student} class;
 */

public class Student extends Entity {
    private User user;
    private Subgroup subgroup;

    public Student() {
    }

    public Student(int id) {
        super(id);
    }

    public Student(User user, Subgroup subgroup) {
        this.user = user;
        this.subgroup = subgroup;
    }

    public Student(int id, User user, Subgroup subgroup) {
        super(id);
        this.user = user;
        this.subgroup = subgroup;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Subgroup getSubgroup() {
        return subgroup;
    }

    public void setSubgroup(Subgroup subgroup) {
        this.subgroup = subgroup;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Student student = (Student) o;
        return user.equals(student.user) &&
                subgroup.equals(student.subgroup);
    }

    @Override
    public int hashCode() {
        return Objects.hash(user, subgroup);
    }

    @Override
    public String toString() {
        return "Student{" +
                "id=" + getId() +
                ", user=" + user +
                ", subgroup=" + subgroup +
                '}';
    }
}

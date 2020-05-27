package ft.training.by.bean;

import java.io.Serializable;
import java.util.Objects;

/**
 * The {@code Entity} class is the root of the entity class hierarchy.
 * Every entity class which is represented in the project and stored
 * in a database has {@code Entity} as a superclass.
 *
 * @version 1.0
 * @since 2020-05-18
 */

public abstract class Entity implements Serializable, Cloneable {
    /**
     * This is a unique filed every Entity, stored in a database, should have.
     */
    private int id;

    /**
     * Constructor with no params.
     */
    public Entity() {
    }

    /**
     * Constructor with id param.
     *
     * @param id unique entity field.
     */
    public Entity(int id) {
        this.id = id;
    }

    /**
     * Getter for id filed.
     *
     * @return id of a given entity.
     */
    public int getId() {
        return id;
    }

    /**
     * Setter for id filed.
     *
     * @param id param should be unique.
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Overridden method of the {@code Object} class.
     * Indicates whether some other entity is "equal to" this one.
     *
     * @param o the reference entity with which to compare.
     * @return {@code true} if this object is the same as the obj argument;
     * {@code false} otherwise.
     * @see #hashCode()
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Entity entity = (Entity) o;
        return id == entity.id;
    }

    /**
     * Overridden method of the {@code Object} class.
     *
     * @return hashcode of a given entity.
     */
    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}

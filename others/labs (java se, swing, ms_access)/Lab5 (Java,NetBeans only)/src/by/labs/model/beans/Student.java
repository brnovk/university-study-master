package by.labs.model.beans;

/**
 * Студент.
 */
public class Student {

    private int id;
    private String surname;
    private Group group;

    public Student(int id, String surname, Group group) {
        this.id = id;
        this.surname = surname;
        this.group = group;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public Group getGroup() {
        return group;
    }

    public void setGroup(Group group) {
        this.group = group;
    }    
}

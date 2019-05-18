package by.labs.model.beans;

/**
 * Учебная группа.
 */
public class Group {

    private final int id;
    private final String name;
    private final int course;

    public Group(int id, String name, int course) {
        this.id = id;
        this.name = name;
        this.course = course;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getCourse() {
        return course;
    }
}

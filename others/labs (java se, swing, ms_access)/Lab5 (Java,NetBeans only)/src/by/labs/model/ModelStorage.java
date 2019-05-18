package by.labs.model;

import static by.labs.constants.Constants.*;

import by.labs.model.beans.Group;
import by.labs.model.beans.Student;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

/**
 * Класс хранения и обработки модели данных.
 */
public class ModelStorage {
    
    private final List<String> cources;     // курсы
    private final List<Group> groups;       // группы
    private final List<Student> students;   // студенты
    
    public ModelStorage() {
        // Инициализация курсов (6)
        cources = new ArrayList<>();
        for (int i=0; i < COURSE_COUNT;) {
            cources.add(String.valueOf(++i));
        }
        // Инициализация групп (по 5 групп ПОИТ на каждый курс)
        groups = new ArrayList<>();
        for (int cource = 0, id=0; cource < cources.size(); cource++) {
            for (int group = 0; group < NUMBER_GROUPS_ON_COURSE; group++) {
                groups.add(new Group(id++, 
                    String.format(GROUP_PATTERN, cource+1, group+1), cource+1));
            }
        }
        students = new ArrayList<>();
    }

    public List<String> getCources() {
        return cources;
    }
    
    public List<Group> getGroupsByCourse(int cource) {
        List<Group> result = new ArrayList<>();
        for (Group group : groups) {
            if (group.getCourse() == cource) {
                result.add(group);
            }
        }
        return result;
    }
    
    public List<String> getGroupListByCourse(int cource) {
        List<String> result = new ArrayList<>();
        for (Group group : groups) {
            if (group.getCourse() == cource) {
                result.add(group.getName());
            }
        }
        return result;
    }
    
    public List<Student> getStudents() {
        return students;
    }
    
    public void addStudent(String surname, String group) {
        int freeId = 0;
        for (Student current : students) {
            if (current.getId() >= freeId) {
                freeId = current.getId()+1;
            }
        }
        Group insertGroup = null;
        for (Group current : groups) {
            if (current.getName().trim().equals(group.trim())) {
                insertGroup = current;
            }
        }
        if (insertGroup == null) {
            throw new IllegalArgumentException();
        }
        students.add(new Student(freeId, surname, insertGroup));
    }
    
    public void randomGenerationStudents() {
        students.clear();
        Random random = new Random();
        for (int i=0; i<COUNT_RANDOM_SURNAMES; i++) {
            String surname = RANDOM_SURNAME_LIST[
                    random.nextInt(RANDOM_SURNAME_LIST.length)];
            Group group = groups.get(random.nextInt(groups.size()));
            students.add(new Student(i, surname, group));
        }
    }
    
    public List<Student> getStudentsByCourse(int course) {
        List<Student> result = new ArrayList<>();
        for (Student student : students) {
            if (student.getGroup().getCourse() == course) {
                result.add(student);
            }
        }
        return result;
    }
    
    /**
     * Получение строки содержащей список однофамильцев.
     * @param course
     * @return 
     */
    public String getNamesakesByCourse(int course) {
        final String NEWLINE = "\n";
        final String START_LINE_GROUP = " - ";
        StringBuilder result = new StringBuilder();
        List<Student> source = getStudentsByCourse(course);
        
        Set<String> founded = new HashSet<>();
        for (int i=0; i<source.size(); i++) {
            for (int j=i+1; j<source.size()-1; j++) {
                String firstSurname = source.get(i).getSurname();
                String secondSurname = source.get(j).getSurname();
                if (firstSurname.equals(secondSurname)) {
                    founded.add(firstSurname);
                }
            }
        }
        if (founded.isEmpty()) {
            return NAMESAKES_EMPTY;
        }
        for (String current : founded) {
            result.append(current).append(":").append(NEWLINE);
            for (Student student : source) {
                String surname = student.getSurname();
                if (current.equals(surname)) {
                    result.append(START_LINE_GROUP);
                    result.append(student.getGroup().getName()).append(NEWLINE);
                }
            }
        }
        return result.toString().trim();
    }
}

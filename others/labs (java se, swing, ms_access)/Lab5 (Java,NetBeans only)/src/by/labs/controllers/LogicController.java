package by.labs.controllers;

import by.labs.model.ModelStorage;
import static by.labs.constants.Constants.*;
import by.labs.view.MainWindow;

import java.util.List;
import javax.swing.JFrame;
import javax.swing.JOptionPane;

/**
 * Контроллер приложения.
 */
public class LogicController {
    
    private MainWindow view;
    private final ModelStorage model;

    public LogicController(ModelStorage model) {
        this.model = model;
    }

    public void setView(MainWindow view) {
        this.view = view;
    }
    
    /**
     * Первичная инициализация курсов в модели и в окне.
     */
    public void initialiseCources() {
        view.fillingAddCourceCombobox(model.getCources());
        view.fillingCheckedCourceCombobox(model.getCources());
    }
    
    /**
     * Заполнение jCombobox в окне, в зависимости от выбранного курса.
     * @param cource 
     */
    public void updateAddCourse(int cource) {
        List<String> groups = model.getGroupListByCourse(cource);
        view.fillingAddGroupCombobox(groups);
    }
    
    public void addStudent(String surname, String group) {
        model.addStudent(surname, group);
        showStudents();
    }

    /**
     * Заполнение случайными значениями списка студентов.
     */
    public void randomStudentsGeneration() {
        model.randomGenerationStudents();
        showStudents();
    }
    
    /**
     * Отображение таблицы студентов.
     */
    public void showStudents() {
        view.fillingTableStudents(model.getStudents());
    }
    
    /**
     * Поиск однофамильцев и отображение результатов.
     * @param cource 
     */
    public void showNamesakes(int cource) {
        view.setLabelResult(String.format(LABEL_NAMESAKES, cource));
        view.setResultList(model.getNamesakesByCourse(cource));
    }
    
    /**
     * Отображение MessageDialog'а с заданием к лабораторной.
     */
    public void showAboutMessage() {
        JOptionPane.showMessageDialog(new JFrame(), ABOUT_MESSAGE,
            ABOUT_MESSAGE_HEADER, JOptionPane.INFORMATION_MESSAGE);
    }
}

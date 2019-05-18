import by.labs.controllers.LogicController;
import by.labs.model.ModelStorage;
import by.labs.view.MainWindow;

/**
 * Лабораторная №5.
 * 
 * Разработать ПС с оптимальной структурой данных.
 * Составить программу для нахождения на курсе групп, в которых учатся студенты,
 * имеющие одинаковые фамилии.
 */
public class Runner {

    public static void main(String[] args) {
        
        // Создание объекта класса для работы с моделью данных.
        ModelStorage model = new ModelStorage();
        
        // Создание контроллера приложения.
        LogicController controller = new LogicController(model);
        
        // Создание и инициализация представления
        MainWindow.initialView(controller);
    }
}

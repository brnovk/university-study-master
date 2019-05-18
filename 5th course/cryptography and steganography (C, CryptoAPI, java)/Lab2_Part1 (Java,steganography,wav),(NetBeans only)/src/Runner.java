import by.gsu.lab.controller.MainController;
import by.gsu.lab.model.Model;
import by.gsu.lab.view.MainWindow;

/**
 * Класс запуска приложения.
 * @author Viktor Baranov
 */
public class Runner {
    
    public static void main(String args[]) {
        
        // Создание контроллера.
        MainController controller = new MainController();
        
        // Создание представления.
        MainWindow.inintialAndshowWindow(controller);
        
        // Создание модели.
        Model model = new Model(controller);
        controller.setModel(model);
    }
}

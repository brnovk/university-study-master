import by.gsu.lab.model.enums.SourceType;
import by.gsu.lab.model.enums.OrderSymbolType;
import by.gsu.lab.model.Logic;
import by.gsu.lab.view.MainWindow;
import by.gsu.lab.controller.MainController;

/**
 * Задача:
 * Реализовать стеганографическую передачу информации с помощью метода 
 * генерации текстового контейнера из слов, в которых заданная буква 
 * совпадает с внедряемой. Номер буквы: 4.
 * 
 * @author Viktor Baranov
 */
public class Runner {

    public static void main(String[] args) {
        
        final SourceType initialSourceType = SourceType.USER_INPUT_FIELD;
        final OrderSymbolType initialOrderType = OrderSymbolType.FOURTH;

        // Создание контроллера.
        MainController controller = new MainController();

        // Создание представления.
        MainWindow.inintialAndshowWindow(controller, initialSourceType,
                initialOrderType);

        // Создание модели.
        Logic model = new Logic(controller, initialSourceType,
                initialOrderType);
        controller.setLogic(model);
    }
}
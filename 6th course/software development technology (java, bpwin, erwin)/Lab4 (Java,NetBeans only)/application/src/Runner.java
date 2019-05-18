import by.gsu.labs.controllers.LogicController;
import by.gsu.labs.view.MainWindow;

/**
 * Лабораторная №4, Вариант 4.
 * 
 * Разработать ПС и протестировать в нормальных, экстремальных и исключительных
 * ситуациях.
 * 
 * Вычислить значение определённого интеграла методом трапеций с точностью ε.
 * Сделать графическую интерпретацию результата.
 * 
 * Подынтегральная функция: (x / (x^4 + 3x^2 + 2))dx.
 * 
 * @author Victor Baranov
 */
public class Runner {
   
    public static void main(String[] args) {
        
        // Создание контроллера приложения.
        LogicController controller = new LogicController();
        
        // Создание и инициализация представления
        MainWindow.initializing(controller);
        
    }
}
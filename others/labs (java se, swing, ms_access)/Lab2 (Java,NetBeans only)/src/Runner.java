import by.labs.controllers.LogicController;
import by.labs.math.SequenceHandler;
import by.labs.view.MainWindow;

/**
 * Лабораторная №2.
 * 
 * Разработать ПС, представленное по правилам хорошего стиля программирования.
 * 
 * Сгенерировать три последовательности по 30 случайных чисел каждая.
 * Числа в каждой последовательности равномерно распределены в диапазонах
 * от 0 до 5, от 2 до 8, от 4 до 10.
 * 
 * Свести их в один массив, расположив по возрастанию.
 * 
 * Для сформированного массива вычислить среднее значение, дисперсию и вывести
 * результаты на печать в виде гистограммы, разбив диапазон на 10 интервалов.
 */
public class Runner {

    public static void main(String[] args) {
        
        // Создание контроллера приложения.
        LogicController controller = new LogicController();
        
        // Создание и инициализация представления
        MainWindow.initializing(controller);
        
        // Создание объекта класса для работы с последовательностями.
        controller.setSequenceHandler(new SequenceHandler());
    }
}

import by.gsu.labs.controllers.LogicController;
import by.gsu.labs.math.SequenceHandler;
import by.gsu.labs.view.MainWindow;

/**
 * Лабораторная №2, Вариант 4.
 * 
 * Разработать ПС, представленное по правилам хорошего стиля программирования.
 * 
 * Сгенерировать последовательность 100 случайных чисел X(i) с экспоненциальным
 * (показательным) законом распределения с параметром λ (lambda)=0,1.
 * 
 * Сформировать новую последовательность, состоящую из элементов:
 * Y(i) = Y(i-1) + X(i), где Y(1) == X(1).
 * 
 * Для полученной последовательности вычислить среднее значение, дисперсию и
 * вывести последовательность на печать в виде гистограммы, разделив диапазон
 * на 10 интервалов.
 * 
 * @author Viktor Baranov
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

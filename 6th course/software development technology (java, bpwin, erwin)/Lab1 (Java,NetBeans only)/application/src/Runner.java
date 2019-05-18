import by.gsu.labs.view.MainWindow;
import by.gsu.labs.math.SquareCalculateHelper;

/**
 * Лабораторная №1, Вариант 4.
 * 
 * Разработать ПС, в котором присутствовали бы некоторые критерии и примитивы
 * качественного программного обеспечения.
 * Имеется арифметический квадрат:
 *  1   1   1   1   1   1   … 
 *  1   2   3   4   5   6   … 
 *  1   3   6   10  15  21  … 
 *  1   4   10  20  35  56  … 
 * Найти n(i,j) член квадрата.
 * 
 * @author Viktor Baranov
 */
public class Runner {
    
    public static void main(String[] args) {

        // Создание класса helper'а для вычисления арифметического квадрата.
        SquareCalculateHelper calculateHelper = new SquareCalculateHelper();

        // Создание и инициализации класса главного окна приложения.
        MainWindow.initializeView(calculateHelper);
    }
}

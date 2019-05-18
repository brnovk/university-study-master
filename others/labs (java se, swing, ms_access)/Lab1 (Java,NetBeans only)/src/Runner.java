import by.labs.math.DivisorCalculateHelper;
import by.labs.view.MainWindow;

/**
 * Лабораторная №1.
 * 
 * Разработать ПС, в котором присутствовали бы некоторые критерии и примитивы
 * качественного программного обеспечения.
 * Найдите все делители заданного числа 'n'.
 */
public class Runner {

    public static void main(String[] args) {
        
        // Создание класса helper'а для вычисления делителей.
        DivisorCalculateHelper calculateHelper = new DivisorCalculateHelper();
        
        // Создание и инициализации класса главного окна приложения.
        MainWindow.initializeView(calculateHelper);
    }
}

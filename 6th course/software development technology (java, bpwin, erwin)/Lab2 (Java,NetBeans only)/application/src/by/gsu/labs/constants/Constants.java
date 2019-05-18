package by.gsu.labs.constants;

/**
 * Класс хранения строковых литералов и констант приложения.
 * @author Viktor Baranov
 */
public class Constants {
    
    
    public static final int SIZE = 100;
    public static final int RANGE_COUNT = 10;
    public static final double LAMBDA = 0.1D;
    
    public static final String FLOAT_PATTERN = "%.2f";
    public static final String NEWLINE = "\n";
        
    public static final String ABOUT_MESSAGE_HEADER = 
        "Задание к лабораторной №2";
    
    public static final String ABOUT_MESSAGE = "Вариант 4\nГруппа: ПОИТ-61\n"
        + "Студент: Баранов В.Ф.\n\nТребуется разработать ПС, представленное "
        + "по правилам\nхорошего стиля программирования.\n\nСгенерировать "
        + "последовательность 100 случайных чисел X(i)\nс экспоненциальным"
        + "(показательным) законом распределения\nс параметром λ (lambda) "
        + "= 0,1.\n\nСформировать новую последовательность, состоящую из\n"
        + "элементов:\nY(i) = Y(i-1) + X(i), где Y(1) == X(1).\n\n" 
        + "Для полученной последовательности вычислить среднее значение,\n"
        + "дисперсию и вывести последовательность на печать в виде\n"
        + "гистограммы, разделив диапазон на 10 интервалов.";
    
    
    // <editor-fold defaultstate="collapsed" desc="MainWindow constants">    
    
    public static final String RANGE_TOOLTIP = "Диапазон ";
    
    public static final String MAIN_WINDOW_TITLE = 
        "Lab2 [ТРПО, ПОИТ-61, Вариант 4, Баранов В.Ф.]";
    
    public static final String BUTTON_MENU = "Задание";
    
    public static final String AVERAGE_LABEL = "Среднее значение:";
    public static final String DISPERSION_LABEL = "Дисперсия:";
    public static final String EXPONENTIAL_COLUMN_LABEL = 
        "<html>Показательное<br>распределение:</html>";
    public static final String RESULTING_COLUMN_LABEL = 
            "<html>Вычисленная<br>последовательность:</html>";

    // </editor-fold>
    
}
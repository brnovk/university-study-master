package by.labs.constants;

/**
 * Класс хранения строковых литералов и констант приложения.
 */
public class Constants {
    
    public static final double FIRST_SEQ_LOW_RANGE = 0D;
    public static final double FIRST_SEQ_HIGH_RANGE = 5D;
    public static final double SECOND_SEQ_LOW_RANGE = 2D;
    public static final double SECOND_SEQ_HIGH_RANGE = 8D;
    public static final double THIRD_SEQ_LOW_RANGE = 4D;
    public static final double THIRD_SEQ_HIGH_RANGE = 10D;
    
    public static final int SIZE_SOURCE_SEQUENCE = 30;
    public static final int COUNT_SOURCE_SEQUENCE = 3;
    
    public static final int VIEW_SEGMENTS_COUNT = 10;
    public static final int VIEW_NUMBERS_IN_SEGMENTS = 
        (SIZE_SOURCE_SEQUENCE * COUNT_SOURCE_SEQUENCE) / VIEW_SEGMENTS_COUNT;
    
    
    public static final String FLOAT_PATTERN = "%.2f";
    public static final String NEWLINE = "\n";
        
    public static final String ABOUT_MESSAGE_HEADER = 
        "Задание к лабораторной №2";
    
    public static final String ABOUT_MESSAGE = 
        "Требуется разработать ПС, представленное по правилам\n"
        + "хорошего стиля программирования.\n\n"
        + "Сгенерировать 3 последовательности по 30 случайных чисел.\n"
        + "Числа в каждой последовательности равномерно распределены\n"
        + "в диапазонах от 0 до 5, от 2 до 8, от 4 до 10.\n\n"   
        + "Свести их в один массив, расположив по возрастанию.\n\n"
        + "Для сформированного массива вычислить среднее значение,\n"
        + "дисперсию и вывести результаты на печать в виде\n"
        + "гистограммы, разбив диапазон на 10 интервалов.\n\n";
    
    
    // <editor-fold defaultstate="collapsed" desc="MainWindow constants">    
    
    public static final String RANGE_TOOLTIP = "Диапазон ";
    
    public static final String MAIN_WINDOW_TITLE = 
        "Lab2";
    
    public static final String BUTTON_MENU = "Задание";
    
    public static final String AVERAGE_LABEL = "Среднее значение:";
    public static final String DISPERSION_LABEL = "Дисперсия:";
    
    public static final String FIRST_SOURCE_COLUMN_LABEL = 
            "<html>1-ых тридцать:<br>(с 0 до 5)</html>";
    public static final String SECOND_SOURCE_COLUMN_LABEL = 
            "<html>2-ых тридцать:<br>(с 2 до 8)</html>";
    public static final String THIRD_SOURCE_COLUMN_LABEL = 
            "<html>3-их тридцать:<br>(с 4 до 10)</html>";
    public static final String RESULTING_COLUMN_LABEL = 
            "<html>Вычисленная<br>последовательность:</html>";

    // </editor-fold>
    
}

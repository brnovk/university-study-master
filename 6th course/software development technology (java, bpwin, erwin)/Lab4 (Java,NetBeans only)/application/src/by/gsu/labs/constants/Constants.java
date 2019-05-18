package by.gsu.labs.constants;

/**
 *
 * @author Viktor Baranov
 */
public class Constants {
    
    /**
     * https://www.codecogs.com/latex/eqneditor.php
     * LaTEX-форма интеграла.
     */
    public static final String LATEX_PATTERN = 
            "\\int_{a}^{b}\\frac{x}{x^{4}+3 x^{2}+2}dx";
    
    public static final String ERROR_MESSAGE_HEADER = 
        "Сообщение об ошибке";
    
    public static final String ABOUT_MESSAGE_HEADER = 
        "Задание к лабораторной №4";
    
    public static final String ABOUT_MESSAGE = "Вариант 4\nГруппа: ПОИТ-61\n"
        + "Студент: Баранов В.Ф.\n\nТребуется разработать ПС и протестировать "
        + "в нормальных,\nэкстремальных и исключительных  ситуациях.\n\n"
        + "Вычислить значение определённого интеграла\nметодом трапеций с "
        + "точностью ε.\nСделать графическую интерпретацию результата.";
    
    public static final String EMPTY_STRING = "";
    
    public static final String CHART_LEGEND_PATTERN = "Знаков после запятой(ε):"
        + " %d, Количество шагов: %d, Размер шага: %.2f, a: %.2f, b: %.2f";
    
    public static final String ERROR_HIGH_LOW_LIMIT = "Верхний предел должен "
        + "быть больше нижнего предела";
        
    // <editor-fold defaultstate="collapsed" desc="Validate constants">    

    public static final String EMPTY_LOW_LIMIT = "Не указан нижний предел";
    
    public static final String ILLEGAL_LOW_LIMIT = 
            "Некорректный параметр нижнего предела";
    
    public static final String EMPTY_HIGH_LIMIT = "Не указан верхний предел";
    
    public static final String ILLEGAL_HIGH_LIMIT = 
            "Некорректный параметр верхнего предела";
    
    public static final String EMPTY_SUB_INTERVAL_COUNT = 
            "Не указано количество подынтервалов";
    
    public static final String ILLEGAL_SUB_INTERVAL_COUNT = 
            "Некорректный параметр количества подынтервалов";
    
    public static final String ILLEGAL_RANGE_SUB_INTERVAL_COUNT = 
            "Минимальное количество подынтервалов: 2";
    
    public static final int RANGE_MIN_SUB_INTERVAL_COUNT = 2;

    public static final String EMPTY_DIGITS_AFTER_POINT = 
            "Не указано количество знаков после запятой";
    
    public static final String ILLEGAL_DIGITS_AFTER_POINT = 
            "Некорректный параметр количества знаков после запятой";
    
    public static final String ILLEGAL_RANGE_DIGITS_AFTER_POINT = 
            "Количество знаков после запятой может быть от 0 до 50";
    
    public static final int RANGE_MIN_DIGITS_AFTER_POINT = 0;
    
    public static final int RANGE_MAX_DIGITS_AFTER_POINT = 50;
  
    // </editor-fold>
    
    // <editor-fold defaultstate="collapsed" desc="MainWindow constants">    

    public static final String MAIN_WINDOW_TITLE = 
        "Lab4 [ТРПО, ПОИТ-61, Вариант 4, Баранов В.Ф.]";
    
    public static final String BUTTON_MENU = "Задание";
    
    public static final String BUTTON_CALCULATE = "Пересчитать";
    
    public static final String LABEL_LOW_LIMIT = "Нижний предел (a):";
    
    public static final String LABEL_HIGH_LIMIT = "Верхний предел (b):";
    
    public static final String LABEL_SUB_INTERVAL_COUNT = 
            "Количество подынтервалов:";
    
    public static final String LABEL_DIGITS_AFTER_POINT = 
            "Знаков после запятой (ε):";
    
    public static final String LABEL_RESULT = "Результат:";

    // </editor-fold>
}

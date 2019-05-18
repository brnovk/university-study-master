package by.labs.constants;

/**
 * Класс хранения строковых литералов и констант приложения.
 */
public class Constants {
    
    public static final String ABOUT_MESSAGE_HEADER = 
        "Задание к лабораторной №4";

    public static final String ABOUT_MESSAGE = 
        "Построить синтаксический анализатор для понятия геом. фигур.\n"
        + "Геометрические фигуры: прямоугольник, трапеция\n"
        + "Прямоугольник::={вершина, вершина, вершина, вершина}\n"
        + "Трапеция::={вершина, вершина, вершина, вершина}\n"
        + "Вершина::={абсцисса, ордината}\n"
        + "Абсцисса::={число с точкой}\n"
        + "Ордината::={число с точкой}\n"
        + "Число с точкой::={пробел | +- | целое без знака.целое без знака}";
    
    // Для генератора случайных значений
    public static final int R_COUNT = 6;
    public static final int R_MIN = -10;
    public static final int R_MAX = 10;
    
    public static final String EMPTY_STRING = "";
    public static final String FLOAT_PATTERN = "%.2f";
    public static final String COMMA = ",";
    public static final String SEMICOLON = ";";
    public static final String OPEN_BRACKET = "(";
    public static final String CLOSE_BRACKET = ")";
    public static final String EQUALS_SIGN = "=";
    public static final String NEWLINE = "\n";
    
    public static final String POINT_PATTERN = "(X=%.2f; Y=%.2f)";
    public static final String QUADRILATERAL_PATTERN = 
            " A: %s, B: %s, C: %s, D: %s";
    
    // Регулярки очистки введённых данных от пробелов
    public static final String REGEX_NBSP = "\\u00A0+";
    public static final String REGEX_SPICE_WITHOUT_NEWLINE = "[^\\S^\\r\\n]+";
    
    // Сообщения для вывода
    public static final String MESSAGE_NEEDLESS_ANALYZE 
            = "Нечего анализировать...\n";
    public static final String STATEMENT_NOT_EXPECTED = 
            "Данный оператор\"%s\" (позиция %d) не ожидался.";
    
    public static final String RECTANGLES_FOUND = "Прямоугольников найдено: ";
    public static final String TRAPEZIUM_FOUND = "\nТрапеций найдено: ";
    public static final String UNCERTAINTY_QUADRANGLES_FOUND = 
            "\nНеопределённых четырёхугольников, которые не являются\n"
                + "трапецией или прямоугольником, найдено: ";
    
    public static final String OPERAND_ERROR = "Ошибка анализа операндов.\n"
            + "Неопознанный символ: \"%s\" (%d-ый символ)";
    
    // <editor-fold defaultstate="collapsed" desc="MainWindow constants">    

    public static final String MAIN_WINDOW_TITLE = 
        "Lab4";
    
    public static final String BUTTON_MENU = "Задание";
    
    public static final String BUTTON_CALCULATE = "Пересчитать";
    
    public static final String BUTTON_RANDOM = "Случайная генерация";
    
    public static final String LABEL_SOURCE = "Исходное выражение:";
    
    public static final String LABEL_RESULT = "Результат:";
    
    public static final String CARET_POSITION = "Позиция текущего символа: ";

    // </editor-fold>
}

package by.gsu.constants;

/**
 * @author Viktor Baranov
 */
public class Constants {
    
    public static final String EMPTY_STRING = "";
    public static final char RESULT_MESSAGE_DELIMETER = ' ';
    public static final String EXTENSION_SEPARATOR = ".";
    public static final String TXT_FILE_EXTENSION_DESCRIPTION = "TXT File";
    public static final String TXT_FILE_EXTENSION = "txt";
    
    public static final String WORDS_SPLIT_PATTERN = 
            "(-*'*[^\\pL\\w\\d'-]+-*'*)+";
    
    // <editor-fold defaultstate="collapsed" desc="Messages literals">
    
    public static final String ERROR_MESSAGE_HEADER = "Сообщение об ошибке";
    public static final String ILLEGAL_SYMBOL_INDEX = "Недопустимый индекс "
        + "позиции символа: ";
    public static final String EMPTY_LETTER_IN_SET = "В наборе данных "
        + "отсутствует слово с %d буквой \"%s\"";

    public static final String EMPTY_MESSAGE_FIELD = "Пустое поле сообщения";
    public static final String EMPTY_DATA_FIELD = "Пустое поле данных";
    public static final String EMPTY_PATH_TO_FILE = "Путь к файлу пустой";
    public static final String EMPTY_PATH_TO_CATALOG= "Путь к каталогу пустой";
    
    public static final String INCORRECT_PATH_TO_FILE = 
            "Некорректный путь к файлу";
    public static final String INCORRECT_PATH_TO_CATALOG = 
            "Некорректный путь к каталогу.";
    public static final String INCORRECT_EXTENSION = 
            "Неверное расширение файла";
    
    public static final String ERROR_FILE_ENCODING = 
            "Ошибочная кодировка файла!";
    public static final String ERROR_NO_TXT_FILES = 
            "В каталоге нет ни одного txt-файла.";
    
    
    public static final String ABOUT_MESSAGE_HEADER = 
        "Задание к лабораторной 2.2";
    
    public static final String ABOUT_MESSAGE = "Вариант 4\nГруппа: ПОИТ-51\n"
        + "Студент: Баранов В.\n\nТребуется реализовать стеганографическую "
        + "передачу информации\nс помощью метода генерации текстового "
        + "контейнера из слов,\nв которых заданная буква совпадает "
        + "с внедряемой.\nНомер буквы: 4.";
    
    // </editor-fold>
    
    // <editor-fold defaultstate="collapsed" desc="MainWindow literals">
    
    public static final String FORM_TITLE = 
            "ЗИРКСиС [Lab2 Part2, Baranov]";
    public static final String MENU_BUTTON = "Задание";
    
    public static final String BUTTON_CLEAR = "Очистить";
    public static final String BUTTON_OPEN_CATALOG = "Выбрать";
    public static final String BUTTON_OPEN_FILE = "Выбрать";
    public static final String BUTTON_GENERATED = "Генерировать";
    public static final String BUTTON_COPY = "Копировать";
    
    public static final String LABEL_ORDER_LETTER_WORD = "Позиция внедряемой "
        + "буквы в слове:";
    public static final String LABEL_MESSAGE = "Внедряемое сообщение:";
    public static final String LABEL_SOURCE = "Источник слов для контейнера:";
    
    public static final String RADIO_FILE = "Текстовый файл:";
    public static final String RADIO_CATALOG = "Каталог с файлами:";
    public static final String RADIO_USER_INPUT = "Поле ввода:";
    
    // </editor-fold>
    
}
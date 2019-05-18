package by.gsu.lab.constants;

/**
 * @author Viktor Baranov
 */
public class Constants {
    
    public static final double MES_PROPORTION = 3.7D;
    public static final String EMPTY_STRING = "";
    public static final String WAV_EXTENSION = "wav";
    public static final String EXTENSION_SEPARATOR = ".";
    public static final String MINIMAL_COUNT_SYMBOLS = "0";
    public static final String WAV_DIALOG_TOOLTIP = "WAV File";
    
    // <editor-fold defaultstate="collapsed" desc="Messages literals">
    
    public static final String ERROR_MESSAGE_HEADER = "Сообщение об ошибке";
    public static final String TASK_MESSAGE_HEADER = 
            "Задание к лабораторной 2.1";
    
    public static final String TASK_MESSAGE = "Вариант: 4\nГруппа: ПОИТ-51\n"
        + "Студент: Баранов В.\n\nТребуется реализовать стеганографическое "
        + "внедрение\nсообщений с помощью метода LSB в аудио контейнер."
        + "\nКоличество внедряемых в каждую позицию контейнера битов: 1.";
    
    public static final String SUCCESS_MESSAGE_HEADER = "Success!";
    public static final String SUCCESS_EMBED_MESSAGE = "Встраивание текста в "
        + "файл успешно завершено";
    public static final String SUCCESS_EXTRACT_MESSAGE = "Извлечение текста из "
        + "файла успешно завершено";
    
    public static final String EMPTY_DATA_FIELD = "Не заполнено поле данных";
    public static final String EMPTY_PATH_TO_FILE = "Не указан путь к файлу";
    public static final String INCORRECT_PATH_TO_OPEN_FILE = 
        "Некоректный путь к исходному wav-файлу";
    public static final String INCORRECT_DIRECTORY_SAVE = 
        "Некорректная директория для сохранения";
    public static final String INCORRECT_FILENAME_SAVE = 
        "Некорректное имя файла для сохранения";
    public static final String INCORRECT_EXTENSION = 
        "Неверное расширение файла";
    public static final String ERROR_GETTING_PATH = "Ошибка получения пути";
    
    public static final String ERROR_LONG_MESSAGE = "Текст для этого файла "
        + "длиннее допустимого.\nМаксимальное количество символов для этого "
        + "файла: ";
    
    public static final String ERROR_WRITE_RESULT = "Ошибка записи "
        + "результирующего файла";
    
    // </editor-fold>
    
    // <editor-fold defaultstate="collapsed" desc="MainWindow literals">
    
    public static final String FORM_TITLE = "ЗИРКСиС [Lab2 Part1, Baranov]";
    public static final String MENU_BUTTON = "Задание";
    
    public static final String BUTTON_CLEAR = "Очистить";
    public static final String BUTTON_OPEN_CATALOG = "Открыть каталог с файлом";
    public static final String BUTTON_EMBED = "Встроить текст";
    public static final String BUTTON_EXTRACT = "Извлечь текст";
    public static final String BUTTON_CHOISE_FILE_OPEN = "Выбрать файл";
    public static final String BUTTON_CHOISE_FILE_SAVE = 
        "Выбрать файл для сохранения";
    
    public static final String TAB_EMBED = "Встраивание текста в файл";
    public static final String TAB_EXTRACT = "Извлечение текста из файла";
    
    public static final String LABEL_EMBED_FILE_OPEN = 
            "Исходный WAV-файл:";
    public static final String LABEL_EMBED_FILE_SAVE = 
            "Результирующий WAV-файл, в который будет встроен текст:";
    public static final String LABEL_EXTRACT_FILE_OPEN = 
            "Исходный WAV-файл со встроенным текстом:";
    public static final String LABEL_LENGTH_TEXT = "Длина текста:";
    
    // </editor-fold>
    
}
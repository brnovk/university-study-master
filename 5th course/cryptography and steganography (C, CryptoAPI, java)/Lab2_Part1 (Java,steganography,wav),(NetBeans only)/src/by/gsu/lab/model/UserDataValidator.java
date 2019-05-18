package by.gsu.lab.model;

import java.awt.Desktop;
import java.io.*;
import java.util.regex.*;

import by.gsu.lab.exceptions.ValidationException;
import static by.gsu.lab.constants.Constants.*;

/**
 * @author Viktor Baranov
 */
public class UserDataValidator {
    
    void dataValidation(String data) throws ValidationException {
        if (EMPTY_STRING.equals(data.trim())) {
            throw new ValidationException(EMPTY_DATA_FIELD);
        }
    }
    
    void pathOpenFileValidation(String filePath) throws IOException,
            ValidationException {
        if (EMPTY_STRING.equals(filePath.trim())) {
            throw new ValidationException(EMPTY_PATH_TO_FILE);
        }
        File file = new File(filePath);
        if (!(file.getCanonicalPath().equals(filePath))) {
            throw new ValidationException(INCORRECT_PATH_TO_OPEN_FILE);
        }
    }
    
    void pathSaveFileValidation(String filePath) throws IOException,
            ValidationException {
        if (EMPTY_STRING.equals(filePath.trim())) {
            throw new ValidationException(EMPTY_PATH_TO_FILE);
        }
        File directory = getDirectory(filePath);
        if (!directory.isDirectory() || !directory.exists()) {
            throw new ValidationException(INCORRECT_DIRECTORY_SAVE);
        }
        String fileName = new File(filePath).getName();
        if (!isValidWavFileName(fileName)) {
            throw new ValidationException(INCORRECT_FILENAME_SAVE);
        }
    }
    
    void extentionFileValidation(String filePath) throws ValidationException {
        int dot = filePath.lastIndexOf(EXTENSION_SEPARATOR);
        if (!WAV_EXTENSION.equals(filePath.substring(dot+1).toLowerCase())) {
            throw new ValidationException(INCORRECT_EXTENSION);
        }
    }
    
    File getDirectory(String filePath) throws IOException,ValidationException {
        String absolutePath = new File(filePath).getAbsolutePath();
        File directory = new File(absolutePath.substring(0, 
                absolutePath.lastIndexOf(File.separator) + 1));
        if (Desktop.isDesktopSupported()) {
            return directory;
        } else {
            throw new ValidationException(ERROR_GETTING_PATH);
        }
    }
    
    boolean isValidWavFileName(String text) {
        
        final String PATTERN_VALID_WIN_NAME = 
            "^(?!(?:CON|PRN|AUX|NUL|COM[1-9]|LPT[1-9])(?:\\.[^.]*)?$)" +
            "[^<>:\"/\\\\|?*\\x00-\\x1F]*[^<>:\"/\\\\|?*\\x00-\\x1F\\ .]$";
        
        final String PATTERN_WAV_EXTENSION = "^.+\\.(wav)$";
        
        // Валидность имени в Windows системах
        Pattern pattern = Pattern.compile(PATTERN_VALID_WIN_NAME, 
            Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE);
        Matcher matcher = pattern.matcher(text);
        boolean isMatch = matcher.matches();
        if (!isMatch) {
            return false;
        }

        // Валидность расширения wav
        text = text.trim();
        pattern = Pattern.compile(PATTERN_WAV_EXTENSION, 
                Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE);
        matcher = pattern.matcher(text);
        isMatch = matcher.matches();
        return isMatch;
    }
}

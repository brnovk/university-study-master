package by.gsu.lab.model.sources;

import by.gsu.lab.model.exceptions.ValidationException;
import by.gsu.lab.model.exceptions.GeneratorException;
import by.gsu.lab.model.FileHandler;
import by.gsu.lab.model.CharsetDetector;
import java.nio.charset.Charset;
import java.util.*;
import java.io.*;

import by.gsu.lab.model.enums.OrderSymbolType;

import static by.gsu.constants.Constants.*;

/**
 * @author Viktor Baranov
 */
public class SourceSingleFile extends AbstractSource {

    private final String path;

    public SourceSingleFile(String message, String path) {
        super(message);
        this.path = path;
    }

    @Override
    public Map<Character, HashSet<String>> generate(OrderSymbolType orderType) 
            throws GeneratorException {
        try {
            Charset charset = 
                    new CharsetDetector().detectCharset(new File(path));
            if (charset == null) {
                throw new GeneratorException(ERROR_FILE_ENCODING);
            }
            String data = FileHandler.read(path, charset);
            return mapGenerator(orderType, data);
        } catch (IOException ex) {
            throw new GeneratorException(ex);
        }
    }   

    @Override
    public void dataValidation() throws ValidationException {
        if (EMPTY_STRING.equals(message.trim())) {
            throw new ValidationException(EMPTY_MESSAGE_FIELD);
        }
        if (EMPTY_STRING.equals(path.trim())) {
            throw new ValidationException(EMPTY_PATH_TO_FILE);
        }
        File file = new File(path);
        if(!file.exists() || file.isDirectory()) {
            throw new ValidationException(INCORRECT_PATH_TO_FILE);
        }
        int dot = path.lastIndexOf(EXTENSION_SEPARATOR);
        if (!TXT_FILE_EXTENSION.equals(path.substring(dot+1).toLowerCase())) {
            throw new ValidationException(INCORRECT_EXTENSION);
        }
    }
}
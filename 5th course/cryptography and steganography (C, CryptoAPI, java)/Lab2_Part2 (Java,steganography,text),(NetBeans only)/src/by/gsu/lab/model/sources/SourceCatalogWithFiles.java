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
public class SourceCatalogWithFiles extends AbstractSource {

    private final String path;

    public SourceCatalogWithFiles(String message, String path) {
        super(message);
        this.path = path;
    }

    @Override
    public Map<Character, HashSet<String>> generate(OrderSymbolType orderType) 
            throws GeneratorException{
        final String UNSUPPORTED_ENCODING = 
                "Кодировка файла \"%s\" не поддерживается программой.";
        try {
            File[] txtFiles = FileHandler.listTXTFilesForFolder(new File(path));
            if (txtFiles == null) {
                throw new GeneratorException(INCORRECT_PATH_TO_CATALOG);
            }
            if (txtFiles.length == 0) {
                throw new GeneratorException(ERROR_NO_TXT_FILES);
            }
            StringBuilder builder = new StringBuilder();
            for (File currentTxt : txtFiles) {
                CharsetDetector charserDetector = new CharsetDetector();
                Charset charset = charserDetector.detectCharset(currentTxt);
                if (charset == null) {
                    throw new GeneratorException(
                            String.format(UNSUPPORTED_ENCODING, currentTxt));
                }
                builder.append(FileHandler.read(currentTxt.getCanonicalPath(),
                        charset));
            }
            return mapGenerator(orderType, builder.toString());
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
            throw new ValidationException(EMPTY_PATH_TO_CATALOG);
        }
        File directory = new File(path);
        if (!directory.exists() || !directory.isDirectory()) {
            throw new ValidationException(INCORRECT_PATH_TO_CATALOG);
        }
    }
}
package by.gsu.lab.model;

import java.io.*;
import java.nio.charset.Charset;

import static by.gsu.constants.Constants.*;

/**
 * @author Viktor Baranov
 */
public class FileHandler {

    public static String read(String path, Charset charset)
            throws IOException {
        final char LINE_DELIMETER = ' ';
        StringBuilder builder = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(
                new FileInputStream(path), charset))) {
            String line;
            while ((line = reader.readLine()) != null) {
                builder.append(line);
                builder.append(LINE_DELIMETER);
            }
            return builder.toString();
        }
    }
    
    public static File[] listTXTFilesForFolder(final File directory) {
        final String EXTENSION = EXTENSION_SEPARATOR + TXT_FILE_EXTENSION;
        if (!directory.isDirectory()) {
            return null;
        }
        @SuppressWarnings("Convert2Lambda")
        File[] files = directory.listFiles(new FilenameFilter() {
            @Override
            public boolean accept(File directory, String name) {
                return name.endsWith(EXTENSION);
            }
        });
        return files;
    }
}
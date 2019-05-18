package by.gsu.lab.model;

import java.io.*;
import java.nio.charset.Charset;
import org.mozilla.universalchardet.UniversalDetector;
 
/**
 * Враппер для работы с библиотекой UniversalDetector
 * {@link http://code.google.com/p/juniversalchardet/ }
 */
public class CharsetDetector {

    public Charset detectCharset(File file) throws IOException {
        UniversalDetector detector = null;
        byte[] buf = new byte[4096];
        try (FileInputStream inputStream = new FileInputStream(file)) {
            detector = new UniversalDetector(null);
            int nread;
            while ((nread = inputStream.read(buf)) > 0 && !detector.isDone()) {
              detector.handleData(buf, 0, nread);
            }
            detector.dataEnd();
/*  
 Canonical Name for java.nio API
 https://docs.oracle.com/javase/8/docs/technotes/guides/intl/encoding.doc.html
 */        
            String encoding = detector.getDetectedCharset();
            return (encoding != null) ? Charset.forName(encoding) : null;
        } finally {
            if (detector != null) {
                detector.reset();
            }
        }
    }
}
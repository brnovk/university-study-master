package by.gsu.lab.exceptions;

/**
 * @author Viktor Baranov
 */
public class SteganographyException extends Exception {

    public SteganographyException() {
    }

    public SteganographyException(String message) {
        super(message);
    }

    public SteganographyException(Throwable cause) {
        super(cause);
    }

    public SteganographyException(String message, Throwable cause) {
        super(message, cause);
    }
}
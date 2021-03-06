package by.gsu.lab.model.exceptions;

/**
 * @author Viktor Baranov
 */
@SuppressWarnings("serial")
public class ValidationException extends Exception {

    public ValidationException() {
    }

    public ValidationException(String message) {
        super(message);
    }

    public ValidationException(Throwable cause) {
        super(cause);
    }

    public ValidationException(String message, Throwable cause) {
        super(message, cause);
    }
}
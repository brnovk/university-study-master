package by.gsu.lab.model.exceptions;

/**
 * @author Viktor Baranov
 */
@SuppressWarnings("serial")
public class GeneratorException extends Exception {

    public GeneratorException() {
    }

    public GeneratorException(String message) {
        super(message);
    }

    public GeneratorException(Throwable cause) {
        super(cause);
    }

    public GeneratorException(String message, Throwable cause) {
        super(message, cause);
    }
}

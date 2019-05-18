package by.gsu.lab.model.sources;

import by.gsu.lab.model.exceptions.ValidationException;
import java.util.*;

import by.gsu.lab.model.enums.OrderSymbolType;

import static by.gsu.constants.Constants.*;

/**
 * @author Viktor Baranov
 */
public class SourceUserInput extends AbstractSource {
    
    private final String data;

    public SourceUserInput(String message, String data) {
        super(message);
        this.data = data;
    }
    
    @Override
    public Map<Character, HashSet<String>> generate(OrderSymbolType orderType){
        return mapGenerator(orderType, data);
    }

    @Override
    public void dataValidation() throws ValidationException {
        if (EMPTY_STRING.equals(message.trim())) {
            throw new ValidationException(EMPTY_MESSAGE_FIELD);
        }
        if (EMPTY_STRING.equals(data.trim())) {
            throw new ValidationException(EMPTY_DATA_FIELD);
        }
    }
}
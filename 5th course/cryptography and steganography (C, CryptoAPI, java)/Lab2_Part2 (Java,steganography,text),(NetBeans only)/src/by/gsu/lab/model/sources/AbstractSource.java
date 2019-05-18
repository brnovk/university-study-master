package by.gsu.lab.model.sources;

import by.gsu.lab.model.exceptions.GeneratorException;
import by.gsu.lab.model.exceptions.ValidationException;
import java.util.*;

import by.gsu.lab.model.enums.OrderSymbolType;

import static by.gsu.constants.Constants.*;

/**
 * @author Viktor Baranov
 */
public abstract class AbstractSource {
    
    final protected String message;
    
    public AbstractSource(String message) {
        this.message = message;
    }
    
    protected Map<Character, HashSet<String>> mapGenerator(
            OrderSymbolType orderType, String data) {
        
        Map<Character, HashSet<String>> result = new HashMap<>();
        String[] sources = data.split(WORDS_SPLIT_PATTERN);
        for (char currentLetter : message.toCharArray()) {
            String curVal = String.format(orderType.getRegexPattern(), 
                    currentLetter);
            HashSet<String> words = new HashSet<>();
            for (String current : sources) {
                if (current.matches(curVal)) {
                    words.add(current);
                }
            }
            if (!words.isEmpty()) {
                result.put(currentLetter, words);
            }
        }
        return result;
    }
    
    public abstract void dataValidation() throws ValidationException;
    
    public abstract Map<Character, HashSet<String>> generate(
            OrderSymbolType orderType) throws GeneratorException;
}
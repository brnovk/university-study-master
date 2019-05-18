package by.gsu.lab.model;

import by.gsu.lab.model.sources.SourceSingleFile;
import by.gsu.lab.model.sources.AbstractSource;
import by.gsu.lab.model.sources.SourceUserInput;
import by.gsu.lab.model.sources.SourceCatalogWithFiles;
import by.gsu.lab.model.enums.SourceType;
import by.gsu.lab.model.enums.OrderSymbolType;
import java.util.*;

import by.gsu.lab.model.exceptions.GeneratorException;
import by.gsu.lab.controller.MainController;

import static by.gsu.constants.Constants.*;

/**
 * @author Viktor Baranov
 */
public class Logic {
    
    private final MainController controller;
    
    private SourceType sourceType;
    
    private OrderSymbolType orderType;
    
    
    public Logic(MainController controller, SourceType sourceType, 
            OrderSymbolType orderType) {
        this.controller = controller;
        this.sourceType = sourceType;
        this.orderType = orderType;
    }

    public void setSourceType(SourceType sourceType) {
        this.sourceType = sourceType;
    }

    public void setOrderSymbolType(OrderSymbolType orderType) {
        this.orderType = orderType;
    }

    public SourceType getSourceType() {
        return sourceType;
    }

    public OrderSymbolType getOrderSymbolType() {
        return orderType;
    }

    public AbstractSource getGenerator(String message, String data) {
        switch(sourceType) {
            case TXT_FILE:
                return new SourceSingleFile(message, data);
            case CATALOG_WITH_TXT_FILES:
                return new SourceCatalogWithFiles(message, data);
            case USER_INPUT_FIELD:
                return new SourceUserInput(message, data);
            default:
                throw new AssertionError(sourceType.name());
        }
    }

    public String generateContainer(String message, 
            Map<Character, HashSet<String>> source) throws GeneratorException {
        StringBuilder result = new StringBuilder();
        for (Character symbol : message.toCharArray()) {
            HashSet<String> currentList = source.get(symbol);
            if (currentList == null || currentList.isEmpty()) {
                String mes = String.format(EMPTY_LETTER_IN_SET, 
                        orderType.getOrder(), symbol);
                throw new GeneratorException(mes);
            }
            int targetIndex = randInt(0, currentList.size()-1);
            int i = 0;
            for (String currentElem : currentList) {
                if (i++ == targetIndex) {
                    result.append(currentElem);
                    result.append(RESULT_MESSAGE_DELIMETER);
                    break;
                }
            }
        }
        return result.toString();
    }
    
    public int randInt(int min, int max) {
        Random rand = new Random();
        int randomNum = rand.nextInt((max - min) + 1) + min;
        return randomNum;
    }
}
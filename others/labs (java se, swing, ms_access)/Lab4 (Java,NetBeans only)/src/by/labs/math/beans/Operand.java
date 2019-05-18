package by.labs.math.beans;

import by.labs.constants.Constants;

/**
 * Операнд.
 */
public class Operand {

    private OperandType type;
    private String text;
 
    public Operand(OperandType type, String text) {
        this.type = type;
        this.text = text;
    }
    
    public Operand(OperandType type, char symbol) {
        this(type, Character.toString(symbol));
    }

    public OperandType getType() {
        return type;
    }

    public void setType(OperandType type) {
        this.type = type;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    } 

    @Override
    public String toString() {
        return Constants.OPEN_BRACKET + type + Constants.COMMA 
                + text + Constants.CLOSE_BRACKET;
    }
}

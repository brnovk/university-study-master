package by.labs.math;

import by.labs.math.beans.Operand;
import by.labs.math.beans.OperandType;
import by.labs.math.beans.Quadrilateral;

import static by.labs.constants.Constants.*;

import java.util.ArrayList;
import java.util.List;

/**
 * Класс статического анализатора геометрических фигур.
 */
public class QuadrilateralParser {
    
    final static char OPEN_BRACKET = '(';
    final static char CLOSE_BRACKET = ')';
    final static char DOT = '.';
    final static char SIGN_PLUS = '+';
    final static char SIGN_MINUS = '-';
    final static char COMMA = ',';
    final static char SEMICOLON = ';';
    final static char SPACE = ' ';
    final static char NEWLINE = '\n';
    final static char NUMBER_0 = '0';
    final static char NUMBER_1 = '1';
    final static char NUMBER_2 = '2';
    final static char NUMBER_3 = '3';
    final static char NUMBER_4 = '4';
    final static char NUMBER_5 = '5';
    final static char NUMBER_6 = '6';
    final static char NUMBER_7 = '7';
    final static char NUMBER_8 = '8';
    final static char NUMBER_9 = '9';

    /**
     * Выполнение задачи (парсинг прямоугольников и трапеций, и вывод в строку)
     * @param source
     * @return 
     */
    public String parse(String source) {
        StringBuilder result = new StringBuilder();
        int i = 0;
        List<Operand> operands = new ArrayList<>();
        Operand prewOperand = new Operand(OperandType.UNKNOWN, EMPTY_STRING);
        
        // Парсинг операндов
        
        while (i < source.length()) {
            char curSymbl = source.charAt(i);
            switch (curSymbl) {
                case OPEN_BRACKET:
                    prewOperand = new Operand(OperandType.OPEN_BACKET, curSymbl);
                    operands.add(prewOperand);
                    break;
                case CLOSE_BRACKET:
                    prewOperand = new Operand(OperandType.CLOSE_BACKET, curSymbl);
                    operands.add(prewOperand);
                    break;
                case NUMBER_0:
                case NUMBER_1:
                case NUMBER_2:
                case NUMBER_3:
                case NUMBER_4:
                case NUMBER_5:
                case NUMBER_6:
                case NUMBER_7:
                case NUMBER_8:
                case NUMBER_9:
                    if (prewOperand.getType() == OperandType.SIGN) {
                        prewOperand.setType(OperandType.FLOAT);
                    }
                    if (prewOperand.getType() == OperandType.UNSIGNED_INT 
                            || prewOperand.getType() == OperandType.FLOAT) {
                        prewOperand.setText(prewOperand.getText() 
                                + Character.toString(curSymbl));
                    } else {
                        prewOperand = new Operand(OperandType.UNSIGNED_INT, curSymbl);
                        operands.add(prewOperand);
                    }
                    break;
                case DOT:
                    if (prewOperand.getType() == OperandType.UNSIGNED_INT) {
                        operands.remove(prewOperand);
                        prewOperand = new Operand(OperandType.FLOAT, 
                                prewOperand.getText() + curSymbl);
                        operands.add(prewOperand);
                    } else if (prewOperand.getType() == OperandType.FLOAT) {
                        prewOperand.setText(prewOperand.getText() 
                                + Character.toString(curSymbl));
                    } else {
                        return operandErrorStr(curSymbl, i);
                    }
                    break;
                case SIGN_PLUS:
                case SIGN_MINUS:
                    if (prewOperand.getType() != OperandType.UNSIGNED_INT 
                            && prewOperand.getType() != OperandType.FLOAT) {
                        prewOperand = new Operand(OperandType.SIGN, curSymbl);
                        operands.add(prewOperand);
                    } else {
                        return operandErrorStr(curSymbl, i);
                    }
                    break;
                case COMMA:
                    prewOperand = new Operand(OperandType.COMMA, curSymbl);
                    operands.add(prewOperand);
                    break;
                case SEMICOLON:
                    prewOperand = new Operand(OperandType.SEMICOLON, curSymbl);
                    operands.add(prewOperand);
                    break;
                case SPACE:
                case NEWLINE:
                    prewOperand = new Operand(OperandType.SEPARATOR, curSymbl);
                    break;
                default:
                    return operandErrorStr(curSymbl, i);
            }
            i++;
        }
        
        if (operands.isEmpty()) {
            result.append(MESSAGE_NEEDLESS_ANALYZE);
        }

        // Анализ синтаксиса
        
        //int ei = 0;
        int pi = 0;
        boolean prewComplite = false;
        int curPos = 0;

        QuadrilateralHelher helper = new QuadrilateralHelher();
        List<Quadrilateral> rectangles = new ArrayList<>();
        List<Quadrilateral> trapezoids = new ArrayList<>();
        List<Quadrilateral> undefinedQuadrilaterals = new ArrayList<>();
        List<Operand> quaBuf = new ArrayList<>();
        for (Operand operand : operands) {
            if (prewComplite && operand.getType() == OperandType.COMMA) {
                curPos += operand.getText().length();
                continue;
            }
            boolean inProcess = false;
            if (operand.getType() == Quadrilateral.QUADRILATERAL_PATTERN[pi]) {
                inProcess = true;
                quaBuf.add(operand);
                pi++;
                prewComplite = false;
                if (pi == Quadrilateral.QUADRILATERAL_PATTERN.length) {
                    if (helper.isRectangle(quaBuf) 
                            || helper.isTrapezoid(quaBuf)) {
                        if (helper.isRectangle(quaBuf)) {
                            rectangles.add(new Quadrilateral(quaBuf));
                        }
                        if (helper.isTrapezoid(quaBuf)) {
                            trapezoids.add(new Quadrilateral(quaBuf));
                        }
                    } else {
                        undefinedQuadrilaterals.add(new Quadrilateral(quaBuf));
                    }
                    prewComplite = true;
                    pi = 0;
                    quaBuf.clear();
                }
            } else {
                pi = 0;
                quaBuf.clear();
            }
            if (!inProcess) {
                return String.format(STATEMENT_NOT_EXPECTED, operand.getText(), 
                        curPos);
            }
            curPos += operand.getText().length();
        }
        result.append(RECTANGLES_FOUND).append(rectangles.size());
        i = 0;
        for (Quadrilateral item : rectangles) {
            result.append(NEWLINE).append(++i).append(CLOSE_BRACKET).append(item);
        }
        result.append(TRAPEZIUM_FOUND).append(trapezoids.size());
        i = 0;
        for (Quadrilateral item : trapezoids) {
            result.append(NEWLINE).append(++i).append(CLOSE_BRACKET).append(item);
        }
        result.append(UNCERTAINTY_QUADRANGLES_FOUND);
        result.append(undefinedQuadrilaterals.size());
        i = 0;
        for (Quadrilateral item : undefinedQuadrilaterals) {
            result.append(NEWLINE).append(++i).append(CLOSE_BRACKET).append(item);
        }
        return result.toString();
    }
    
    private String operandErrorStr(char curSymbl, int index) {
        return String.format(OPERAND_ERROR, curSymbl, (index + 1));
    }
}

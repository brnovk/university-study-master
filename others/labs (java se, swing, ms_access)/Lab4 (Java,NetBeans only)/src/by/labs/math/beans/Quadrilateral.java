package by.labs.math.beans;

import by.labs.constants.Constants;
import java.util.List;

/**
 * Четырёхугольник.
 */
public class Quadrilateral {
    
    public static final OperandType[] QUADRILATERAL_PATTERN = new OperandType[] {
        OperandType.OPEN_BACKET, 
        OperandType.FLOAT,   
        OperandType.COMMA, 
        OperandType.FLOAT,  
        OperandType.SEMICOLON,
        OperandType.FLOAT,   
        OperandType.COMMA, 
        OperandType.FLOAT,  
        OperandType.SEMICOLON,
        OperandType.FLOAT,   
        OperandType.COMMA, 
        OperandType.FLOAT,  
        OperandType.SEMICOLON,
        OperandType.FLOAT,   
        OperandType.COMMA, 
        OperandType.FLOAT, 
        OperandType.CLOSE_BACKET
    };
    
    private Point vertex1;
    private Point vertex2;
    private Point vertex3;
    private Point vertex4;

    public Quadrilateral(List<Operand> operands) {
        if (operands.size() == QUADRILATERAL_PATTERN.length) {
            vertex1 = new Point(Double.parseDouble(operands.get(1).getText()),
                                Double.parseDouble(operands.get(3).getText()));
            vertex2 = new Point(Double.parseDouble(operands.get(5).getText()),
                                Double.parseDouble(operands.get(7).getText()));
            vertex3 = new Point(Double.parseDouble(operands.get(9).getText()),
                                Double.parseDouble(operands.get(11).getText()));
            vertex4 = new Point(Double.parseDouble(operands.get(13).getText()),
                                Double.parseDouble(operands.get(15).getText()));
        }
    }

    public Point getVertex1() {
        return vertex1;
    }

    public void setVertex1(Point vertex1) {
        this.vertex1 = vertex1;
    }

    public Point getVertex2() {
        return vertex2;
    }

    public void setVertex2(Point vertex2) {
        this.vertex2 = vertex2;
    }

    public Point getVertex3() {
        return vertex3;
    }

    public void setVertex3(Point vertex3) {
        this.vertex3 = vertex3;
    }

    public Point getVertex4() {
        return vertex4;
    }

    public void setVertex4(Point vertex4) {
        this.vertex4 = vertex4;
    }
    
    @Override
    public String toString() {
        return String.format(Constants.QUADRILATERAL_PATTERN, 
                vertex1, vertex2, vertex3, vertex4);
    }
}

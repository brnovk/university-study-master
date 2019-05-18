package by.labs.math;

import by.labs.math.beans.Operand;
import java.util.List;

/**
 * Вспомогательный класс, для определения существования прямоугольника 
 * и трапеции.
 */
public class QuadrilateralHelher {

    /**
     * Проверка, являются ли переданные вершины прямоугольником.
     * @param operands
     * @return 
     */
    public boolean isRectangle(List<Operand> operands) {
        double x1 = Double.parseDouble(operands.get(1).getText());
        double y1 = Double.parseDouble(operands.get(3).getText());
        double x2 = Double.parseDouble(operands.get(5).getText());
        double y2 = Double.parseDouble(operands.get(7).getText());
        double x3 = Double.parseDouble(operands.get(9).getText());
        double y3 = Double.parseDouble(operands.get(11).getText());
        double x4 = Double.parseDouble(operands.get(13).getText());
        double y4 = Double.parseDouble(operands.get(15).getText());
        return isRectangle(x1, y1, x2, y2, x3, y3, x4, y4);
    }

    /**
     * Проверка, являются ли переданные вершины прямоугольником.
     * @param X1
     * @param Y1
     * @param X2
     * @param Y2
     * @param X3
     * @param Y3
     * @param X4
     * @param Y4
     * @return 
     */
    public boolean isRectangle(double X1, double Y1, double X2, 
            double Y2,double X3, double Y3,double X4, double Y4) {
        double slopeAB = SlopeDecimal(X1,Y1,X2,Y2);
        double slopeBC = SlopeDecimal(X2,Y2,X3,Y3);
        double slopeCD = SlopeDecimal(X3,Y3,X4,Y4);
        double slopeDA = SlopeDecimal(X4,Y4,X1,Y1);

        boolean perpendicular_AB_BC = isPerpendicular(slopeAB,slopeBC);
        boolean perpendicular_BC_CD = isPerpendicular(slopeBC,slopeCD);
        boolean perpendicular_CD_DA = isPerpendicular(slopeCD,slopeDA);
        boolean perpendicular_DA_AB = isPerpendicular(slopeDA,slopeAB);
        double midpointX = Midpoint(X1,X3);
        double midpointY = Midpoint(Y1,Y3);
        boolean fourRightAngles = perpendicular_AB_BC == true 
                && perpendicular_BC_CD == true && perpendicular_CD_DA == true 
                && perpendicular_DA_AB == true;
        boolean congruentDiagonals = 
                dEquals(DistanceSquareroot(X1,Y1,midpointX,midpointY),
                DistanceSquareroot(X2,Y2,midpointX,midpointY)) 
                && dEquals(DistanceSquareroot(X3,Y3,midpointX,midpointY),
                DistanceSquareroot(X4,Y4,midpointX,midpointY));
        return congruentDiagonals == true && fourRightAngles == true && 
                isParallelogram(X1,Y1,X2,Y2,X3,Y3,X4,Y4) == true;
    }
    
    /**
     * Проверка, являются ли переданные вершины трапецией.
     * @param operands
     * @return 
     */
    public boolean isTrapezoid(List<Operand> operands) {
        double x1 = Double.parseDouble(operands.get(1).getText());
        double y1 = Double.parseDouble(operands.get(3).getText());
        double x2 = Double.parseDouble(operands.get(5).getText());
        double y2 = Double.parseDouble(operands.get(7).getText());
        double x3 = Double.parseDouble(operands.get(9).getText());
        double y3 = Double.parseDouble(operands.get(11).getText());
        double x4 = Double.parseDouble(operands.get(13).getText());
        double y4 = Double.parseDouble(operands.get(15).getText());
        return isTrapezoid(x1, y1, x2, y2, x3, y3, x4, y4);
    }
    
    /**
     * Проверка, являются ли переданные вершины трапецией.
     * @param X1
     * @param Y1
     * @param X2
     * @param Y2
     * @param X3
     * @param Y3
     * @param X4
     * @param Y4
     * @return 
     */
    public boolean isTrapezoid(double X1, double Y1, double X2, double Y2, 
            double X3, double Y3, double X4, double Y4) {
        if (trapHelper(X1, Y1, X2, Y2, X3, Y3, X4, Y4)) {
            return true;
        }
        return trapHelper(X3, Y3, X2, Y2, X4, Y4, X1, Y1);
    }

    /**
     * Метод корректной проверки на равенство значений типа double.
     * @param x
     * @param y
     * @return 
     */
    private boolean dEquals(double x, double y) {
        return x == y ? true : Math.abs(x - y) < 0.00001D;
    }

    private double SlopeDecimal(double X1,double Y1,double X2,double Y2) {
	return ((Y2-Y1)/(X2-X1));
    }

    private double Midpoint(double X1,double X2) {
	return ((X1+X2)/2);
    }

    private boolean isPerpendicular(double slope1,double slope2) {
        if(dEquals(slope1, (-1)/slope2)) {
            return true;
        } else if(dEquals(slope2, (-1)/slope1)) {
            return true;
        } else {
            return (isInfinity(slope1) && dEquals(slope2, 0D)) 
                    || (isInfinity(slope2) && dEquals(slope1, 0D));
        }
    }

    private boolean isParallelogram(double X1, double Y1,double X2, 
            double Y2,double X3, double Y3,double X4, double Y4) {
        double slopeAB = SlopeDecimal(X1,Y1,X2,Y2);
        double slopeBC = SlopeDecimal(X2,Y2,X3,Y3);
        double slopeCD = SlopeDecimal(X3,Y3,X4,Y4);
        double slopeDA = SlopeDecimal(X4,Y4,X1,Y1);
        if( (dEquals(slopeAB, slopeCD)) && (dEquals(slopeBC, slopeDA)) 
            && (!dEquals(slopeAB, slopeBC)) && (!dEquals(slopeBC, slopeCD)) 
            && (!dEquals(slopeCD, slopeDA)) && (!dEquals(slopeDA, slopeAB))) {
            return true;
        } else {
            return (isInfinity(slopeAB) && isInfinity(slopeCD) 
                && dEquals(slopeBC, 0D) && dEquals(slopeDA, 0D)) 
                || (isInfinity(slopeBC) && isInfinity(slopeDA) 
                && dEquals(slopeAB, 0D) && dEquals(slopeCD, 0D));
        }
    }

    private boolean isInfinity(double number) {
        return number == Double.POSITIVE_INFINITY 
                || number == Double.NEGATIVE_INFINITY;
    }

    private boolean trapHelper(double X1, double Y1, double X2, double Y2, 
            double X3, double Y3, double X4, double Y4) {
	double slopeAB = SlopeDecimal(X1,Y1,X2,Y2);
	double slopeBC = SlopeDecimal(X2,Y2,X3,Y3);
	double slopeCD = SlopeDecimal(X3,Y3,X4,Y4);
	double slopeDA = SlopeDecimal(X4,Y4,X1,Y1);
	if((dEquals(slopeAB,slopeCD)) 
            && (!dEquals(slopeBC, slopeDA)) 
            && (!dEquals(slopeAB, slopeBC)) 
            && (!dEquals(slopeAB, slopeDA))) {
            return true;
        } else {
            return (!dEquals(slopeAB, slopeCD)) 
                && (dEquals(slopeBC, slopeDA)) 
                && (!dEquals(slopeAB, slopeBC)) 
                && (!dEquals(slopeAB, slopeDA));
        }
    }

    private double DistanceSquareroot(double X1, double Y1, double X2, double Y2) {
	return (Math.pow(X2-X1, 2) + Math.pow(Y2-Y1, 2));
    }
}

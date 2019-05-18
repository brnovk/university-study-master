package by.gsu.labs.math;

import by.gsu.labs.constants.Constants;
import java.util.ArrayList;
import java.util.List;

/**
 * Класс вычисления интеграла.
 * @author Victor Baranov
 */
public class DefiniteIntegral {
    
    private final String ERROR_STATE_CALCULATE = "Требуется вычислить интеграл";
    
    private final double lowLimit;
    
    private final double highLimit;
    
    private final double subIntervalLength;
    
    private final int digitsAfterPoint;
    
    private final int subIntervalCount;
    
    private final List<List<Double>> coordinates = new ArrayList<>();

    private Double result;
    
    public DefiniteIntegral(double lowLimit, double highLimit, 
            int subIntervalCount, int digitsAfterPoint) {
        subIntervalLength = 
                subIntervalCalculate(lowLimit, highLimit, subIntervalCount);
        this.lowLimit = lowLimit;
        this.highLimit = highLimit;
        
        this.digitsAfterPoint = digitsAfterPoint;
        this.subIntervalCount = subIntervalCount;
    }
    
    private double subIntervalCalculate(double lowLimit, double highLimit, 
            int subIntervalCount) {
        double interval = (highLimit - lowLimit);
        if (interval <= 0) {
            throw new IllegalArgumentException(Constants.ERROR_HIGH_LOW_LIMIT);
        }
        return interval / subIntervalCount;
    }
    
    private double subIntegralCalculate(double value) {
        // Сюда задается подынтегральная функция
        return value / 
                (Math.pow(value, 4) + (3.0D * (Math.pow(value, 2))) + 2.0D);
    }

    public void integralCalculate() {
        double coordinateAxisOX = lowLimit-subIntervalLength;
        result = (subIntegralCalculate(lowLimit) 
                + subIntegralCalculate(highLimit))/2.0;
        for (int i = 1; i <= subIntervalCount; i++) {
            double currLimit = lowLimit + i * subIntervalLength;
            List<Double> current = new ArrayList<>();
            current.add(subIntegralCalculate(currLimit));
            coordinateAxisOX += subIntervalLength;
            current.add(coordinateAxisOX);
            coordinates.add(current);
            result = result + subIntegralCalculate(currLimit);
        }
        result = result * subIntervalLength;
    }
    
    public double getSubIntervalLength() {
        return subIntervalLength;
    }
    
    public int getDigitsAfterPoint() {
        return digitsAfterPoint;
    }
    
    public double getLowLimit() {
        return lowLimit;
    }
     
    public double getHighLimit() {
        return highLimit;
    }
    
    public int getSubIntervalCount() {
        return subIntervalCount;
    }
       
    public double getResult() {
        if (result == null) {
            throw new IllegalStateException(ERROR_STATE_CALCULATE);
        }
        return result;
    }

    
    public List<List<Double>> getCoordinates() {
        if (coordinates.isEmpty()) {
            throw new IllegalStateException(ERROR_STATE_CALCULATE);
        }
        return coordinates;
    }
}
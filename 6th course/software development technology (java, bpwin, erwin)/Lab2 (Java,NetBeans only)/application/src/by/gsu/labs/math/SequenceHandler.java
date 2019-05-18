package by.gsu.labs.math;

import java.util.Random;

/**
 * Класс helper для работы с последовательностями.
 * @author Viktor Baranov
 */
public class SequenceHandler {
    
    /**
     * Создание массива рандомных чисел с показательным распределением.
     * @param length 
     * @param alpha
     * @return 
     */
    public double[] generateExponentialSequence(
            int length, double alpha) {
        double[] result = new double[length];
        Random random = new Random();
        for (int i=0; i<result.length; i++) {
            double current = random.nextDouble();
            result[i] = (-(1.0 / alpha)) * Math.log(current);
        }
        return result;
    }
    
    /**
     * Создание массива согласно заданию:
     * Y(i) = Y(i-1) + X(i), где Y(1) == X(1).
     * @param source
     * @return 
     */
    public double[] generateTaskSequence(double[] source) {
        double[] result = new double[source.length];
        result[0] = source[0];
        for (int i=1; i<result.length; i++) {
            result[i] = result[i-1] + source[i];
        }
        return result;
    }
    
    /**
     * Метод вычисления среднего значения.
     * @param source
     * @return 
     */
    public double calculateAverageValue(double[] source) {
        double result = 0;
        for (double current : source) {
            result += current;
        }
        return result / source.length;
    }
    
    /**
     * Метод вычисления мат. ожидания.
     * @param source
     * @return 
     */
    public double calculateExpectedValue(double[] source) {
        double result = 0;
        for (double current : source) {
            result += current;
        }
        return (( 1.0 / source.length) * result);
    }
    
    /**
     * Метод вычисления дисперсии по формуле, указанной в методичке.
     * @param source
     * @param expectedValue
     * @return 
     */
    public double calculateVariance(double[] source, double expectedValue) {
        double result = 0;
        for (double current : source) {
            result += (current * current)-(expectedValue * expectedValue);
        }
        return (( 1.0 / source.length) * result);
    }
}

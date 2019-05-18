package by.labs.math;

import java.util.Arrays;
import java.util.Random;

/**
 * Класс helper для работы с последовательностями.
 */
public class SequenceHandler {
    
    /**
     * Создание массива случайных чисел с равномерным распределением в диапазоне.
     * @param length
     * @param min
     * @param max
     * @return 
     */
    public double[] generateUniformDistributionSequence(int length,
            double min, double max) {
        double[] result = new double[length];
        Random random = new Random();
        for (int i = 0; i < length; i++) {
            result[i] = uniformDistribution(random, min, max);
        }
        return result;
    }

    /**
     * Создание результирующего массива согласно заданию:
     * объединить 3 массива в 1 и отсортировать по возрастанию.
     * @param first
     * @param second
     * @param third
     * @return 
     */
    public double[] taskSequence(final double[] first, 
            final double[] second, final double[] third) {
        int length = first.length + second.length + third.length;
        double[] result = new double[length];
        System.arraycopy(first, 0, result, 0, first.length);
        System.arraycopy(second, 0, result, first.length, second.length);
        System.arraycopy(third, 0, result, 
                (first.length + second.length), third.length);
        Arrays.sort(result);
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
    
    /**
     * Получение равномерно-распределённого случайного числа в диапазоне.
     * @param random
     * @param min
     * @param max
     * @return 
     */
    private double uniformDistribution(Random random, double min, double max) {
        if (min >= max) {
            throw new IllegalArgumentException();
        }
        double next = random.nextDouble();
        return (max - min) * next + min;    // Равномерный закон распределения
    }
}

package by.labs.math;

import java.util.ArrayList;
import java.util.List;

import by.labs.constants.Constants;

/**
 * Класс helper для вычисления делителей числа.
 */
public class DivisorCalculateHelper {

    public synchronized List<int[]> calculate(int number) {
        if (number < 1 || number > Integer.MAX_VALUE) {
            throw new IllegalArgumentException("Недопустимое значение.");
        }
        List<int[]> resultList = new ArrayList<>();
        for (int i = number, counter = 0; i > 0; i--) {
            if (number % i == 0) {
                int[] row = new int[3];
                row[Constants.COUNTER_INDEX] = ++counter;
                row[Constants.DIVISOR_INDEX] = i;
                row[Constants.QUOTIENT_INDEX] = number/i;
                resultList.add(row);
            }
        }
        return resultList;
    }
}

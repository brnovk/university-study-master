package by.gsu.labs.math;

/**
 * Класс helper для вычисления арифметического квадрата.
 * @author Viktor Baranov
 */
public class SquareCalculateHelper {

    public synchronized long[][] calculateSquare(int rowCount, int colCount) {
        long[][] result = new long[rowCount][colCount];
        for (int i=0; i<rowCount; i++) {
            for (int j=0; j<colCount; j++) {
                result[i][j] = getElement(i, j);
            }
        }
        return result;
    }
    
    private long getElement(long i, long j) {
        if (i==0 || j==0) {
            return 1;
        }
        return getElement(i, j-1) + getElement(i - 1, j);
    }
}

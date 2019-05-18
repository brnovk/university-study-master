package by.gsu.lab.gcd;

/**
 * Helper-class to compute the GCD.
 * 
 * @author Victor Baranov
 */
public class GCDHelper {

	/**
	 * Computation of normal Euclidean algorithm GCD for 2-numbers.
	 */
	public int calculateGCDEuclid(int firstNumber, int secondNumber) {
		int maxNumber = Math.max(firstNumber, secondNumber);
		int minNumber = Math.min(firstNumber, secondNumber);
		int gcd = minNumber;
		while (maxNumber % minNumber != 0) {
			gcd = maxNumber % minNumber;
			maxNumber = minNumber;
			minNumber = gcd;
		}
		return gcd;
	}

	/**
	 * Computation of normal Euclidean algorithm GCD for 3 numbers.
	 */
	public int calculateGCDEuclid(int firstNumber, int secondNumber, 
			int thirdNumber) {
		return multipleCalculateGCDEuclid(firstNumber, secondNumber, 
				thirdNumber);
	}

	/**
	 * Computation of normal Euclidean algorithm GCD for 4 numbers.
	 */
	public int calculateGCDEuclid(int firstNumber, int secondNumber, 
			int thirdNumber, int fourthNumber) {
		return multipleCalculateGCDEuclid(firstNumber, secondNumber, 
				thirdNumber, fourthNumber);
	}

	/**
	 * Computation of normal Euclidean algorithm GCD for 5 numbers.
	 */
	public int calculateGCDEuclid(int firstNumber, int secondNumber, 
			int thirdNumber, int fourthNumber, int fifthNumber) {
		return multipleCalculateGCDEuclid(firstNumber, secondNumber, 
				thirdNumber, fourthNumber, fifthNumber);
	}

	/**
	 * Computation of normal Euclidean algorithm GCD for any number of numbers.
	 */
	private int multipleCalculateGCDEuclid(int... numbers) {
		int result = numbers[0];
		for (int i = 1; i < numbers.length; i++) {
			result = calculateGCDEuclid(result, numbers[i]);
		}
		return result;
	}

	/**
	 * Calculation of binary GCD algorithm of Euclid to 2 numbers.
	 * The result is a wrapper class to store the result calculate and 
	 * execution time of the algorithm.
	 */
	public BinaryResultWrapper calculateBinaryGCD(int firstNumber, 
			int secondNumber) {
		long startTime = System.nanoTime();
		int gcd = binaryGCD(firstNumber, secondNumber);
		long endTime = System.nanoTime();
		long elapsedTime = endTime - startTime;
		return new BinaryResultWrapper(gcd, elapsedTime);
	}

	/**
	 * Calculation of binary GCD algorithm of Euclid to 2 numbers.
	 */
	private int binaryGCD(int first, int second) {
		if (second == 0)
			return first;
		if (first == 0)
			return second;
		if ((first & 1) == 0 && (second & 1) == 0) {
			return binaryGCD(first >> 1, second >> 1) << 1;
		} else if ((first & 1) == 0) {
			return binaryGCD(first >> 1, second);
		} else if ((second & 1) == 0) {
			return binaryGCD(first, second >> 1);
		} else if (first >= second) {
			return binaryGCD((first - second) >> 1, second);
		} else {
			return binaryGCD(first, (second - first) >> 1);
		}
	}
}

package by.labs.math;

/**
 * Class-helper to calculate the root n-degree from number.
 */
public class RootNewton {

	private final double number;
	private final double degree;
	private final double eps;
	private final double result;		// storing the result

	public RootNewton(double number, double degree, double eps) {
		this.number = number;
		this.degree = degree;
		this.eps = eps;
		result = calculateRoot();	// calculate root
	}
	
	/**
	 * Getting a result calculation (root)
	 */
	public double nthRoot() {
		return result;
	}
	
	/**
	 * Helper method compare the result with the value calculated using Math.Pow
	 */
	public void compareWithMathPow() {
		
		// Getting root through Math.Pow
		double nativeResult = Math.pow(number, 1.0 / degree);
		System.out.printf("%.16f - root through Math.pow\n", nativeResult);
		
		// Check whether you can compare
		if (Double.isInfinite(result) || Double.isNaN(result) || Double.isInfinite(nativeResult) 
				|| Double.isNaN(nativeResult)) {
			System.out.println("comparison is not possible: one of the values Infinity or NaN.");
			return;
		}
		
		// Comparison of results and show.
		if (Double.compare(result, nativeResult) == 0) {
			System.out.println("Values are equal.");
		} else if (Double.compare(result, nativeResult) > 0) {
			System.out.printf(
				"%.16f - this value is calculated by method of Newton more.\n", result - nativeResult);
		} else if (Double.compare(result, nativeResult) < 0) {
			System.out.printf(
				"%.16f - this value is calculated by Newton's method less.\n", nativeResult - result);
		}
	}

	/**
	 * Calculate root of Newton's method.
	 */
	private double calculateRoot() {
		double x0 = number / degree;
        double x1 = (1 / degree) * ((degree - 1) * x0 + number / powDouble(x0, (long) degree - 1));
        while (Math.abs(x1 - x0) > eps) {
            x0 = x1;
            x1 = (1 / degree) * ((degree - 1) * x0 + number / powDouble(x0, (long) degree - 1));
        }
        return x1;
    }

	/**
	 * Helper method calculate the degrees.
	 */
	private double powDouble(double number, long power) {
    	double powResult = 1;
        for (int i = 0; i < power; i++) {
        	powResult *= number;
        }
        return powResult;
    }
}

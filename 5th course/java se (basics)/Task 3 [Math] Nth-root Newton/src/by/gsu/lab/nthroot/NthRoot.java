package by.gsu.lab.nthroot;

/**
 * Class-helper to calculate the root n-degree from number. The type of calculation
 * setting via enum {@code NthRootType}
 * 
 * @author Victor Baranov
 */
public class NthRoot {

	public double rootCalculate(double number, int degree, double accuracy, NthRootType type) {
		switch (type) {
		case NATIVE_TYPE:
			return nthRootViaJavaNative(number, degree);
		case NEWTON_TYPE:
			return nthRootViaNewtonMethod(number, degree, accuracy);
		default:
			throw new IllegalStateException(type.name());
		}
	}

	private double nthRootViaJavaNative(double number, int degree) {
		return Math.pow(Math.E, Math.log(number) / degree);
	}

	private double nthRootViaNewtonMethod(double number, int degree, double accuracy) {
		double result = 1.0;
		double precision = Math.min(accuracy, 0.5);
		while (true) {
			double power = powDouble(result, degree - 1);
			double delta = (number / power - result) / degree;
			if (Math.abs(delta) < precision) {
				break;
			}
			result = result + delta;
		}
		return result;
	}

	private double powDouble(double number, int power) {
		double result = 1;
		while (power > 0) {
			if ((power & 1) == 1) {
				result = (result * number);
			}
			number = (number * number);
			power /= 2;
		}
		return result;
	}
}

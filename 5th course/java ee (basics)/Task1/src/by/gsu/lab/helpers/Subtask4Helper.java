package by.gsu.lab.helpers;

import java.math.BigDecimal;
import java.math.RoundingMode;

import by.gsu.lab.enums.Subtask4FunctionType;

public class Subtask4Helper {
	
	final static String IllegalTypeError = "Undetermined type of function: ";

	public double calculateInDegrees(double number, Subtask4FunctionType ftype, 
			Integer accuracy) {
		double result;
		switch (ftype) {
			case COS:
				result = cosInDegrees(number);
				break;
			case SIN:
				result = sinInDegrees(number);
				break;
			case TAN:
				result = tanInDegrees(number);
				break;
			default:
				throw new IllegalStateException(IllegalTypeError + ftype);
		}
		return roundingToPrecision(accuracy, result);
	}
	
	public double calculateInRadians(double number, Subtask4FunctionType ftype, 
			Integer accuracy) {
		double result;
		switch (ftype) {
			case COS:
				result = cosInRadians(number);
				break;
			case SIN:
				result = sinInRadians(number);
				break;
			case TAN:
				result = tanInRadians(number);
				break;
			default:
				throw new IllegalStateException(IllegalTypeError + ftype);
		}
		return roundingToPrecision(accuracy, result);
	}
	
	private double roundingToPrecision(Integer accuracy, double number) {
		if (accuracy == null) {
			return number;
		}
		if (accuracy < 1) {
			accuracy = 1;
		} else if (accuracy > 15) {
			accuracy = 15;
		}
		return new BigDecimal(number).setScale(accuracy, RoundingMode.HALF_UP)
				.doubleValue();
	}

	private double cosInDegrees(double numberInDegrees) {
		return cosInRadians(Math.toRadians(numberInDegrees));
	}
	
	private double cosInRadians(double numberInRadians) {
		return Math.cos(numberInRadians);
	}

	private double sinInDegrees(double numberInDegrees) {
		return sinInRadians(Math.toRadians(numberInDegrees));
	}
	
	private double sinInRadians(double numberInRadians) {
		return Math.sin(numberInRadians);
	}
	
	private double tanInDegrees(double numberInDegrees) {
		return tanInRadians(Math.toRadians(numberInDegrees));
	}
	
	private double tanInRadians(double numberInRadians) {
		return Math.tan(numberInRadians);
	}
}

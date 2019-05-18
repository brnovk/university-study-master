import java.util.Scanner;
import by.labs.math.RootNewton;

/**
 * Develop type, allows you to calculate the root n-degree from number using 
 * Newton's method with the specified accuracy.
 * Provide the ability to compare the result with a determinable value using java.
 * As a UI interface to use console application with command line interface.
 * 
 * Additionally: need to add a manual user input.
 * 
 * http://planetcalc.ru/313/	[online service for checking]
 */
public class Runner {

	public static void main(String[] args) {

		Scanner scanner = null;
		try {
			scanner = new Scanner(System.in);	// data source for input - console
			
			// Number
	        double number = getUserChoiseDouble(scanner, "Enter number (integer or float number):",
	        	"Invalid data - are allowed only integer or float numbers.");
	        
	        // Degree (range - any numbers of integer)
	        int degree = getUserChoiseInt(scanner, "Enter the degree (integer):", 
        		"Invalid data - allowed only integers.", Integer.MIN_VALUE, Integer.MAX_VALUE);
	        
	        // Precision (number of decimal places) (minimum 1, maximum 16)
	        int countSign = getUserChoiseInt(scanner, "Enter precision (number of decimal places) "
        		+ "from 1 to 16:", "Invalid data - allowed only integers from 1 to 16.", 1, 16);
	        
	        // Conversion of decimal places in float value (for example 6 -> 0.000001)
	        double precision = countSignToPrecision(countSign);
	        
	        // Creating a "type" for calculation of root
	        RootNewton calculator = new RootNewton(number, degree, precision);
	        
	        // Receive and output the calculation result of root
	        System.out.printf("%.16f - root of Newton's method\n", calculator.nthRoot());
	        
	        // Compare result with the value calculated using Math.Pow
	        calculator.compareWithMathPow();
		} finally {
			if (scanner != null) {
				scanner.close();
			}
			System.out.println("Program completed.");
		}
	}

	/**
	 * Getting the user entered integer number (degrees and precision)
	 * @param comment Tip before entering
	 * @param errMessage Tips in case of wrong entry
	 */
	static int getUserChoiseInt(Scanner scanner, String comment,
			String errMessage, int minValue, int maxValue) {
		System.out.println(comment);
		do {
			System.out.print(">> ");
			if (scanner.hasNextInt()) {			// If an integer is entered
				int number = scanner.nextInt();
				
				if (number >= minValue && number <= maxValue) {
					return number;
				}
			} else {
				scanner.next();	                // cleaning input buffer
			}
			System.out.println(errMessage);
		} while (true);
	}

	/**
	 * Getting the user entered float number (numbers)
	 * @param comment Tip before entering
	 * @param errMessage Tips in case of wrong entry
	 */
	static double getUserChoiseDouble(Scanner scanner, String comment, String errMessage) {
		System.out.println(comment);
		do {
			System.out.print(">> ");
			if (scanner.hasNextDouble()) {		// If the float number is entered
				return scanner.nextDouble();
			} else {
				scanner.next();	                // cleaning input buffer
			}
			System.out.println(errMessage);
		} while (true);
	}

	/**
	 * Helper method to convert the number of decimal places in a float number.
	 * (for example: 6 -> 0.000001 or 2 -> 0.01)
	 */
	static double countSignToPrecision(final int countSign) {
		if (countSign < 1) {
			throw new IllegalArgumentException(countSign + "< 1");
		}
		StringBuilder sb = new StringBuilder("0.");
		for (int i = 0; i < countSign - 1; i++) {
			sb.append(0);
		}
		return Double.parseDouble(sb.append(1).toString());
	}
}

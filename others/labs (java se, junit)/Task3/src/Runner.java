import java.util.Scanner;

/**
 * Develop a type that allows you to convert a non-negative decimal integer
 * value to a string containing a binary representation of the value.
 * As a UI interface to use console application with command line interface.
 * 
 * Additionally: need to add a manual user input.
 */
public class Runner {

	public static void main(String[] args) {

		Scanner scanner = null;
		try {
			scanner = new Scanner(System.in);	// data source for input - console
			long decNumber = getUserChoiseLong(scanner,
				"Enter a non-negative decimal integer value:",
				"Invalid data - only valid integer greater than 0.", 0L);
			
			// Compute and output the binary value of the number.
			System.out.println("Result (binary value): " 
				+ DecToBinConverter.toBinary(decNumber));
		} finally {
			if (scanner != null) {
				scanner.close();
			}
			System.out.println("Program completed.");
		}
	}

	/**
	 * Getting the user entered integer decimal numbers
	 * @param comment Tip before entering
	 * @param errMessage Tips in case of wrong entry
	 * @param minValue Minimum value (for this task need nonnegative numbers)
	 * @return
	 */
	static long getUserChoiseLong(Scanner scanner, String comment,
			String errMessage, long minValue) {
		System.out.println(comment);
		do {
			System.out.print(">> ");
			if (scanner.hasNextInt()) {			// If an integer is entered
				int number = scanner.nextInt();
				if (number >= minValue) {
					return number;
				}
			} else {
				scanner.next();	                // cleaning input buffer
			}
			System.out.println(errMessage);
		} while (true);
	}
}

/**
 * "Type" allows you to convert a non-negative decimal integer value to
 * a string containing a binary representation of the value.
 */
class DecToBinConverter {

	static String toBinary(long decNumber) {
		// return Long.toBinaryString(decNumber);
		if (decNumber == 0L) {
			return "0";
		}
		final int toBase = 2;				// new radix
		StringBuilder builder = new StringBuilder();
	    while (decNumber > 0) {
	        long buffer = decNumber % toBase;
	        builder.append(buffer);
	        decNumber = decNumber / toBase;
	    }
	    return builder.reverse().toString();
	}
}

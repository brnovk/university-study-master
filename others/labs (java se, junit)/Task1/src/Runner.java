import java.io.*;
import java.util.*;

/**
 * To develop a console application to read a small set of input data,
 * format of the data easy to read manner and display formatted results.
 * Data is text containing pairs of numbers representing the 
 * x and y-coordinates of the location of the object.
 * Each line of text contains a set of coordinates.
 * 
 * Example input:
 *      23.8976,12.3218
 *      25.7639,11.9463
 *      24.8293,12.2134
 * 
 * Result:
 *      X: 23,8976 Y: 12,3218
 *      X: 25,7639 Y: 11,9463
 *      X: 24,8293 Y: 12,2134
 *
 * Redirect input to launch the application with a text file containing 
 * data that you want to format.
 * 
 * Additionally: need to add a manual user input.
 */
public class Runner {

	public static void main(String[] args) {
		
		final String FILENAME = "file.txt";
		Scanner scanner = null;
		try {
			scanner = new Scanner(System.in);
			List<String> data = null;

			// getting value the user entered is 0, 1 or 2
			int choise = getUserChoiseInt(scanner, "Press: \n" 
				+ "0 - to exit"
				+ "\n1 - to read data from a file"
				+ "\n2 - to enter data manually", 0, 2);
			switch (choise) {
				case 0:
					scanner.close();
					System.out.println("Program completed");
					System.exit(0);
				case 1:
					data = getDataFromFile(FILENAME);	// reading data from a file
					break;
				case 2:
					data = getListFromConsole(scanner);	// reading data from console
					break;
				default:
					throw new IllegalStateException();
			}
			System.out.println("\nResult: ");
			for (String line : data) {
				StringTokenizer st = new StringTokenizer(line, ",");
				double x = Double.parseDouble(st.nextToken().trim());
				double y = Double.parseDouble(st.nextToken().trim());
				// Used German locale, because it decimal separator - comma.
				System.out.printf(Locale.GERMANY, "X: %.4f Y: %.4f\n", x, y);
			}
		} finally {
			if (scanner != null) {
				scanner.close();
			}
			System.out.println("Program completed.");
		}
	}
	
	/**
	 * Getting a user entered number (menu item: 0, 1 or 2)
	 * @param comment Tip before entering
	 */
	static int getUserChoiseInt(Scanner scanner, String comment, int minValue, int maxValue) {
		System.out.println(comment);
		do {
			System.out.print(">> ");
			if (scanner.hasNextInt()) {
				int number = scanner.nextInt();
				if (number >= minValue && number <= maxValue) {	
					return number;
				}
			} else {
				scanner.next();	// cleaning input buffer
			}
			System.out.printf("Invalid data - is only valid integers from %d to %d.\n",
				minValue, maxValue);
		} while (true);
	}

	/**
	 * Gets a collection of strings entered by the user
	 * (pairs of float numbers, separated by a comma with a decimal separator point).
	 */
	static List<String> getListFromConsole(Scanner scanner) {
		List<String> result = new ArrayList<String>();
		System.out.println("Enter pairs of numbers in form 23.8976, 12.3218.\n"
			+ "To finish entering, press 'q' and 'Enter'.");
		scanner.nextLine();
		do {
			System.out.print(">> ");
			String current = scanner.nextLine().trim();
			if ("q".equals(current.toLowerCase())) {
				return result;
			} else if ("".equals(current)) {	// If you enter an empty string
				continue;
			}
			result.add(current);
		} while (true);
	}
	
	/**
	 * Get a collection of lines from a file.
	 */
	static List<String> getDataFromFile(String filename) {
		List<String> result = new ArrayList<String>();
		BufferedReader reader = null;
		try {
			reader = new BufferedReader(new InputStreamReader(
					Runner.class.getResourceAsStream(filename), "UTF-8"));
			String currentLine;
			while ((currentLine = reader.readLine()) != null) {
				String trimmedLine = currentLine.trim();
				if (!"".equals(trimmedLine)) {	// if string is not empty - added to collection
					result.add(trimmedLine);	
				}
			}
		} catch (IOException ex) {
			System.err.println(ex);
		} finally {
		    if (reader != null) {
		        try {
	                reader.close();		
		        } catch (Throwable ex) {
	                System.err.println(ex);
		        }
		    }
		}
		return result;
	}
}

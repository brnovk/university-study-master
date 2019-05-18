import java.text.*;
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
 * @author Victor Baranov
 */
public class Runner {

	public static void main(String[] args) throws ParseException {

		final String EXIT_WORD = "exit";
		final String TIP = String.format("Enter one or more pairs of coordinates,"
			+ " separated by a comma.\nExample input:\n"
			+ "\t23.8976, 12.3218\n"
			+ "\t24.8293, 12.2134\n"
			+ "(Enter \"%s\" to finish entering)\n", EXIT_WORD);

		final String INPUT_DATA_DELIMETER = ",";
		final String OUTPUT_PATTERN = "X: %-10s Y: %-10s\n";

		final DecimalFormat dotSeparatorFormat = 
		(DecimalFormat) NumberFormat.getNumberInstance(Locale.US);
		final DecimalFormat commaSeparatorFormat = 
		(DecimalFormat) NumberFormat.getNumberInstance(Locale.FRANCE);

		// Get collection of the strings entered by the user.
		List<String> sourceDataList = userDataList(TIP, EXIT_WORD);

		StringBuilder result = new StringBuilder();
		for (String current : sourceDataList) {

			// Parse float numbers separated by a "dot"
			String[] buffer = current.split(INPUT_DATA_DELIMETER);
			double first = dotSeparatorFormat.parse(buffer[0].trim()).doubleValue();
			double second = dotSeparatorFormat.parse(buffer[1].trim()).doubleValue();

			// Format float numbers with separator "comma"
			String resultFirst = commaSeparatorFormat.format(first);
			String resultSecond = commaSeparatorFormat.format(second);

			result.append(String.format(OUTPUT_PATTERN, resultFirst, resultSecond));
		}
		System.out.println("\n\nResult:\n");
		System.out.println(result.toString());
	}
	
	/**
     * Get collection of the strings entered by the user.
     * Entering lines ends with the word {@code exitWord}
     * @param hintText Tip before entering.
     * @param exitWord Word to finish entering.
     * @return Collection of the input string user.
     */
	public static List<String> userDataList(String hintText, String exitWord) {
		System.out.println(hintText);
		List<String> results = new ArrayList<>();
		try (Scanner scanner = new Scanner(System.in)) {
			while (true) {
				if (scanner.hasNext()) {
					String currentInput = scanner.nextLine().trim();
					if (exitWord.equals(currentInput)) {
						return results;
					}
					results.add(currentInput);
				}
			}
		}
	}
}

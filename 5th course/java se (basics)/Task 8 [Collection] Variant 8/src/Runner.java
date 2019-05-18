import java.io.IOException;
import java.util.Collections;
import java.util.List;

import by.gsu.lab.FileHandler;

public class Runner {

	public static void main(String[] args) {

		String fileName = "fileWithStrings.txt";
		try {
			FileHandler reader = new FileHandler(fileName);
			List<String> list = reader.read();

			System.out.println("Original unsorted list:");
			System.out.println(list);

			Collections.sort(list);

			System.out.println("\nSorted list:");
			System.out.println(list);
		} catch (IOException ex) {
			System.err.println(ex);
		}
	}
}

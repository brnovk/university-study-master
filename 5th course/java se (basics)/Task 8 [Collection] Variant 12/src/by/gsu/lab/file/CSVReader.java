package by.gsu.lab.file;

import java.io.*;
import java.util.*;

public class CSVReader {

	private final String filename;

	public CSVReader(String filename) {
		this.filename = filename;
	}

	public List<Set<Integer>> readListSets() throws IOException {

		final String CSV_DELIMITER = ",";
		List<Set<Integer>> result = new ArrayList<>();
		try (BufferedReader reader = new BufferedReader(
				new InputStreamReader(
						this.getClass().getResourceAsStream("/" + filename)))) {
			String line;
			while ((line = reader.readLine()) != null) {
				String rawLists[] = line.split(CSV_DELIMITER);
				Set<Integer> current = getSetFromLine(rawLists);
				result.add(current);
			}
		}
		return result;
	}

	private Set<Integer> getSetFromLine(String... rawLine) {
		Set<Integer> result = new TreeSet<>();
		for (String value : rawLine) {
			result.add(Integer.parseInt(value.trim()));
		}
		return result;
	}
}

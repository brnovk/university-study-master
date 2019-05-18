package by.gsu.lab;

import java.io.*;
import java.util.*;

public class FileHandler {

	private final String filename;

	public FileHandler(String filename) {
		this.filename = filename;
	}

	public List<Stack<Integer>> readListStacks() throws IOException {
		List<Stack<Integer>> result = new ArrayList<>();
		try (BufferedReader reader = new BufferedReader(
				new InputStreamReader(
						this.getClass().getResourceAsStream("/" + filename)))) {
			String line;
			while ((line = reader.readLine()) != null) {
				result.add(getStackFromLine(line));
			}
		}
		return result;
	}

	private Stack<Integer> getStackFromLine(String rawLine) {
		Stack<Integer> result = new Stack<>();
		for (char letter : rawLine.trim().toCharArray()) {
			result.push(Character.getNumericValue(letter));
		}
		return result;
	}
}

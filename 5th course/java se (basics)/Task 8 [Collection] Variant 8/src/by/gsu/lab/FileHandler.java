package by.gsu.lab;

import java.io.*;
import java.util.*;

public class FileHandler {

	private final String filename;

	public FileHandler(String filename) {
		this.filename = filename;
	}

	public List<String> read() throws IOException {
		List<String> result = new ArrayList<>();
		BufferedReader reader = null;
		try {
			reader = new BufferedReader(new InputStreamReader(
					this.getClass().getResourceAsStream("/" + filename)));
			String line;
			while ((line = reader.readLine()) != null) {
				result.add(line.trim());
			}
			return result;
		} finally {
			if (reader != null) {
				reader.close();
			}
		}
	}
}

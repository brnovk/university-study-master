import java.io.IOException;
import java.util.List;
import java.util.Set;

import by.gsu.lab.RunnerLogic;
import by.gsu.lab.file.CSVReader;

public class Runner {

	public static void main(String[] args) {

		String fileName = "setsNumbers.csv";
		try {
			CSVReader fileReader = new CSVReader(fileName);
			List<Set<Integer>> sets = fileReader.readListSets();
			new RunnerLogic().doLogic(sets);
		} catch (IOException ex) {
			System.err.println(ex);
		}
	}
}

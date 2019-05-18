package by.gsu.lab.helpers;

import java.util.ArrayList;
import java.util.List;

import by.gsu.lab.beans.Subtask6Node;

public class Subtask6DataStorage {

	private final static List<Subtask6Node> nodeList = new ArrayList<>();
	
	public static synchronized void addNode(Subtask6Node node) {
		nodeList.add(node);
	}
	
	public static synchronized List<Subtask6Node> getNodes() {
		return nodeList;
	}
}

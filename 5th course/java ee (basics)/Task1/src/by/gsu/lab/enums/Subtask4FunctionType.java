package by.gsu.lab.enums;

public enum Subtask4FunctionType {
	SIN,
	COS,
	TAN;

	public static Subtask4FunctionType parseFunctionType(String rawFunctionType) {
		return Subtask4FunctionType.valueOf(rawFunctionType.trim().toUpperCase());
	}
}

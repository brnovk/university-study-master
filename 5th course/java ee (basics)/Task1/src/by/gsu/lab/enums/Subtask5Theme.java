package by.gsu.lab.enums;

public enum Subtask5Theme {
	
	CARS("Cars"), 
	KIDS("Kids"), 
	NATURE("Nature"), 
	UNKNOWN("Unknown");
	
	private String displayName;
	
	private Subtask5Theme(String displayName) {
		this.displayName = displayName;
	}
	
	public static Subtask5Theme parseTheme(String rawTheme) {
		return Subtask5Theme.valueOf(rawTheme.trim().toUpperCase());
	}
	
	public String getDisplayName() {
		return displayName;
	}
	
    public String toString() {
        return name().toLowerCase();
    }
}

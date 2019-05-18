package by.gsu.bugtracker.domain;

public class Notification {
	
	private String to;
	private String message;

	public Notification() { }

	public Notification(String to, String message) {
		super();
		this.to = to;
		this.message = message;
	}

	public String getTo() {
		return to;
	}
	
	public void setTo(String to) {
		this.to = to;
	}
	
	public String getMessage() {
		return message;
	}
	
	public void setMessage(String message) {
		this.message = message;
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		if (to != null)
			builder.append(to).append(";");
		if (message != null)
			builder.append(message);
		return builder.toString();
	}
}

package by.gsu.bugtracker.domain;

public class SearchIssue {
	
	private String createdByEmail;
	private String modifiedByEmail;
	private String summary;
	private String description;
	private String status;
	private String resolution;
	private String type;
	private String priority;
	private String projectName;
	private String assigneeEmail;

	public String getCreatedByEmail() {
		return createdByEmail;
	}

	public void setCreatedByEmail(String createdByEmail) {
		this.createdByEmail = createdByEmail;
	}

	public String getModifiedByEmail() {
		return modifiedByEmail;
	}

	public void setModifiedByEmail(String modifiedByEmail) {
		this.modifiedByEmail = modifiedByEmail;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getResolution() {
		return resolution;
	}

	public void setResolution(String resolution) {
		this.resolution = resolution;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getPriority() {
		return priority;
	}

	public void setPriority(String priority) {
		this.priority = priority;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getAssigneeEmail() {
		return assigneeEmail;
	}

	public void setAssigneeEmail(String assigneeEmail) {
		this.assigneeEmail = assigneeEmail;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		if (createdByEmail != null)
			builder.append(createdByEmail).append(";");
		if (modifiedByEmail != null)
			builder.append(modifiedByEmail).append(";");
		if (summary != null)
			builder.append(summary).append(";");
		if (description != null)
			builder.append(description).append(";");
		if (status != null)
			builder.append(status).append(";");
		if (resolution != null)
			builder.append(resolution).append(";");
		if (type != null)
			builder.append(type).append(";");
		if (priority != null)
			builder.append(priority).append(";");
		if (projectName != null)
			builder.append(projectName).append(";");
		if (assigneeEmail != null)
			builder.append(assigneeEmail);
		return builder.toString();
	}
}

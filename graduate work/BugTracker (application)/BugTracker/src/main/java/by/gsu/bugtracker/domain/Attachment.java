package by.gsu.bugtracker.domain;

import java.sql.Date;
import javax.persistence.*;
import javax.validation.constraints.Size;

@Entity
@Table(name = "attachments")
public class Attachment extends GenericDomainObject implements Comparable<Attachment> {

	private static final long serialVersionUID = 1L;
	
	@ManyToOne()
	@JoinColumn(name="ADDEDBY", updatable = false)
	private User addedBy;
	
	@Column(name = "CREATEDATE", updatable = false)
	private Date addDate;
	
	@Column(name = "FILEPATH", updatable = false)
	private String filePath;
	
	@Column(name = "FILENAME", updatable = false)
	@Size(max=150, message="Filename is more 150 characters")
	private String fileName;
	
	@ManyToOne
	private Issue issue;

	public Attachment() {
		super();
	}

	@PrePersist
	public void addDateGen() {
		this.addDate = new Date(new java.util.Date().getTime());
	}

	public User getAddedBy() {
		return addedBy;
	}

	public Date getAddDate() {
		return addDate;
	}

	public void setAddedBy(User addedBy) {
		this.addedBy = addedBy;
	}

	public void setAddDate(Date addDate) {
		this.addDate = addDate;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Issue getIssue() {
		return issue;
	}

	public void setIssue(Issue issue) {
		this.issue = issue;
	}

	@Override
	public int compareTo(Attachment o) {
		long timeDiff = 0;
		if (this.addDate != null && o.addDate != null) {
			timeDiff = this.addDate.getTime() - o.addDate.getTime();
		}
		return (int) ((timeDiff != 0) ? timeDiff: this.getId() - o.getId());
	}
}

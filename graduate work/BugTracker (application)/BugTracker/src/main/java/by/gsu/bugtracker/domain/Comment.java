package by.gsu.bugtracker.domain;

import java.sql.Date;

import javax.persistence.*;
import javax.validation.constraints.Size;

@Entity
@Table(name = "coments")
public class Comment extends GenericDomainObject implements Comparable<Comment>{

	private static final long serialVersionUID = 1L;
	
	@ManyToOne()
	@JoinColumn(name="ADDEDBY", updatable = false)
	private User addedBy;
	
	@Column(name = "CREATEDATE", updatable = false)
	private Date addDate;
	
	@Column(name = "COMMENT", length = 2000)
	@Size(min=1, max=2000, message="Comment required or more 2000 characters")
	private String comment;
	
	@ManyToOne
	private Issue issue;

	public Comment() {
		super();
	}

	public Comment(long id) {
		super(id);
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

	public String getComment() {
		return comment;
	}

	public void setAddedBy(User addedBy) {
		this.addedBy = addedBy;
	}

	public void setAddDate(Date addDate) {
		this.addDate = addDate;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Issue getIssue() {
		return issue;
	}

	public void setIssue(Issue issue) {
		this.issue = issue;
	}

	@Override
	public int compareTo(Comment o) {
		long timeDiff = 0;
		if (this.addDate != null && o.addDate != null) {
			timeDiff = this.addDate.getTime() - o.addDate.getTime();
		} 
		return (int) ((timeDiff != 0) ? timeDiff: this.getId() - o.getId());
	}
}

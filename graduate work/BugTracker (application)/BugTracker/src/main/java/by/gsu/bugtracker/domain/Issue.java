package by.gsu.bugtracker.domain;

import java.sql.Date;
import java.util.SortedSet;

import javax.persistence.*;
import javax.validation.constraints.Size;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.hibernate.annotations.Sort;
import org.hibernate.annotations.SortType;

@Entity
@Table(name = "issues")
public class Issue extends GenericDomainObject {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "CREATEDATE", updatable = false)
	@JsonIgnore
	private Date createDate;
	
	@ManyToOne()
	@JoinColumn(name="CREATEDBY", updatable = false)
	@JsonIgnore
	private User createdBy;
	
	@Column(name = "MODIFYDATE")
	@JsonIgnore
	private Date modifyDate;
	
	@ManyToOne()
	@JoinColumn(name="MODIFIEDBY")
	@JsonIgnore
	private User modifiedBy;
	
	@Column(name = "SUMMARY")
	@Size(min=1, message="Summary required")
	private String summary;
	
	@Column(name = "DESCRIPTION", length = 2000)
	@JsonIgnore
	@Size(min=1, max=2000, message="Description required or more 2000 characters")
	private String description;
	
	@ManyToOne()
	@JoinColumn(name="STATUS")
	private Status status;
	
	@ManyToOne()
	@JoinColumn(name = "RESOLUTION")
	@JsonIgnore
	private Resolution resolution;
	
	@ManyToOne()
	@JoinColumn(name = "TYPE")
	private Type type;
	
	@ManyToOne()
	@JoinColumn(name = "PRIORITY")
	private Priority priority;
	
	@ManyToOne()
	@JoinColumn(name="PROJECT")
	@JsonIgnore
	private Project project;
	
	@ManyToOne()
	@JoinColumn(name="BUILDFOUND")
	@JsonIgnore
	private Build buildFound;
	
	@ManyToOne()
	@JoinColumn(name="ASSIGNEE")
	private User assignee;
	
	@OneToMany(fetch=FetchType.EAGER, mappedBy="issue")
	@Sort(type=SortType.NATURAL)
	@JsonIgnore
	private SortedSet<Comment> comments;
	
	@OneToMany(fetch=FetchType.EAGER, mappedBy="issue")
	@Sort(type=SortType.NATURAL)
	@JsonIgnore
	private SortedSet<Attachment> attachments;

	public Issue() {
		super();
	}
	
	public Issue(long id,  Priority priority, User assignee, Type type, 
			Status status, String summary) {
		super(id);
		this.summary = summary;
		this.status = status;
		this.type = type;
		this.priority = priority;
		this.assignee = assignee;
	}

	@PrePersist
	public void createDateGen() {
		this.createDate = new Date(new java.util.Date().getTime());
	}
	
	@PreUpdate
	public void modifyDateGen() {
		this.modifyDate = new Date(new java.util.Date().getTime());
	}
	
	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public User getModifiedBy() {
		return modifiedBy;
	}

	public void setModifiedBy(User modifiedBy) {
		this.modifiedBy = modifiedBy;
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

	public Status getStatus(){
		return status;
	}
	
	public void setStatus(Status status) {
		this.status = status;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public Build getBuildFound() {
		return buildFound;
	}

	public void setBuildFound(Build buildFound) {
		this.buildFound = buildFound;
	}

	public User getAssignee() {
		return assignee;
	}

	public void setAssignee(User assignee) {
		this.assignee = assignee;
	}
	
	public Resolution getResolution() {
		return resolution;
	}

	public void setResolution(Resolution resolution) {
		this.resolution = resolution;
	}

	public Type getType() {
		return type;
	}

	public void setType(Type type) {
		this.type = type;
	}

	public Priority getPriority() {
		return priority;
	}

	public void setPriority(Priority priority) {
		this.priority = priority;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public SortedSet<Comment> getComments() {
		return comments;
	}

	public void setComments(SortedSet<Comment> comments) {
		this.comments = comments;
	}

	public SortedSet<Attachment> getAttachments() {
		return attachments;
	}

	public void setAttachments(SortedSet<Attachment> attachments) {
		this.attachments = attachments;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public User getCreatedBy() {
		return createdBy;
	}

	public void setCreateDate(String createDate) {
		this.createDate = Date.valueOf(createDate);
	}

	public void setCreatedBy(User createdBy) {
		this.createdBy = createdBy;
	}
}

package by.gsu.bugtracker.domain;

import java.util.List;

import javax.persistence.*;
import javax.validation.constraints.Size;

@Entity
@Table(name = "projects")
public class Project extends GenericDomainObject {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "NAME")
	@Size(min=1, max=255, message="Name required or more 255 characters")
	private String name;
	
	@Column(name = "DESCRIPTION", length = 1000)
	@Size(min=1, max=2000, message="Description required or more 1000 characters")
	private String description;
	
	@OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.PERSIST)
	private List<Build> builds;

	@ManyToOne()
	@JoinColumn(name="MANAGER")
	private User manager;

	public Project() {
		super();
	}

	public Project(long id) {
		super(id);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<Build> getBuilds() {
		return builds;
	}

	public void setBuilds(List<Build> builds) {
		this.builds = builds;
	}

	public User getManager() {
		return manager;
	}

	public void setManager(User manager) {
		this.manager = manager;
	}
}

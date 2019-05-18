package by.gsu.bugtracker.domain;

import javax.persistence.*;
import javax.validation.constraints.Size;

@Entity
@Table(name = "builds")
public class Build extends GenericDomainObject {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "NAME")
	@Size(min=1, max=255, message="Name required or more 255 characters")
	private String name;

	public Build() {
		super();
	}
	
	public Build(long id) {
		super(id);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}

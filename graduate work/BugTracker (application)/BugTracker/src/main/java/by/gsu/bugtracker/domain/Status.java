package by.gsu.bugtracker.domain;

import javax.persistence.*;
import javax.validation.constraints.Size;

import org.codehaus.jackson.annotate.JsonValue;

@Entity
@Table(name = "statuses")
public class Status extends GenericDomainObject {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "NAME")
	@Size(min=1, max=255, message="Name required or more 255 characters")
	private String name;

	public Status() {
		super();
	}

	public Status(int id) {
		super(id);
	}

	@JsonValue
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}

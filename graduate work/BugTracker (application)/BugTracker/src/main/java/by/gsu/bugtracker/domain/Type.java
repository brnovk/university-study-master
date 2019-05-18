package by.gsu.bugtracker.domain;

import javax.persistence.*;
import javax.validation.constraints.Size;

import org.codehaus.jackson.annotate.JsonValue;

@Entity
@Table(name = "types")
public class Type extends GenericDomainObject {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "NAME")
	@Size(min=1, max=255, message="Name required or more 255 characters")
	private String name;

	@JsonValue
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}

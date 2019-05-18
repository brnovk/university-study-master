package by.gsu.bugtracker.domain;

import javax.persistence.*;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.codehaus.jackson.annotate.JsonValue;

import by.gsu.bugtracker.model.enums.UserRoles;


@Entity
@Table(name = "users")
@NamedQuery(name = "User.getUserByEmail", 
	query = "FROM User u WHERE u.emailAddress = :emailaddress")
public class User extends GenericDomainObject {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "EMAILADDRESS", nullable = false, unique = true)
	@Pattern(regexp="[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,4}", 
		message="Invalid email address.")
	private String emailAddress;
	
	@Column(name = "FIRSTNAME")
	@Size(min=1, max=255, message="Firstname required or more 255 characters")
	private String firstName;
	
	@Column(name = "LASTNAME")
	@Size(min=1, max=255, message="Lastname required or more 255 characters")
	private String lastName;
	
	@Column(name = "PASSWORD")
	@Size(min=5, max=255, message="Password must be between 5 and 255 characters")
	private String password;
	
	@Column(name = "USERROLE")
	@Enumerated(EnumType.STRING)
	private UserRoles userRole;

	public User() {
		super();
	}

	public User(long id) {
		super(id);
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public UserRoles getUserRole() {
		return userRole;
	}

	public void setUserRole(UserRoles userRole) {
		this.userRole = userRole;
	}

	public void setUserRole(String userRole) {
		this.userRole = UserRoles.valueOf(userRole.toUpperCase());
	}

	@JsonValue
	public String getEmailAddress() {
		return emailAddress;
	}
	
	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((emailAddress == null) ? 0 : emailAddress.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		if (emailAddress == null) {
			if (other.emailAddress != null)
				return false;
		} else if (!emailAddress.equals(other.emailAddress))
			return false;
		return true;
	}
}

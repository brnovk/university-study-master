package by.gsu.bugtracker.service;

import java.util.List;
import by.gsu.bugtracker.domain.User;

public interface IUserService extends IGenericService<User> {

	User getUserByEmail(String emailAddress);
	List<User> getFoundUsersList(User user);
}

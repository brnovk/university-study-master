package by.gsu.bugtracker.dao;

import java.util.List;
import org.springframework.stereotype.Repository;
import by.gsu.bugtracker.domain.User;

@Repository
public interface IUserDao extends IDao<User> {
	
	User getUser(String emailAddress, String password);
	User getUserByEmail(String emailAddress);
	List<User> getFoundUsersList(User user);
}

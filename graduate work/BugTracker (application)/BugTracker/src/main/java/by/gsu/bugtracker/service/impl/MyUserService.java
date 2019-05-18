package by.gsu.bugtracker.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import by.gsu.bugtracker.dao.*;
import by.gsu.bugtracker.domain.User;
import by.gsu.bugtracker.service.IUserService;

@Service
public class MyUserService extends AbstractGenericService<User> implements IUserService {
	
	@Inject
	private IUserDao userDao;

	@Override
	protected IDao<User> getDao() {
		return userDao;
	}

	@Override
	@Transactional(readOnly=true)
	public User getUserByEmail(String emailAddress) {
		return userDao.getUserByEmail(emailAddress);
	}
	
	@Override
	@Transactional(readOnly=true)
	public List<User> getFoundUsersList(User user) {
		return userDao.getFoundUsersList(user);
	}
}

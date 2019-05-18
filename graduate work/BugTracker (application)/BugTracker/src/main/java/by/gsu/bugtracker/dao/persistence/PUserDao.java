package by.gsu.bugtracker.dao.persistence;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import by.gsu.bugtracker.dao.IUserDao;
import by.gsu.bugtracker.domain.User;

@Repository
public class PUserDao extends AbstractJpaDAO<User> implements IUserDao {
	
	private static final Logger LOG = Logger.getLogger(PUserDao.class);
	
	public PUserDao() {
		super(User.class);
	}

	@Override
	public User getUser(String emailAddress, String password) {
		Query query = entityManager.createNamedQuery("User.getUserByEmail");
		query.setParameter("emailaddress", emailAddress);
		User user = (User) query.getSingleResult();
		if (user.getPassword().equals(password)) {
			return user;
		} else {
			return null;
		}
	}
	
	@Override
	public User getUserByEmail(String emailAddress) {
		Query query = entityManager.createNamedQuery("User.getUserByEmail");
		query.setParameter("emailaddress", emailAddress);
		return (User) query.getSingleResult();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<User> getFoundUsersList(User user) {
		LOG.info(user);
		Map<String, String> parameters = new HashMap<>();
		StringBuffer queryBuf = new StringBuffer("from User u ");
		boolean firstClause = true;
		if (user.getEmailAddress() != null && !"".equals(user.getEmailAddress())) {
			queryBuf.append(firstClause ? " where " : " and ");
			queryBuf.append("u.emailAddress like :emailAddress");
			parameters.put("emailAddress", user.getEmailAddress() + "%");
			firstClause = false;
		}
		if (user.getFirstName() != null && !"".equals(user.getFirstName())) {
			queryBuf.append(firstClause ? " where " : " and ");
			queryBuf.append("u.firstName like :firstName");
			parameters.put("firstName", user.getFirstName() + "%");
			firstClause = false;
		}
		if (user.getLastName() != null && !"".equals(user.getLastName())) {
			queryBuf.append(firstClause ? " where " : " and ");
			queryBuf.append("u.lastName like :lastName");
			parameters.put("lastName", user.getLastName() + "%");
			firstClause = false;
		}

		String hqlQuery = queryBuf.toString();
		Query query = entityManager.createQuery(hqlQuery);

		Iterator<String> iter = parameters.keySet().iterator();
		while (iter.hasNext()) {
			String name = iter.next();
			String value = parameters.get(name);
			query.setParameter(name, value);
		}
		return query.getResultList();
	}
}

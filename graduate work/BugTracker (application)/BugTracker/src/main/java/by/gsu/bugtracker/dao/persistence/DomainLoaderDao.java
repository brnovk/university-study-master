package by.gsu.bugtracker.dao.persistence;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

@Repository
public class DomainLoaderDao {
	
	@PersistenceContext
	private EntityManager entityManager;
	
	public Object load(Class<?> clazz, long id) {
		return entityManager.find(clazz, id);
	}
	
}
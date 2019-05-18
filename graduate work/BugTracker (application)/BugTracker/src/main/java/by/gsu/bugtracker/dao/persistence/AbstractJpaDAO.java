package by.gsu.bugtracker.dao.persistence;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import by.gsu.bugtracker.dao.IDao;
import by.gsu.bugtracker.domain.GenericDomainObject;

@Repository
public abstract class AbstractJpaDAO<T extends GenericDomainObject> implements IDao<T>{

    private Class<T> clazz;

    @PersistenceContext
    protected EntityManager entityManager;

    public AbstractJpaDAO(Class<T> clazzToSet) {
        this.clazz = clazzToSet;
    }
    
    @Override
    public T getById(long id) {
        return entityManager.find(clazz, id);
    }
    
    @Override
    @SuppressWarnings("unchecked")
    public List<T> getAll() {
        return entityManager.createQuery("from " + clazz.getName()).getResultList();
    }
    
    @Override
    @Transactional
    public void create(T entity) {
        entityManager.persist(entity);
    }
    
    @Override
    public T update(T entity) {
        return entityManager.merge(entity);
    }
    
    @Override
    public void delete(T entity) {
        entityManager.remove(entity);
    }
    
    @Override
    public void deleteById(long entityId) {
    	T entity = getById(entityId);
        delete(entity);
    }
    
    @Override
    public long getAllCount() {
		return getAll().size();
    }
    
    @SuppressWarnings("unchecked")
	@Override
	public <E extends GenericDomainObject> List<E> getProperties(Class<E> clazz) {
		return entityManager.createQuery("FROM " + clazz.getName()).getResultList();
	}
	
	@Override
	public <E extends GenericDomainObject> E getProperty(Class<E> clazz, Long id) {
		return entityManager.find(clazz, id);
	}
	
	@Override
	public <E extends GenericDomainObject> void createProperty(E entity) {
		entityManager.persist(entity);
	}
	
	@Override
	public <E extends GenericDomainObject> void updateProperty(E entity) {
		entityManager.merge(entity);
	}
	
}

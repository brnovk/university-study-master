package by.gsu.bugtracker.service.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import by.gsu.bugtracker.dao.IDao;
import by.gsu.bugtracker.domain.GenericDomainObject;
import by.gsu.bugtracker.service.IGenericService;

public abstract class AbstractGenericService<T extends GenericDomainObject> 
		implements IGenericService<T> {
	
	private static final Logger LOG = Logger.getLogger(AbstractGenericService.class);

	public AbstractGenericService() { }

	protected abstract IDao<T> getDao();

	@Override
	@Transactional(readOnly = true)
	public T getById(long id) {
		return getDao().getById(id);
	}

	@Override
	@Transactional(readOnly = true)
	public List<T> getAll() {
		return getDao().getAll();
	}

	@Override
	@Transactional
	public void create(T entity) {
		getDao().create(entity);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public T update(T entity) {
		LOG.debug("Updating entity: " + entity);
		T originalEntity = getDao().getById(entity.getId());
		LOG.debug("Updating originalEntity: " + originalEntity);
		originalEntity.copyNonNullFields(entity);
		return originalEntity;
	}

	@Override
	@Transactional
	public void delete(T entity) {
		getDao().delete(entity);

	}

	@Override
	@Transactional
	public void deleteById(long entityId) {
		getDao().deleteById(entityId);
	}

	@Override
	@Transactional(readOnly = true)
	public long getAllCount() {
		return getDao().getAllCount();
	}

	@Override
	@Transactional(readOnly = true)
	public <E extends GenericDomainObject> List<E> getProperties(Class<E> clazz) {
		return getDao().getProperties(clazz);
	}

	@Override
	@Transactional(readOnly = true)
	public <E extends GenericDomainObject> E getProperty(Class<E> clazz, Long id) {
		return getDao().getProperty(clazz, id);
	}

	@Override
	@Transactional
	public <E extends GenericDomainObject> void createProperty(E entity) {
		getDao().createProperty(entity);
	}

	@Override
	@Transactional
	public <E extends GenericDomainObject> void updateProperty(E entity) {
		getDao().updateProperty(entity);
	}
}

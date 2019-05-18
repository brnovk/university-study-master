package by.gsu.bugtracker.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import by.gsu.bugtracker.dao.IDao;
import by.gsu.bugtracker.domain.GenericDomainObject;

public abstract class AbstractGenericService<T extends GenericDomainObject> 
		implements IGenericService<T> {

	public AbstractGenericService() { }
	
	protected abstract IDao<T> getDao();
	
	@Override
	@Transactional
	public T getById(long id) {
		return getDao().getById(id);
	}

	@Override
	@Transactional
	public List<T> getAll() {
		return getDao().getAll();
	}

	@Override
	@Transactional
	public void create(T entity) {
		getDao().create(entity);
	}

	@Override
	@Transactional
	public T update(T entity) {
		return getDao().update(entity);
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
	@Transactional
	public long getAllCount() {
		return getDao().getAllCount();
	}
}

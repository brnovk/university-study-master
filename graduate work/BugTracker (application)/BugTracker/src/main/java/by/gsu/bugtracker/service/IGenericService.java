package by.gsu.bugtracker.service;

import java.util.List;
import by.gsu.bugtracker.domain.GenericDomainObject;

public interface IGenericService<E extends GenericDomainObject> {

	E getById(long id);
	List<E> getAll();
	void create(E entity);
	E update(E entity);
	void delete(E entity);
	void deleteById(long entityId);
	long getAllCount();
	
	<T extends GenericDomainObject> List<T> getProperties(Class<T> clazz);
	<T extends GenericDomainObject> T getProperty(Class<T> clazz, Long id);
	<T extends GenericDomainObject> void createProperty(T entity);
	<T extends GenericDomainObject> void updateProperty(T entity);
}

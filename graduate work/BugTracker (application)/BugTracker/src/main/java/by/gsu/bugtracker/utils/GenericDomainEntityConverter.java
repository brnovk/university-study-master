package by.gsu.bugtracker.utils;

import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.TypeDescriptor;
import org.springframework.core.convert.converter.GenericConverter;

import by.gsu.bugtracker.dao.persistence.DomainLoaderDao;

public class GenericDomainEntityConverter implements GenericConverter {
	
	@Autowired
	private DomainLoaderDao domainLoaderDao;

	private Set<Class<?>> domainClasses;

    public Set<ConvertiblePair> getConvertibleTypes() {
        Set<ConvertiblePair> convertablePairs = new HashSet<ConvertiblePair>();
        for (Class<?> domainClass : domainClasses) {
            convertablePairs.add(new ConvertiblePair(String.class, domainClass));
        }
        return convertablePairs;
    }

    public Object convert(Object source, TypeDescriptor sourceType, TypeDescriptor targetType) {
        return domainLoaderDao.load(targetType.getType(), new Long(source.toString()));
    }

    public void setDomainLoaderDao(DomainLoaderDao domainLoaderDao) {
        this.domainLoaderDao = domainLoaderDao;
    }

    public void setDomainClasses(Set<Class<?>> domainClasses) {
        this.domainClasses = domainClasses;
    }
}

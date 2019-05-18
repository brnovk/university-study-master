package by.gsu.bugtracker.dao.persistence;

import java.util.List;

import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import by.gsu.bugtracker.constants.Constants;
import by.gsu.bugtracker.dao.IProjectDao;
import by.gsu.bugtracker.domain.Build;
import by.gsu.bugtracker.domain.PaginationParams;
import by.gsu.bugtracker.domain.Project;

@Repository
public class PProjectJpaDao extends AbstractJpaDAO<Project> implements IProjectDao {

	public PProjectJpaDao() {
		super(Project.class);
	}

	@Override
	public List<Build> getBuildsByProjectId(long projectId) {
		return entityManager.find(Project.class, projectId).getBuilds();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Project> getProjectsList(Integer count) {
		Query query = entityManager.createQuery("FROM Project p ORDER BY p.name ASC");
		if (count != null) {
			query.setMaxResults(count);
		}
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Project> getSortedProjectsList(PaginationParams params) {
		
		String stringQuery = "SELECT p.id, p.name, m.emailAddress, "
			+ "p.description FROM Project p LEFT JOIN p.manager m";
		stringQuery += " ORDER BY p." + params.getStringOrderBy() + " " + params.getOrder();
		Query query = entityManager.createQuery(stringQuery);
		query.setFirstResult(params.getPage() * Constants.NUMBER_PROJECTS);
		query.setMaxResults(Constants.NUMBER_PROJECTS);
		return query.getResultList();
	}
	
	@Override
	public long getProjectsCount() {
		Query query = entityManager.createQuery("SELECT count(*) FROM Project");
		return (long) query.getSingleResult(); 
	}
}

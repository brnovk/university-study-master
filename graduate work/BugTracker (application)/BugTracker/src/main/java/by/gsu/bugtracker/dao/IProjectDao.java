package by.gsu.bugtracker.dao;

import java.util.List;

import by.gsu.bugtracker.domain.Build;
import by.gsu.bugtracker.domain.PaginationParams;
import by.gsu.bugtracker.domain.Project;

public interface IProjectDao extends IDao<Project> {
	
	List<Build> getBuildsByProjectId(long projectId);
	List<Project> getSortedProjectsList(PaginationParams params);
	long getProjectsCount();
	List<Project> getProjectsList(Integer count);
}

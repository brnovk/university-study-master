package by.gsu.bugtracker.service;

import java.util.List;
import by.gsu.bugtracker.domain.*;

public interface IProjectService extends IGenericService<Project> {

	List<Build> getBuildsByProjectId(long projectId);
	void createBuild(Build build, Long projectId);
	List<Project> getSortedProjectsList(PaginationParams params);
	Integer getProjectsPages();
	List<Project> getProjectsList();
}

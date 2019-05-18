package by.gsu.bugtracker.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import by.gsu.bugtracker.constants.Constants;
import by.gsu.bugtracker.dao.*;
import by.gsu.bugtracker.domain.*;
import by.gsu.bugtracker.service.IProjectService;

@Service
public class ProjectService extends AbstractGenericService<Project> 
		implements IProjectService {
	
	private static final Logger LOG = Logger.getLogger(ProjectService.class);
	
	@Inject
	private IProjectDao projectDao;
	
	@Override
	protected IDao<Project> getDao() {
		return projectDao;
	}

	@Override
	@Transactional(readOnly=true)
	public List<Build> getBuildsByProjectId(long projectId) {
		return projectDao.getBuildsByProjectId(projectId);
	}

	@Override
	@Transactional(readOnly=true)
	public List<Project> getProjectsList() {
		return projectDao.getProjectsList(Constants.NUMBER_PROJECTS);
	}

	@Override
	@Transactional
	public void createBuild(Build build, Long projectId) {
		LOG.debug("Creating build: " + build);
		Project project = projectDao.getById(projectId);
		project.getBuilds().add(build);
		projectDao.createProperty(build);
		LOG.debug("after savin" + build);
	}

	@Override
	@Transactional(readOnly=true)
	public List<Project> getSortedProjectsList(PaginationParams params) {
		return projectDao.getSortedProjectsList(params);
	}
	
	@Override
	@Transactional(readOnly=true)
	public Integer getProjectsPages() {
		return (int) Math.ceil((double) projectDao.getProjectsCount() 
			/ Constants.NUMBER_PROJECTS);
	}
}

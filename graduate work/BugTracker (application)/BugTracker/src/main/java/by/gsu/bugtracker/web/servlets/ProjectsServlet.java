package by.gsu.bugtracker.web.servlets;

import java.security.Principal;
import java.util.List;

import javax.inject.Inject;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;

import by.gsu.bugtracker.domain.*;
import by.gsu.bugtracker.service.IProjectService;

@Controller
@RequestMapping(value = "/Admin/Projects")
public class ProjectsServlet {

	private static final Logger LOG = Logger.getLogger(ProjectsServlet.class);

	@Inject
	private IProjectService projectService;

	@RequestMapping(value = "/Add", method = RequestMethod.GET)
	public String addProject(Model model) {
		model.addAttribute(new Project());
		model.addAttribute(projectService.getProperties(User.class));
		return "AddProject";
	}

	@RequestMapping(value = "/Add", method = RequestMethod.POST)
	public String addProjectFromForm(@Valid @ModelAttribute("project") Project project,
			BindingResult result, Model model) {
		if (result.hasErrors() || project.getBuilds().get(0).getName().length() == 0) {
			model.addAttribute(projectService.getProperties(User.class));
			return "AddProject";
		}
		projectService.create(project);
		return "redirect:/Issues";
	}

	@RequestMapping(value = "/List", method = RequestMethod.GET)
	public String projectsList(Model model) {
		model.addAttribute(projectService.getProjectsList());
		model.addAttribute("pages", projectService.getProjectsPages());
		return "ProjectsList";
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String editProject(@PathVariable("id") long projectId, Model model) {
		model.addAttribute(projectService.getById(projectId));
		model.addAttribute(projectService.getProperties(User.class));
		model.addAttribute(projectService.getBuildsByProjectId(projectId));
		model.addAttribute(new Build());
		return "EditProject";
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.POST)
	public String editProjectFromForm(@Valid @ModelAttribute("project") Project project,
			Errors errors, Model model, @PathVariable("id") long projectId) {
		LOG.debug("Saving project: " + project);
		if (errors.hasErrors()) {
			model.addAttribute(projectService.getProperties(User.class));
			model.addAttribute(projectService.getBuildsByProjectId(projectId));
			model.addAttribute(new Build());
			return "EditProject";
		}
		projectService.update(project);
		return "redirect:/Issues";
	}

	@RequestMapping(value = "/{id}/AddBuild", method = RequestMethod.POST)
	public String addBuildFromForm(@Valid @ModelAttribute("build") Build build,
			Errors errors, @PathVariable("id") long projectId, Model model) {
		LOG.debug("Saving build: " + build);
		if (errors.hasErrors()) {
			model.addAttribute(projectService.getById(projectId));
			model.addAttribute(projectService.getProperties(User.class));
			model.addAttribute(projectService.getBuildsByProjectId(projectId));
			return "EditProject";
		}
		build.setId(0);
		projectService.createBuild(build, projectId);
		return "redirect:/Admin/Projects/{id}";
	}

	@RequestMapping(value = "/Paginator", method = RequestMethod.GET)
	public @ResponseBody List<Project> getIssues(Principal principal, 
			@RequestParam("orderby") Integer orderBy, @RequestParam("order") Integer order, 
			@RequestParam("page") Integer page) {
		ProjectPaginationParams params = new ProjectPaginationParams(page, orderBy, order);
		return projectService.getSortedProjectsList(params);
	}
}

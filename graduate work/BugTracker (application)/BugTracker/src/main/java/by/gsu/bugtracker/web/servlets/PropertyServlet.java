package by.gsu.bugtracker.web.servlets;

import javax.inject.Inject;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;

import by.gsu.bugtracker.domain.*;
import by.gsu.bugtracker.service.IIssueService;

@Controller
@RequestMapping(value = "/Admin")
public class PropertyServlet {

	@SuppressWarnings("unused")
	private static final Logger LOG = Logger.getLogger(PropertyServlet.class);

	@Inject
	private IIssueService issueService;

	@RequestMapping(value = "/Priorities/Add", method = RequestMethod.GET)
	public String addPriority(Model model) {
		model.addAttribute(new Priority());
		return "AddPriority";
	}

	@RequestMapping(value = "/Priorities/Add", method = RequestMethod.POST)
	public String addPriorityFromForm(@Valid @ModelAttribute("priority") Priority priority, 
			Errors errors) {
		if (errors.hasErrors()) {
			return "AddPriority";
		}
		issueService.createProperty(priority);
		return "redirect:/Issues";
	}

	@RequestMapping(value = "/Priorities/List", method = RequestMethod.GET)
	public String prioritiesList(Model model) {
		model.addAttribute(issueService.getProperties(Priority.class));
		return "PrioritiesList";
	}

	@RequestMapping(value = "/Priorities/{id}", method = RequestMethod.GET)
	public String editPriority(@PathVariable("id") long priorityId, Model model) {
		model.addAttribute(issueService.getProperty(Priority.class, priorityId));
		return "EditPriority";
	}

	@RequestMapping(value = "/Priorities/{id}", method = RequestMethod.POST)
	public String editPriorityFromForm(@Valid @ModelAttribute("priority") Priority priority,
			Errors errors) {
		if (errors.hasErrors()) {
			return "EditPriority";
		}
		issueService.updateProperty(priority);
		return "redirect:/Issues";
	}

	@RequestMapping(value = "/Types/Add", method = RequestMethod.GET)
	public String addType(Model model) {
		model.addAttribute(new Type());
		return "AddType";
	}

	@RequestMapping(value = "/Types/Add", method = RequestMethod.POST)
	public String addTypeFromForm(@Valid @ModelAttribute("type") Type type,
			Errors errors) {
		if (errors.hasErrors()) {
			return "AddType";
		}
		issueService.createProperty(type);
		return "redirect:/Issues";
	}
	
	@RequestMapping(value = "/Types/List", method = RequestMethod.GET)
	public String typesList(Model model) {
		model.addAttribute(issueService.getProperties(Type.class));
		return "TypesList";
	}

	@RequestMapping(value = "/Types/{id}", method = RequestMethod.GET)
	public String editType(@PathVariable("id") long typeId, Model model) {
		model.addAttribute(issueService.getProperty(Type.class, typeId));
		return "EditType";
	}

	@RequestMapping(value = "/Types/{id}", method = RequestMethod.POST)
	public String editTypeFromForm(@Valid @ModelAttribute("type") Type type,
			Errors errors) {
		if (errors.hasErrors()) {
			return "EditType";
		}
		issueService.updateProperty(type);
		return "redirect:/Issues";
	}

	@RequestMapping(value = "/Resolutions/Add", method = RequestMethod.GET)
	public String addResolution(Model model) {
		model.addAttribute(new Resolution());
		return "AddResolution";
	}

	@RequestMapping(value = "/Resolutions/Add", method = RequestMethod.POST)
	public String addResolutionFromForm(@Valid @ModelAttribute("resolution") Resolution resolution,
			Errors errors) {
		if (errors.hasErrors()) {
			return "AddResolution";
		}
		issueService.createProperty(resolution);
		return "redirect:/Issues";
	}

	@RequestMapping(value = "/Resolutions/List", method = RequestMethod.GET)
	public String resolutionsList(Model model) {
		model.addAttribute(issueService.getProperties(Resolution.class));
		return "ResolutionsList";
	}

	@RequestMapping(value = "/Resolutions/{id}", method = RequestMethod.GET)
	public String editResolution(@PathVariable("id") long resolutionId, Model model) {
		model.addAttribute(issueService.getProperty(Resolution.class, resolutionId));
		return "EditResolution";
	}

	@RequestMapping(value = "/Resolutions/{id}", method = RequestMethod.POST)
	public String editResolutionFromForm(@Valid @ModelAttribute("resolution") Resolution resolution,
			Errors errors) {
		if (errors.hasErrors()) {
			return "EditResolution";
		}
		issueService.updateProperty(resolution);
		return "redirect:/Issues";
	}

	@RequestMapping(value = "/Statuses/List", method = RequestMethod.GET)
	public String statusesList(Model model) {
		model.addAttribute(issueService.getProperties(Status.class));
		return "StatusesList";
	}

	@RequestMapping(value = "/Statuses/{id}", method = RequestMethod.GET)
	public String editStatus(@PathVariable("id") long statusId, Model model) {
		model.addAttribute(issueService.getProperty(Status.class, statusId));
		return "EditStatus";
	}

	@RequestMapping(value = "/Statuses/{id}", method = RequestMethod.POST)
	public String editStatusFromForm(@Valid @ModelAttribute("status") Status status, Errors errors) {
		if (errors.hasErrors()) {
			return "EditStatus";
		}
		issueService.updateProperty(status);
		return "redirect:/Issues";
	}
}

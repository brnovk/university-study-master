package by.gsu.bugtracker.web.servlets;

import javax.inject.Inject;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;

import by.gsu.bugtracker.domain.User;
import by.gsu.bugtracker.model.enums.UserRoles;
import by.gsu.bugtracker.service.IUserService;

@Controller
@RequestMapping(value = "/Admin/Users")
public class UsersServlet {
	
	private static final Logger LOG = Logger.getLogger(UsersServlet.class);

	@Inject
	private IUserService userService;

	@RequestMapping(value = "/Add", method = RequestMethod.GET)
	public String addUser(Model model) {
		model.addAttribute(new User());
		model.addAttribute("roles", UserRoles.values());
		return "AddUser";
	}

	@RequestMapping(value = "/Add", method = RequestMethod.POST)
	public String addUserFromForm(@Valid @ModelAttribute("user") User user, 
			Errors errors, Model model) {
		if (errors.hasErrors()) {
			model.addAttribute("roles", UserRoles.values());
			return "AddUser";
		}
		userService.create(user);
		return "redirect:/Issues";
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String editUser(@PathVariable("id") long userId, Model model) {
		model.addAttribute(userService.getById(userId));
		model.addAttribute("roles", UserRoles.values());
		return "EditUser";
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.POST)
	public String editUserFromForm(SessionRegistryImpl sessionRegistry, 
			@Valid @ModelAttribute("user") User user, Errors errors, Model model, 
			@PathVariable("id") long userId) {
		if (errors.hasErrors()) {
			model.addAttribute("roles", UserRoles.values());
			return "EditUser";
		}
		LOG.info(user);
		user.setId(userId);
		userService.update(user);
		return "redirect:/Issues";
	}

	@RequestMapping(value = "/Search", method = RequestMethod.GET)
	public String searchIssues(Model model) {
		model.addAttribute(new User());
		return "SearchUsers";
	}

	@RequestMapping(value = "/Search", method = RequestMethod.POST)
	public String searchIssuesFromForm(@ModelAttribute("user") User user, Model model) {
		model.addAttribute(userService.getFoundUsersList(user));
		return "SearchUsers";
	}
}

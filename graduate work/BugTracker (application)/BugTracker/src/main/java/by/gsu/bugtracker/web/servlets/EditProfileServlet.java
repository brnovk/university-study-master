package by.gsu.bugtracker.web.servlets;

import java.security.Principal;

import javax.inject.Inject;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;

import by.gsu.bugtracker.domain.User;
import by.gsu.bugtracker.service.IUserService;

@Controller
@RequestMapping(value = "/Users")
public class EditProfileServlet {

	private static final Logger LOG = Logger.getLogger(EditProfileServlet.class);
	
	@Inject
	private IUserService userService;
	
	@RequestMapping(value = "/editSelfUser", method = RequestMethod.GET)
	public String editSelfUser(Principal principal, Model model) {
		User user = null;
		if (principal != null) {
			user = userService.getUserByEmail(principal.getName());
		}
		model.addAttribute(user);
		return "EditSelfUser";
	}
	
	@RequestMapping(value = "/editSelfUser", method = RequestMethod.POST)
	public String editSelfUserFromForm(@Valid @ModelAttribute("user") User user,
			Errors errors, Principal principal, Model model) {
		if (errors.hasErrors()) {
			return "EditSelfUser";
		}
		User currentUser = null;
		if (principal != null) {
			LOG.info(principal);
			currentUser = userService.getUserByEmail(principal.getName());
		}
		user.setId(currentUser.getId());
		LOG.info(user);
		userService.update(user);
		return "redirect:/logout";
	}
}

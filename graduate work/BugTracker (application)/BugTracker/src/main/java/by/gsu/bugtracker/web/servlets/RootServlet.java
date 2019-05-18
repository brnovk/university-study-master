package by.gsu.bugtracker.web.servlets;

import java.security.Principal;
import java.util.List;

import javax.inject.Inject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import by.gsu.bugtracker.domain.*;
import by.gsu.bugtracker.service.*;

@Controller
public class RootServlet {

	@SuppressWarnings("unused")
	private static final Logger LOG = Logger.getLogger(RootServlet.class);
	
	@Inject
	private IIssueService issueService;

	@Inject
	private IUserService userService;

	@RequestMapping("/")
	public String home() {
		return "redirect:/Issues";
	}

	@RequestMapping(value = "/Issues", method = RequestMethod.GET)
	public String showIssuesList(Principal principal, Model model) {
		User user = null;
		if (principal != null) {
			user = userService.getUserByEmail(principal.getName());
		}
		model.addAttribute(issueService.getIssuesList(user));
		model.addAttribute("pages", issueService.getIssuesPages(user));
		return "Issues";
	}

	@RequestMapping(value = "/IssuesPaginator", method = RequestMethod.GET)
	public @ResponseBody List<Issue> getIssues(Principal principal, 
			@RequestParam("orderby") Integer orderBy, 
			@RequestParam("order") Integer order, @RequestParam("page") Integer page) {
		User user = null;
		if (principal != null) {
			user = userService.getUserByEmail(principal.getName());
		}
		IssuePaginationParams params = new IssuePaginationParams(page, orderBy, order);
		return issueService.getSortedIssuesList(user, params);
	}

	@RequestMapping(value = "/ViewIssue/{id}", method = RequestMethod.GET)
	public String viewIssue(@PathVariable("id") long issueId, Model model) {
		model.addAttribute(issueService.getById(issueId));
		return "ViewIssue";
	}

	@RequestMapping(value = "/Search", method = RequestMethod.GET)
	public String searchIssues(Model model) {
		model.addAttribute(new SearchIssue());
		model.addAttribute(issueService.getProperties(Status.class));
		model.addAttribute(issueService.getProperties(Type.class));
		model.addAttribute(issueService.getProperties(Priority.class));
		model.addAttribute(issueService.getProperties(Resolution.class));
		model.addAttribute(issueService.getProperties(Project.class));
		model.addAttribute(issueService.getProperties(User.class));
		return "SearchIssues";
	}

	@RequestMapping(value = "/Search", method = RequestMethod.POST)
	public String searchIssuesFromForm(@ModelAttribute("searchIssue") SearchIssue searchIssue,
			Model model) {
		model.addAttribute(issueService.getFoundIssuesList(searchIssue));
		model.addAttribute(issueService.getProperties(Status.class));
		model.addAttribute(issueService.getProperties(Type.class));
		model.addAttribute(issueService.getProperties(Priority.class));
		model.addAttribute(issueService.getProperties(Resolution.class));
		model.addAttribute(issueService.getProperties(Project.class));
		model.addAttribute(issueService.getProperties(User.class));
		return "SearchIssues";
	}
}

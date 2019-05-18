package by.gsu.bugtracker.web.servlets;

import java.io.*;
import java.security.Principal;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.*;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import by.gsu.bugtracker.constants.Constants;
import by.gsu.bugtracker.domain.*;
import by.gsu.bugtracker.service.*;

@Controller
@RequestMapping(value = "/Issues")
public class IssuesServlet {
	
	private static final String DEF_MIME_TYPE = "application/octet-stream";
	
	@SuppressWarnings("unused")
	private static final Logger LOG = Logger.getLogger(IssuesServlet.class);

	@Inject
	private IIssueService issueService;

	@Inject
	private IUserService userService;

	@Inject
	private IProjectService projectService;

	@RequestMapping(value = "/Add", method = RequestMethod.GET)
	public String createIssue(Model model) {
		model.addAttribute(new Issue());
		model.addAttribute(issueService.getNewStatuses());
		model.addAttribute(issueService.getProperties(Type.class));
		model.addAttribute(issueService.getProperties(Priority.class));
		model.addAttribute(issueService.getProperties(Project.class));
		model.addAttribute(issueService.getProperties(User.class));
		return "AddIssue";
	}

	@RequestMapping(value = "/Add", method = RequestMethod.POST)
	public String createIssueFromForm(Principal principal, 
			@Valid @ModelAttribute("issue") Issue issue, Errors errors, Model model) {
		if (errors.hasErrors()) {
			model.addAttribute(issueService.getNewStatuses());
			model.addAttribute(issueService.getProperties(Type.class));
			model.addAttribute(issueService.getProperties(Priority.class));
			model.addAttribute(issueService.getProperties(Project.class));
			model.addAttribute(issueService.getProperties(User.class));
			return "AddIssue";
		}
		issue.setCreatedBy(userService.getUserByEmail(principal.getName()));
		issueService.createWithNotification(issue);
		return "redirect:/Issues";
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String editIssue(@PathVariable("id") long issueId, Model model) {
		long idStatus = issueService.getById(issueId).getStatus().getId();
		model.addAttribute(issueService.getById(issueId));
		model.addAttribute(new Comment());
		model.addAttribute(getStatusSublistByStatusId(idStatus));
		model.addAttribute(issueService.getProperties(Type.class));
		model.addAttribute(issueService.getProperties(Priority.class));
		model.addAttribute(issueService.getProperties(Resolution.class));
		model.addAttribute(issueService.getProperties(Project.class));
		model.addAttribute(issueService.getProperties(User.class));
		return "EditIssue";
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.POST)
	public String editIssueFromForm(@PathVariable("id") long issueId, Model model, 
			Principal principal, @Valid @ModelAttribute("issue") Issue issue, Errors errors) {
		if (errors.hasErrors()) {
			long idStatus = issueService.getById(issueId).getStatus().getId();
			model.addAttribute(issueService.getById(issueId));
			model.addAttribute(getStatusSublistByStatusId(idStatus));
			model.addAttribute(issueService.getProperties(Type.class));
			model.addAttribute(issueService.getProperties(Priority.class));
			model.addAttribute(issueService.getProperties(Resolution.class));
			model.addAttribute(issueService.getProperties(Project.class));
			model.addAttribute(issueService.getProperties(User.class));
			return "EditIssue";
		}
		issue.setCreatedBy(issueService.getById(issueId).getCreatedBy());
		issue.setModifiedBy(userService.getUserByEmail(principal.getName()));
		issue.setId(issueId);
		issueService.updateWithNotification(issue);
		return "redirect:/Issues";
	}
	
	@RequestMapping(value = "/{id}/AddComment", method = RequestMethod.POST)
	public String createCommentFromForm(@PathVariable("id") long issueId, 
			Principal principal, @Valid @ModelAttribute("comment") Comment comment, 
			Errors errors, Model model) {
		if (errors.hasErrors()) {
			model.addAttribute(issueService.getById(issueId));
			model.addAttribute(issueService.getProperties(Status.class));
			model.addAttribute(issueService.getProperties(Type.class));
			model.addAttribute(issueService.getProperties(Priority.class));
			model.addAttribute(issueService.getProperties(Resolution.class));
			model.addAttribute(issueService.getProperties(Project.class));
			model.addAttribute(issueService.getProperties(User.class));
			return "EditIssue";
		}
		comment.setAddedBy(userService.getUserByEmail(principal.getName()));
		comment.setId(0);
		comment.setIssue(issueService.getById(issueId));
		issueService.createProperty(comment);
		return "redirect:/Issues/" + issueId;
	}
	
	@RequestMapping(value = "/{id}/AddFile", method = RequestMethod.POST)
	public String createFileFromForm(@PathVariable("id") long issueId, Principal principal, 
			@RequestParam(value="file", required=false) MultipartFile file, Model model, 
			HttpServletRequest request) {
		if (file.isEmpty()) {
			model.addAttribute(new Comment());
			model.addAttribute(issueService.getById(issueId));
			model.addAttribute(issueService.getProperties(Status.class));
			model.addAttribute(issueService.getProperties(Type.class));
			model.addAttribute(issueService.getProperties(Priority.class));
			model.addAttribute(issueService.getProperties(Resolution.class));
			model.addAttribute(issueService.getProperties(Project.class));
			model.addAttribute(issueService.getProperties(User.class));
			return "EditIssue";
		}
		Attachment attachment = new Attachment();
		User user = userService.getUserByEmail(principal.getName());
		attachment.setAddedBy(user);
		attachment.setIssue(issueService.getById(issueId));
		attachment.setFileName(file.getOriginalFilename());
		attachment.setFilePath(request.getServletContext().getRealPath(
			Constants.USER_FILES_PATH) + Constants.PATH_SEPARATOR 
			+ issueId + Constants.PATH_SEPARATOR);
		issueService.createAttachment(attachment, file);
		return "redirect:/Issues/" + issueId;
	}

	@RequestMapping(value = "/{id}/{attachmentId}")
	public void downloadFile(@PathVariable("id") long issueId, 
			@PathVariable("attachmentId") long attachmentId, HttpServletRequest request, 
			HttpServletResponse response) throws FileNotFoundException, IOException {
		Attachment attachment = issueService.getProperty(Attachment.class, attachmentId);
		String filePath = attachment.getFilePath() + attachmentId;
	    String mimetype = request.getServletContext().getMimeType(filePath);
	    if(mimetype == null){
            mimetype = DEF_MIME_TYPE;
        }
		File file = new File(filePath);
		response.setContentType(mimetype);
        response.setContentLength((int)file.length());
        response.setHeader("Content-Disposition","attachment; filename=\"" 
        		+ attachment.getFileName() +"\"");
		FileCopyUtils.copy(new FileInputStream(file), response.getOutputStream());
	}

	@RequestMapping(value = "/Builds/{id}", method = RequestMethod.GET)
	public @ResponseBody List<Build> getBuilds(@PathVariable("id") long projectId) {
		return projectService.getBuildsByProjectId(projectId);
	}

	private List<Status> getStatusSublistByStatusId(long statusId) {
		switch ((int)statusId) {
			case 1: return issueService.getNewStatuses();
			case 2: return issueService.getAssignedStatuses();
			case 3: case 4: 
					return issueService.getInprogressStatuses();
			case 5: return issueService.getClosedStatuses();
			case 6: return issueService.getReopenedStatuses();
			default: throw new IllegalStateException(Long.toString(statusId));
		}
	}
}

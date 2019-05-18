package by.gsu.bugtracker.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.mail.MailException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import by.gsu.bugtracker.constants.Constants;
import by.gsu.bugtracker.dao.*;
import by.gsu.bugtracker.domain.*;
import by.gsu.bugtracker.service.*;

@Service
public class IssueService extends AbstractGenericService<Issue> 
		implements IIssueService {
	
	private static final Logger LOG = Logger.getLogger(IssueService.class);
	
	@Inject
	private IIssueDao issueDao;
	
	@Inject
	private IUserDao userDao;
	
	@Inject
	private INotificationSender myMailSender;

	private IssueService() {
		super();
	}

	@Override
	protected IDao<Issue> getDao() {
		return issueDao;
	}

	@Override
	@Transactional
	public Issue updateWithNotification(Issue entity) {
		Issue issue = update(entity);
		final String messageAssignee = String.format("Issue number \"%d\", for which you "
				+ "are assigned to be responsible, it has been updated", entity.getId());
		final String messageCreated = String.format("Issue number \"%d\", which you have "
				+ "created, it has been updated", entity.getId());
		try {
			User assignee = entity.getAssignee();
			User createdBy = entity.getCreatedBy();
			if ((assignee != null) && (createdBy != null) && (assignee.getId() == createdBy.getId())) {
				// If a reporter and singer - one person
				String email = entity.getCreatedBy().getEmailAddress();
				myMailSender.sendNotification(new Notification(email, messageCreated + "\n\n" + messageAssignee));
			} else {
				if (assignee != null) {
					String email = userDao.getById(assignee.getId()).getEmailAddress();
					myMailSender.sendNotification(new Notification(email, messageAssignee));
				}
				if (createdBy != null) {
					String email = entity.getCreatedBy().getEmailAddress();
					myMailSender.sendNotification(new Notification(email, messageCreated));
				}
			}
		} catch (MailException e) {
			LOG.debug("notify on update fail", e);
		}
		return issue;
	}

	@Override
	@Transactional
	public void createWithNotification(Issue entity) {
		create(entity);
		final String messageAssignee = String.format("Report the new issue number \"%d\"."
				+ "\nYou are assigned responsible for correcting.", entity.getId());
		final String messageCreated = String.format("You reported a new issue number \"%d\".",
				entity.getId());
		try {
			User assignee = entity.getAssignee();
			User createdBy = entity.getCreatedBy();
			if ((assignee != null) && (createdBy != null) && (assignee.getId() == createdBy.getId())) {
				// If a reporter and singer - one person
				String email = entity.getCreatedBy().getEmailAddress();
				myMailSender.sendNotification(new Notification(email, messageCreated + "\n\n" + messageAssignee));
			} else {
				if (assignee != null) {
					String email = userDao.getById(assignee.getId()).getEmailAddress();
					myMailSender.sendNotification(new Notification(email, messageAssignee));
				}
				if (createdBy != null) {
					String email = entity.getCreatedBy().getEmailAddress();
					myMailSender.sendNotification(new Notification(email, messageCreated));
				}
			}
		} catch (MailException e) {
			LOG.debug("notify on create fail", e);
		}
	}

	@Override
	@Transactional(readOnly=true)
	public List<Issue> getIssuesList(User user) {
		if (user == null) {
			return issueDao.getLastIssues(Constants.NUMBER_ISSUES);
		} else {
			return issueDao.getIssuesByUserId(user, Constants.NUMBER_ISSUES);
		}
	}
	@Override
	@Transactional(readOnly=true)
	public Integer getIssuesPages(User user) {
		return (int) Math.ceil((double) issueDao.getIssuesCount(user) 
			/ Constants.NUMBER_ISSUES);
	}
	
	@Override
	@Transactional(readOnly=true)
	public List<Issue> getSortedIssuesList(User user, PaginationParams params) {
		return issueDao.getSortedIssuesList(user, params);
	}
	
	@Override
	@Transactional(readOnly=true)
	public List<Status> getNewStatuses() {
		return issueDao.getProperties(Status.class).subList(0, 2);
	}
	
	@Override
	@Transactional(readOnly=true)
	public List<Status> getAssignedStatuses() {
		return issueDao.getProperties(Status.class).subList(1, 3);
	}
	
	@Override
	@Transactional(readOnly=true)
	public List<Status> getInprogressStatuses() {
		return issueDao.getProperties(Status.class).subList(2, 5);
	}
	
	@Override
	@Transactional(readOnly=true)
	public List<Status> getClosedStatuses() {
		return issueDao.getProperties(Status.class).subList(4, 6);
	}
	
	@Override
	@Transactional(readOnly=true)
	public List<Status> getReopenedStatuses() {
		List<Status> result = new ArrayList<>();
		result.add(issueDao.getProperties(Status.class).get(5));
		result.add(issueDao.getProperties(Status.class).get(1));
		return result;
	}

	@Override
	@Transactional
	public void createAttachment(Attachment attachment, MultipartFile file) {
		issueDao.createProperty(attachment);
		File newFile = new File(attachment.getFilePath() + attachment.getId());
		try {
			FileUtils.writeByteArrayToFile(newFile, file.getBytes());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	@Transactional(readOnly=true)
	public List<Issue> getFoundIssuesList(SearchIssue issue) {
		return issueDao.getFoundIssuesList(issue);
	}
}

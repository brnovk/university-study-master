package by.gsu.bugtracker.service;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import by.gsu.bugtracker.domain.*;

public interface IIssueService extends IGenericService<Issue>{
	
	List<Issue> getIssuesList(User user);
	List<Status> getNewStatuses();
	List<Status> getAssignedStatuses();
	List<Status> getInprogressStatuses();
	List<Status> getClosedStatuses();
	List<Status> getReopenedStatuses();
	List<Issue> getSortedIssuesList(User user, PaginationParams params);
	Integer getIssuesPages(User user);
	void createAttachment(Attachment attachment, MultipartFile file);
	Issue updateWithNotification(Issue entity);
	void createWithNotification(Issue entity);
	List<Issue> getFoundIssuesList(SearchIssue issue);
}

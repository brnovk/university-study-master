package by.gsu.bugtracker.dao;

import java.util.List;
import java.util.Map;

import by.gsu.bugtracker.domain.Issue;
import by.gsu.bugtracker.domain.PaginationParams;
import by.gsu.bugtracker.domain.SearchIssue;
import by.gsu.bugtracker.domain.Status;
import by.gsu.bugtracker.domain.User;

public interface IIssueDao extends IDao<Issue>{
	
	List<String> getProperties(String propName);
	Map<Integer, Status> getStatuses(int currentStatus);
	List<Status> getNewStatuses();
	List<Issue> getIssuesByUserId(User user, Integer count);
	List<Issue> getLastIssues(Integer count);
	List<Issue> getSortedIssuesList(User user, PaginationParams params);
	long getIssuesCount(User user);
	List<Issue> getFoundIssuesList(SearchIssue issue);
}

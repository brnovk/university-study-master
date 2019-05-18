package by.gsu.bugtracker.dao.persistence;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import by.gsu.bugtracker.constants.Constants;
import by.gsu.bugtracker.dao.IIssueDao;
import by.gsu.bugtracker.domain.Issue;
import by.gsu.bugtracker.domain.PaginationParams;
import by.gsu.bugtracker.domain.SearchIssue;
import by.gsu.bugtracker.domain.Status;
import by.gsu.bugtracker.domain.User;

@Repository
public class PIssueDao extends AbstractJpaDAO<Issue> implements IIssueDao {

	private static final Logger LOG = Logger.getLogger(PIssueDao.class);

	public PIssueDao() {
		super(Issue.class);
	}

	@Override
	public Map<Integer, Status> getStatuses(int currentStatus) {
		return null;
	}

	@Override
	public List<Status> getNewStatuses() {
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Issue> getLastIssues(Integer count) {

		Query query = entityManager.createQuery("FROM Issue i ORDER BY i.id");
		if (count != null) {
			query.setMaxResults(count);
		}
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Issue> getIssuesByUserId(User user, Integer count) {
		Query query = entityManager.createQuery(
			"FROM Issue i WHERE i.assignee.id = :assigneeId");
		query.setParameter("assigneeId", user.getId());
		if (count != null) {
			query.setMaxResults(count);
		}
		return query.getResultList();
	}

	@Override
	public long getIssuesCount(User user) {
		Query query;
		if (user == null) {
			query = entityManager.createQuery("SELECT count(*) FROM Issue");
		} else {
			query = entityManager.createQuery(
				"SELECT count(*) FROM Issue WHERE assignee=:assignee");
			query.setParameter("assignee", user);
		}
		return (long) query.getSingleResult();
	}

	@Override
	public List<String> getProperties(String propName) {
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Issue> getSortedIssuesList(User user, PaginationParams params) {
		String stringQuery = "SELECT i.id, i.priority, a.emailAddress, i.type, "
			+ "i.status, i.summary FROM Issue i LEFT JOIN i.assignee a";
		if (user != null) {
			stringQuery += " WHERE i.assignee.id = :assigneeId";
		}
		stringQuery += " ORDER BY i." + params.getStringOrderBy() + " " + params.getOrder();
		Query query = entityManager.createQuery(stringQuery);
		if (user != null) {
			query.setParameter("assigneeId", user.getId());
		}
		query.setFirstResult(params.getPage() * Constants.NUMBER_ISSUES);
		query.setMaxResults(Constants.NUMBER_ISSUES);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Issue> getFoundIssuesList(SearchIssue issue) {
		LOG.info(issue);
		Map<String, String> parameters = new HashMap<>();
		StringBuffer queryBuf = new StringBuffer("from Issue i ");
		boolean firstClause = true;
		if (issue.getAssigneeEmail() != null && !"".equals(issue.getAssigneeEmail())) {
			queryBuf.append(firstClause ? " where " : " and ");
			queryBuf.append("i.assignee.emailAddress = :assigneeEmail");
			parameters.put("assigneeEmail", issue.getAssigneeEmail());
			firstClause = false;
		}
		if (issue.getSummary() != null && !"".equals(issue.getSummary())) {
			queryBuf.append(firstClause ? " where " : " and ");
			queryBuf.append("i.summary like :summary");
			parameters.put("summary", issue.getSummary() + "%");
			firstClause = false;
		}
		if (issue.getDescription() != null && !"".equals(issue.getDescription())) {
			queryBuf.append(firstClause ? " where " : " and ");
			queryBuf.append("i.description like :description");
			parameters.put("description", issue.getDescription() + "%");
			firstClause = false;
		}
		if (issue.getCreatedByEmail() != null && !"".equals(issue.getCreatedByEmail())) {
			queryBuf.append(firstClause ? " where " : " and ");
			queryBuf.append("i.createdBy.emailAddress = :createdByEmail");
			parameters.put("createdByEmail", issue.getCreatedByEmail());
			firstClause = false;
		}
		if (issue.getModifiedByEmail() != null && !"".equals(issue.getModifiedByEmail())) {
			queryBuf.append(firstClause ? " where " : " and ");
			queryBuf.append("i.modifiedBy.emailAddress = :modifiedByEmail");
			parameters.put("modifiedByEmail", issue.getModifiedByEmail());
			firstClause = false;
		}
		if (issue.getPriority() != null && !"".equals(issue.getPriority())) {
			queryBuf.append(firstClause ? " where " : " and ");
			queryBuf.append("i.priority.name = :priority");
			parameters.put("priority", issue.getPriority());
			firstClause = false;
		}
		if (issue.getStatus() != null && !"".equals(issue.getStatus())) {
			queryBuf.append(firstClause ? " where " : " and ");
			queryBuf.append("i.status.name = :status");
			parameters.put("status", issue.getStatus());
			firstClause = false;
		}
		if (issue.getResolution() != null && !"".equals(issue.getResolution())) {
			queryBuf.append(firstClause ? " where " : " and ");
			queryBuf.append("i.resolution.name = :resolution");
			parameters.put("resolution", issue.getResolution());
			firstClause = false;
		}
		if (issue.getType() != null && !"".equals(issue.getType())) {
			queryBuf.append(firstClause ? " where " : " and ");
			queryBuf.append("i.type.name = :type");
			parameters.put("type", issue.getType());
			firstClause = false;
		}
		if (issue.getProjectName() != null && !"".equals(issue.getProjectName())) {
			queryBuf.append(firstClause ? " where " : " and ");
			queryBuf.append("i.project.name = :projectName");
			parameters.put("projectName", issue.getProjectName());
			firstClause = false;
		}

		String hqlQuery = queryBuf.toString();
		Query query = entityManager.createQuery(hqlQuery);

		Iterator<String> iter = parameters.keySet().iterator();
		while (iter.hasNext()) {
			String name = iter.next();
			String value = parameters.get(name);
			query.setParameter(name, value);
		}
		return query.getResultList();
	}
}

package by.gsu.bugtracker.constants;

import by.gsu.bugtracker.domain.User;

public class Constants {
	public static final int NUMBER_ISSUES = 10;
	public static final int NUMBER_PROJECTS = 10;
	public static final long EMPTY_ID = -1;
	public static final String EMPTY_PARAMS_ERROR = "Empty params";
	public static final String EMPTY_STRING = "";
	public static final String USER = "user";
	public static final String NAME = "name";
	public static final String ROLE = "role";
	public static final String PAGE = "page";
	public static final String ORDER_BY = "orderby";
	public static final String ORDER = "order";
	public static final String EMAIL_ADDRESS = "emailaddress";
	public static final String PASSWORD = "password";
	public static final String MESSAGE = "message";
	public static final String REFERER = "referer";
	public static final String INCORRECT_LOGIN = "Login/pass incorrect";
	public static final String EMPTY_LOGIN = "Login/pass empty";
	public static final String HEADER_MENU_URL = "/HeaderMenu";
	public static final String LOGIN_ACTION_URL = "/LoginAction";
	public static final String ADD_ISSUE_URL = "/Issues/Add";
	public static final String ADD_ISSUE_ACTION_URL = "/AddIssueAction";
	public static final String EDIT_ISSUE_URL = "/Issues/Edit/";
	public static final String EDIT_ISSUE_ACTION_URL = "/EditIssueAction";
	public static final String ISSUES_URL = "/Issues";
	public static final String LOGOUT_URL = "/logout";
	public static final String SEARCH_ISSUE_URL = "/Search";
	public static final String BUILDS_AJAX_SERVLET_URL = "/BuildsAjaxServlet";
	public static final String CONNECTION_POOL = "ConnectionPool";
	public static final String USER_FILES_PATH = "\\usersfiles";
	public static final String PATH_SEPARATOR = "\\";;
	public static final User GUEST_USER = new User();
}

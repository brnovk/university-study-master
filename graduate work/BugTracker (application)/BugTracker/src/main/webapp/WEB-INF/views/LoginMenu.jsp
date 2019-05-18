<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="by.gsu.bugtracker.constants.JSPConstants"%>
<%@page import="by.gsu.bugtracker.constants.Constants"%>
<%@page import="by.gsu.bugtracker.model.enums.UserRoles"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<sec:authorize access="isAnonymous()">
<div class="clearfix">
	<div class="float-left">
		<c:if test="${not empty param.error}">
			<font color="red"> <s:message code="loginform.loginerror" />
			: ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message} </font>
		</c:if>
		<form method="POST" action="<c:url value="/j_spring_security_check" />" name="loginForm"
			onsubmit="trimLoginPassOnSubmit('loginForm','loginId','passId');">
		<table>
			<tr>
				<td align="right"><s:message code="loginform.login" />:</td>
				<td colspan="2">
					<input type="text" name="j_username" id="loginId"
						placeholder="<s:message code="loginform.login.text.placeholder"/>"/>
				</td>
			</tr>
			<tr>
				<td align="right"><s:message code="loginform.password" />:</td>
				<td colspan="2">
					<input type="password" name="j_password" id="passId"
						placeholder="<s:message code="loginform.password.text.placeholder"/>"/>
				</td>
			</tr>
			<tr>
				<td align="center" colspan="2"><s:message code="loginform.remember" /></td>
				<td align="center"><input type="checkbox" name="_spring_security_remember_me"/></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value='<s:message code="loginform.btn.login"/>' 
						title='<s:message code="loginform.btn.login.title"/>'/>
				</td>
				<td>
					<input type="reset" value='<s:message code="loginform.btn.reset"/>' 
						title='<s:message code="loginform.btn.reset.title"/>'/>
				</td>
			</tr>
		</table>
		</form>
	</div>
	<div class="float-left action-block">
		<button onclick="location.href='<c:url value="<%=Constants.SEARCH_ISSUE_URL %>"/>'" 
			title='<s:message code="mainmenu.btn.search.issue.title"/>'>
				<s:message code="mainmenu.btn.search.issue"/>
		</button>
	</div>
</div>
</sec:authorize>
<sec:authorize access="isAuthenticated()">
<div class="clearfix">
	<div class="float-left action-block">
		<button onclick="location.href='<c:url value="/Users/editSelfUser"/>'" 
			title='<s:message code="mainmenu.btn.edit.profile.title"/>'>
				<s:message code="mainmenu.btn.edit.profile"/>
		</button>
		<button onclick="location.href='<c:url value="<%=Constants.LOGOUT_URL %>"/>'" 
			title='<s:message code="mainmenu.btn.logout.title"/>'>
				<s:message code="mainmenu.btn.logout"/>
		</button>
	</div>
	<div class="float-left action-block">
		<button onclick="location.href='<c:url value="<%=Constants.ADD_ISSUE_URL %>"/>'" 
			title='<s:message code="mainmenu.btn.submit.issue.title"/>'>
				<s:message code="mainmenu.btn.submit.issue"/>
		</button>
		<button onclick="location.href='<c:url value="<%=Constants.SEARCH_ISSUE_URL %>"/>'" 
			title='<s:message code="mainmenu.btn.search.issue.title"/>'>
				<s:message code="mainmenu.btn.search.issue"/>
		</button>
	</div>
	<sec:authorize access="hasAnyAuthority('ADMINISTRATOR')">
		<div class="float-right action-block">
			<a href="<c:url value="/Admin/Projects/List"/>" 
				title='<s:message code="mainmenu.href.project.list.title"/>'>
					<s:message code="mainmenu.href.project.list"/>
			</a>
			<a href="<c:url value="/Admin/Resolutions/List"/>" 
				title='<s:message code="mainmenu.href.resolution.list.title"/>'>
					<s:message code="mainmenu.href.resolution.list"/>
			</a>
			<a href="<c:url value="/Admin/Priorities/List"/>" 
				title='<s:message code="mainmenu.href.priority.list.title"/>'>
					<s:message code="mainmenu.href.priority.list"/>
			</a>
			<a href="<c:url value="/Admin/Types/List"/>" 
				title='<s:message code="mainmenu.href.type.list.title"/>'>
					<s:message code="mainmenu.href.type.list"/>
			</a>
			<a href="<c:url value="/Admin/Statuses/List"/>" 
				title='<s:message code="mainmenu.href.status.list.title"/>'>
					<s:message code="mainmenu.href.status.list"/>
			</a>
		</div>
		<div class="float-right action-block">
			<a href="<c:url value="/Admin/Projects/Add"/>"
				title='<s:message code="mainmenu.href.add.project.title"/>'>
					<s:message code="mainmenu.href.add.project"/>
			</a>
			<a href="<c:url value="/Admin/Resolutions/Add"/>"
				title='<s:message code="mainmenu.href.add.resolution.title"/>'>
					<s:message code="mainmenu.href.add.resolution"/>
			</a>
			<a href="<c:url value="/Admin/Priorities/Add"/>"
				title='<s:message code="mainmenu.href.add.priority.title"/>'>
					<s:message code="mainmenu.href.add.priority"/>
			</a>
			<a href="<c:url value="/Admin/Types/Add"/>"
				title='<s:message code="mainmenu.href.add.type.title"/>'>
					<s:message code="mainmenu.href.add.type"/>
			</a>
		</div>
		<div class="float-right action-block">
			<a href="<c:url value="/Admin/Users/Add"/>" 
				title='<s:message code="mainmenu.href.add.user.title"/>'>
					<s:message code="mainmenu.href.add.user"/>
			</a>
			<a href="<c:url value="/Admin/Users/Search"/>"
				title='<s:message code="mainmenu.href.search.user.title"/>'>
					<s:message code="mainmenu.href.search.user"/>
			</a>
		</div>
	</sec:authorize>
</div>
</sec:authorize>
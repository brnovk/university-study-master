<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="by.gsu.bugtracker.constants.Constants"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<script>
	window.onload = function() {
		var value = "; " + document.cookie;
		  var parts = value.split("; " + 'bugtrackerPreferredLanguage' + "=");
		  if (parts == "; ") {
			  document.getElementById('language').innerHTML += 
				  '<a href="?lang=ru">RU</a><a href="?lang=by">BY</a><a href="?lang=en">EN</a>';
		  } else if (parts.length == 2) {
			  var loc = parts.pop().split(";").shift();
			  var menu = '';
			  menu += (loc === 'ru') ? '<a href="?lang=ru" class="active">RU</a>' : '<a href="?lang=ru">RU</a>';
			  menu += (loc === 'by') ? '<a href="?lang=by" class="active">BY</a>' : '<a href="?lang=by">BY</a>';
			  menu += (loc === 'en') ? '<a href="?lang=en" class="active">EN</a>' : '<a href="?lang=en">EN</a>';
			  document.getElementById('language').innerHTML += menu;
		  }
	};
</script>
<div class=header-page>
<div class="clearfix">
	<div class="header-block float-left language-change-block" id="language"></div>
	<div class="header-block float-left site-logo">
		<a href="<c:url value="<%=Constants.ISSUES_URL%>"/>" title="<s:message code="header.sitenametitle"/>">
			<s:message code="header.sitename"/>
		</a>
	</div>
	<div class="header-block float-right welcom-message">
		<span>
			<s:message code="header.welcome"/>:
			<strong>
				<sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal.username"/>
				</sec:authorize>
				<sec:authorize access="isAnonymous()">
					<s:message code="header.guest"/>
				</sec:authorize>
			</strong>
		</span>
	</div>
</div>
</div>
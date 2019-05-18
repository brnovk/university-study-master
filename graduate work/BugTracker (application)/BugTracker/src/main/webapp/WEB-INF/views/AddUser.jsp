<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="by.gsu.bugtracker.constants.JSPConstants"%>
<%@page import="by.gsu.bugtracker.constants.Constants"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
	<title><s:message code="page.title.add.user"/></title>
	<!--[if IE]>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<![endif]-->
	<!--[if lt IE 9]>
		<script src="<c:url value="/resources/js/oldIEFix.js"/>"></script>
	<![endif]-->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="<c:url value="/resources/css/project-style.css"/>" rel="stylesheet" type="text/css"/>
	<link rel="shortcut icon" href="data:image/png;base64,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"/>	
	<script>var validationEmptyMessage='<s:message code="validation.message.empty"/>';</script>
	<script src="<c:url value="/resources/js/project-scripts.js"/>"></script>
	<script type='text/javascript'>
		$(document).ready(function(){
			$(".userformbutton").click(function(){
				if ($("#pass").get(0).value != $("#passConfirm").get(0).value) {
			        alert('<s:message code="validation.password.dontmatch"/>');
			        return false;
			    } 
			});
		});
	</script>
</head>
<body>
<noscript><div align="center" style="color: red;"><s:message code="noscript.message"/></div></noscript>
<div id="page-wrapper">
	<c:import url="<%=JSPConstants.HEADER_JSP%>"/>
	<div class="content">
		<div id="head">
			<c:import url="<%=JSPConstants.LOGIN_MENU_JSP%>"/>
		</div>
		<div id="body">
			<sf:form name="addUser" method="post" modelAttribute="user" 
				onsubmit="return fiveFieldsValidation('addUser', 'emailAddress', 'emailError', 'firstName', 
					'firstNameError', 'lastName', 'lastNameError', 'password', 'passwordError', 'passConfirm', 'passConfirmError');">
				<table class="table-edit-user">
					<tr>
						<td class="label-td percent25"><s:message code="profile.email"/>:</td>
						<td class="percent33">
							<s:message code="profile.email.placeholder" var="emailPlaceholder"/>
							<sf:input path="emailAddress" placeholder="${emailPlaceholder}"/>
						</td>
						<td class="err-td" id="emailError">
							<sf:errors path="emailAddress" cssClass="error"/>
						</td>
					</tr>
					<tr>
						<td class="label-td percent25"><s:message code="profile.firstName"/>:</td>
						<td class="percent33">
							<s:message code="profile.firstName.placeholder" var="firstNamePlaceholder"/>
							<sf:input path="firstName" placeholder="${firstNamePlaceholder}"/>
						</td>
						<td class="err-td" id="firstNameError">
							<sf:errors path="firstName" cssClass="error"/>
						</td>
					</tr>
					<tr>
						<td class="label-td percent25"><s:message code="profile.lastName"/>:</td>
						<td class="percent33">
							<s:message code="profile.lastName.placeholder" var="lastNamePlaceholder"/>
							<sf:input path="lastName" placeholder="${lastNamePlaceholder}"/>
						</td>
						<td class="err-td" id="lastNameError">
							<sf:errors path="lastName" cssClass="error"/>
						</td>
					</tr>
					<tr>
						<td class="label-td percent25"><s:message code="profile.password"/>:</td>
						<td class="percent33">
							<s:message code="profile.password.placeholder" var="passwordPlaceholder"/>
							<sf:password path="password" id="pass" placeholder="${passwordPlaceholder}"/>
						</td>
						<td class="err-td" id="passwordError">
							<sf:errors path="password" cssClass="error"/>
						</td>
					</tr>
					<tr>
						<td class="label-td percent25"><s:message code="profile.password.confirm"/>:</td>
						<td class="percent33">
							<input type="password" id="passConfirm"
								placeholder='<s:message code="profile.password.confirm.placeholder"/>'>
						</td>
						<td class="err-td" id="passConfirmError">
							<sf:errors path="password" cssClass="error"/>
						</td>
					</tr>
					<tr>
						<td class="label-td percent25"><s:message code="profile.role"/>:</td>
						<td class="percent33">
							<sf:select path="userRole" items="${roles}"/>
						</td>
					</tr>
				</table>
				<table class="table-edit-button-wrapper">
					<tr>
						<td class="percent25">
						<input type="submit" value='<s:message code="profile.add.other.submit"/>'  
							title='<s:message code="profile.add.other.submit.title"/>' 
							class="userformbutton issueformbutton">
						</td>
						<td></td>
						<td></td>
					</tr>
				</table>
			</sf:form>
		</div>
		<div id="substrate-footer"></div>
	</div>
</div>
<div id="footer">
	<c:import url="<%=JSPConstants.FOOTER_JSP %>"/>
</div>
</body>
</html>
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
	<title><s:message code="page.title.edit.project"/></title>
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
	<script type="text/javascript">
		$( document ).ready(function() {
			/* Elastic height tetxarea */
			var t = document.getElementsByTagName('textarea')[0];
		    var offset= !window.opera ? (t.offsetHeight - t.clientHeight) : (t.offsetHeight + parseInt(window.getComputedStyle(t, null).getPropertyValue('border-top-width'))) ;
		    var resize  = function(t) {
		        t.style.height = 'auto';
		        t.style.height = (t.scrollHeight  + offset ) + 'px';    
		    }
		    t.addEventListener && t.addEventListener('input', function(event) {
		        resize(t);
		    });
		    t['attachEvent']  && t.attachEvent('onkeyup', function() {
		        resize(t);
		    });
		    $(window).load(function(){
		    	resize(t);
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
			<sf:form name="editProject" method="post" modelAttribute="project" 
					onsubmit="return twoFieldsValidation('editProject', 'name', 'nameError', 
						'description', 'descriptionError');">
				<table class="table-edit-project">
					<tr>
						<td class="label-td percent25"><s:message code="detail.project.name"/>:</td>
						<td class="percent50">
							<s:message code="detail.project.name.placeholder" var="namePlaceholder"/>
							<sf:input path="name" placeholder="${namePlaceholder}"/>
						</td>
						<td class="err-td" id="nameError">
							<sf:errors path="name" cssClass="error"/>
						</td>
					</tr>
					<tr>
						<td class="label-td percent25"><s:message code="detail.project.description"/>:</td>
						<td class="percent50">
							<s:message code="detail.project.description.placeholder" var="descriptionPlaceholder"/>
							<sf:textarea path="description" placeholder="${descriptionPlaceholder}"/>
						</td>
						<td class="err-td" id="descriptionError">
							<sf:errors path="description" cssClass="error"/>
						</td>
					</tr>
					<tr>
						<td class="label-td percent25"><s:message code="detail.project.build"/>:</td>
						<td class="percent50">
							<sf:select path="builds[0].id">
								<sf:options items="${buildList}" itemValue="id" itemLabel="name"/>
							</sf:select>
						</td>
						<td class="err-td">
						</td>
					</tr>
					<tr>
						<td class="label-td percent25"><s:message code="detail.project.manager"/>:</td>
						<td class="percent50">
							<sf:select path="manager.id">
								<sf:options items="${userList}" itemValue="id" itemLabel="emailAddress"/>
							</sf:select>
						</td>
						<td class="err-td">
						</td>
					</tr>
				</table>
				<table class="table-edit-button-wrapper">
					<tr>
						<td class="percent25">
						<input type="submit" value="<s:message code="edit.project.submit"/>" 
							title='<s:message code="edit.project.submit.title"/>' class="issueformbutton">
						</td><td></td><td></td>
					</tr>
				</table>
			</sf:form>
			<div id="addBuild">
				<c:url var="addBuildUrl" value='/Admin/Projects/${project.id}/AddBuild'/>
				<sf:form name="addBuild" method="post" modelAttribute="build" action="${addBuildUrl}"
					onsubmit="return singleFieldsValidation('addBuild','name','buildNameError');">
					<table class="table-add-build">
						<tr>
							<td class="label-td percent25">
								<input type="submit" value="<s:message code="build.add.submit"/>" class="issueformbutton"
									title='<s:message code="build.add.submit.title"/>'>
							</td>
							<td class="percent50">
								<s:message code="build.add.placeholder" var="buildPlaceholder"/>
								<sf:input path="name" placeholder="${buildPlaceholder}"/>
							</td>
							<td class="err-td" id="buildNameError">
								<sf:errors path="name" cssClass="error"/>
							</td>
						</tr>
					</table>
				</sf:form>
			</div>
		</div>
		<div id="substrate-footer"></div>
	</div>
</div>
<div id="footer">
	<c:import url="<%=JSPConstants.FOOTER_JSP %>"/>
</div>
</body>
</html>
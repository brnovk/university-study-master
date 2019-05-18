<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="by.gsu.bugtracker.constants.JSPConstants"%>
<%@page import="by.gsu.bugtracker.constants.Constants"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<title><s:message code="page.title.edit.issue"/></title>
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
			var projects = document.getElementById('projectSelect');
			var rootUrl = '<c:url value = '/Issues/Builds/'/>';
			var index = rootUrl.lastIndexOf(';');
			if (index !== -1) {
				var prefix = rootUrl.slice(0, index);
				var suffix = rootUrl.slice(index);
			} else {
				prefix = rootUrl;
				suffix = '';
			}
			$(projects).bind('change', function (event) {
				createBuilds(event.target.value, prefix, suffix);
			});
			$('#statusSelect').bind('change', function (event) {
				changeStatus(event.target.value);
			});
			var status = $('#statusSelect').get(0).value;
			$('#summary').get(0).disabled = (status === '5');
			changeStatus(status);
			
			/* Elastic height tetxareas */
			
			var t1 = document.getElementById('description');
		    var offset1 = !window.opera ? (t1.offsetHeight - t1.clientHeight) : (t1.offsetHeight + parseInt(window.getComputedStyle(t1, null).getPropertyValue('border-top-width'))) ;
		    var resize1  = function(t1) {
		    	t1.style.height = 'auto';
		    	t1.style.height = (t1.scrollHeight  + offset1) + 'px';
		    }
		    t1.addEventListener && t1.addEventListener('input', function(event) {
		        resize1(t1);
		    });
		    t1['attachEvent']  && t1.attachEvent('onkeyup', function() {
		        resize1(t1);
		    });
		    $(window).load(function(){
		    	resize1(t1);
		    });
		    
		 	// for IE document.getElementsByClassName("commentTextAreaClassName");
		    var t2 = document.querySelectorAll('.commentTextAreaClassName')[0];
		    var offset2 = !window.opera ? (t2.offsetHeight - t2.clientHeight) : (t2.offsetHeight + parseInt(window.getComputedStyle(t2, null).getPropertyValue('border-top-width'))) ;
		    var resize2  = function(t2) {
		    	t2.style.height = 'auto';
		    	t2.style.height = (t2.scrollHeight  + offset2) + 'px';
		    }
		    t2.addEventListener && t2.addEventListener('input', function(event) {
		        resize2(t2);
		    });
		    t2['attachEvent']  && t2.attachEvent('onkeyup', function() {
		        resize2(t2);
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
			<sf:form name="editIssue" method="post" modelAttribute="issue" 
				onsubmit="return fourFieldsValidation('editIssue','summary','summaryError', 
					'description','descriptionError', 'project.id', 'projectError', 'buildFound.id', 'buildError');">
				<table class="table-edit-issue">
					<tr>
						<td class="label-td percent25"><s:message code="detail.issue.id"/>:</td>
						<td class="percent50"><span class="not-editable-text">${issue.id}</span></td>
						<td></td>
					</tr>
					<tr>
						<td class="label-td percent25"><s:message code="detail.issue.createdDate"/>:</td>
						<td class="percent50">${issue.createDate}</td>
						<td></td>
					</tr>
					<tr>
						<td class="label-td percent25"><s:message code="detail.issue.createdBy"/>:</td>
						<td class="percent50">${issue.createdBy.emailAddress}</td>
						<td></td>
					</tr>
					<tr>
						<td class="label-td percent25"><s:message code="detail.issue.modifiedDate"/>:</td>
						<td class="percent50">${issue.modifyDate}</td>
						<td></td>
					</tr>
					<tr>
						<td class="label-td percent25"><s:message code="detail.issue.modifiedBy"/>:</td>
						<td class="percent50">${issue.modifiedBy.emailAddress}</td>
						<td></td>
					</tr>
					<tr>
						<td class="label-td percent25"><s:message code="detail.issue.summary"/>:</td>
						<td class="percent50">
							<s:message code="detail.issue.summary.placeholder" var="summaryPlaceholder"/>
							<sf:input path="summary" id="summary" placeholder="${summaryPlaceholder}"/>
						</td>
						<td class="err-td" id="summaryError"></td>
					</tr>
					<tr>
						<td class="label-td percent25"><s:message code="detail.issue.description"/>:</td>
						<td class="percent50">
							<s:message code="detail.issue.description.placeholder" var="descriptionPlaceholder"/>
							<sf:textarea path="description" id="description" placeholder="${descriptionPlaceholder}"/>
						</td>
						<td class="err-td" id="descriptionError"></td>
					</tr>
					<tr>
						<td class="label-td percent25"><s:message code="detail.issue.status"/>:</td>
						<td class="percent50">
							<sf:select path="status.id" id="statusSelect">
								<sf:options items="${statusList}" itemValue="id" itemLabel="name"/>
							</sf:select>
						</td>
						<td class="err-td"></td>
					</tr>
					<tr>
						<td class="label-td percent25"><s:message code="detail.issue.resolution"/>:</td>
						<td class="percent50">
							<sf:select path="resolution.id" id="resolutionSelect">
								<sf:options items="${resolutionList}" itemValue="id" itemLabel="name"/>
							</sf:select>
						</td>
						<td class="err-td"></td>
					</tr>
					<tr>
						<td class="label-td percent25"><s:message code="detail.issue.type"/>:</td>
						<td class="percent50">
							<sf:select path="type.id" id="typeSelect">
								<sf:options items="${typeList}" itemValue="id" itemLabel="name"/>
							</sf:select>
						</td>
						<td class="err-td"></td>
					</tr>
					<tr>
						<td class="label-td percent25"><s:message code="detail.issue.priority"/>:</td>
						<td class="percent50">
							<sf:select path="priority.id" id="prioritySelect">
								<sf:options items="${priorityList}" itemValue="id" itemLabel="name"/>
							</sf:select>
						</td>
						<td class="err-td"></td>
					</tr>
					<tr>
						<td class="label-td percent25"><s:message code="detail.issue.project"/>:</td>
						<td class="percent50">
							<sf:select path="project.id" id="projectSelect">
								<sf:options items="${projectList}" itemValue="id" itemLabel="name"/>
							</sf:select>
						</td>
						<td class="err-td" id="projectError"></td>
					</tr>
					<tr>
						<td class="label-td percent25"><s:message code="detail.issue.projectBuild"/>:</td>
						<td class="percent50">
							<sf:select path="buildFound.id" > <!-- id="buildSelect" -->
								<sf:options items="${issue.project.builds}" itemValue="id" itemLabel="name"/>
							</sf:select>
						</td>
						<td class="err-td" id="buildError"></td>
					</tr>
					<tr>
						<td class="label-td percent25"><s:message code="detail.issue.assignee"/>:</td>
						<td class="percent50">
							<sf:select path="assignee.id"  id="assigneeSelect" >
								<sf:options items="${userList}" itemValue="id" itemLabel="emailAddress"/>
							</sf:select>
						</td>
						<td class="err-td"></td>
					</tr>
				</table>
				<table class="table-edit-button-wrapper">
					<tr>
						<td class="percent25">
							<input type="submit" value='<s:message code="edit.issue.submit"/>' 
								title='<s:message code="edit.issue.submit.title"/>' class="issueformbutton">
						</td>
						<td></td>
						<td></td>
					</tr>
				</table>
			</sf:form>
			<c:url var="addCommentUrl" value='/Issues/${issue.id}/AddComment'/>
			<s:message code="validation.comment.empty" var="errorComment"/>
			<sf:form name="addComment" method="post" modelAttribute="comment" action="${addCommentUrl}"
				onsubmit="return singleFieldsValidationWithCustomError('addComment','comment','commentError', '${errorComment}');">
			<table class="table-add-comment">
				<tr>
					<td class="label-td percent25">
						<s:message code="table.addcomment.label"/>:
					</td>
					<td rowspan="2" class="percent50">
						<s:message code="table.addcomment.placepolder" var="commentPlaceholder"/>
						<sf:textarea path="comment" cssClass="commentInput commentTextAreaClassName" placeholder="${commentPlaceholder}"/>
					</td>
					<td rowspan="2" class="err-td" id="commentError"></td>
				</tr>
				<tr>
					<td>
						<input type="submit" value="<s:message code="table.addcomment.buttonsumbit"/>" 
							title='<s:message code="table.addcomment.buttonsumbit.title"/>' class="issueformbutton">
					</td>
				</tr>
			</table>
			</sf:form>
			<c:url var="addFileUrl" value='/Issues/${issue.id}/AddFile'/>
			<s:message code="validation.file.empty" var="errorFile"/>
			<sf:form name="addFile" method="post" action="${addFileUrl}" enctype="multipart/form-data"
				onsubmit="return singleFieldsValidationWithCustomError('addFile','file','fileError', '${errorFile}');">
				<table class="table-add-file">
					<tr>
						<td class="label-td percent25">
							<input type="submit" value="<s:message code="table.addfile.buttonsumbit"/>" 
								title='<s:message code="table.addfile.buttonsumbit.title"/>' class="issueformbutton">
						</td>
						<td class="percent50">
							<input name="file" type="file" title='<s:message code="table.addfile.buttonfilechoise.title"/>'/>
						</td>
						<td class="err-td" id="fileError"></td>
					</tr>
				</table>
			</sf:form>
			<c:if test="${not empty issue.comments}">
				<table class="commentTable">
					<thead>
						<tr>
							<th class="percent25"><s:message code="table.comment.commentator"/></th>
							<th class="percent15"><s:message code="table.comment.date"/></th>
							<th><s:message code="table.comment.comment"/></th>
						</tr>
					</thead>
					<c:forEach var="comment" items="${issue.comments}">
						<tr>
							<td>${comment.addedBy.emailAddress}</td>
							<td>${comment.addDate}</td>
							<% pageContext.setAttribute("newLineChar", "\n"); %>
							<td>${fn:replace(comment.comment, newLineChar, '<br>')}</td>
						</tr>
					</c:forEach>
				</table>
			</c:if>
			<c:if test="${not empty issue.attachments}">
				<table class="fileTable">
					<thead>
						<tr>
							<th class="percent25"><s:message code="table.file.userUploaded"/></th>
							<th class="percent15"><s:message code="table.file.date"/></th>
							<th><s:message code="table.file.file"/></th>
						</tr>
					</thead>
					<c:forEach var="attachment" items="${issue.attachments}">
						<tr>
							<td>${attachment.addedBy.emailAddress}</td>
							<td>${attachment.addDate}</td>
							<td>
								<a href="<c:url value='${issue.id}/${attachment.id}'/>">${attachment.fileName}
								</a>
							</td>
						</tr>
					</c:forEach>
				</table>
			</c:if>
		</div>
		<div id="substrate-footer"></div>
	</div>
</div>
<div id="footer">
	<c:import url="<%=JSPConstants.FOOTER_JSP %>"/>
</div>
</body>
</html>
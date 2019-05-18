<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="by.gsu.bugtracker.constants.JSPConstants"%>
<%@page import="by.gsu.bugtracker.constants.Constants"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
	<title><s:message code="page.title.search.issue"/></title>
	<!--[if IE]>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<![endif]-->
	<!--[if lt IE 9]>
		<script src="<c:url value="/resources/js/oldIEFix.js"/>"></script>
		<style>
			.maxwidth200,
			.maxwidth140 {
				white-space: normal !important;
				overflow: visible;
			}
		</style>
	<![endif]-->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="<c:url value="/resources/css/project-style.css"/>" rel="stylesheet" type="text/css"/>
	<link rel="shortcut icon" href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMAAAADACAIAAADdvvtQAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAbaSURBVHhe7ds9cttIGIRhn8sH2vP4DD6CAx/AR3DqyJkTVylwlQMHu0OJkj63SOLrwfwR+049SVetBQJsDAYA9927jz+AepoBi2bAohmwaAYsmgGLZsCiGbBoBiyaAYtmwKIZsGgGLJoBi2bAohmwaAYsmgGLZsCiGbBoBiyaAYtmwKIZsGgGLJoBi2bAohmwaAYsmgGLZsCiGbBoBiyaAYtmwKIZsGgGLJoBi2bAohmwaAYsmgGLZsCiGbBoBiyaAYtmwKIZsGgGLJoBi2bAohmwaAYsmgGLZsCiGbBoBiyaAYtmwKIZsGjGvXn/9c+/qfH7nzf/tgHN0adf387bHjPa7uHD5/OfXXI8/HqvHzjv54eH85+pHp+/yN+spTkaXaC/xu49PGCB0pNNfuw+aTVHUwv0NL59/amfKutYBfry+/wPu4wdNdIcLVCgx/Hnw6c3n23bYQo0ake+P7zZdILmaJUCnYY/FR2iQIO/gooLq+ZopQKVYXbo/gvU97J1bZiXM83RYgUqw+nQnRdo4sG35iHN0XoFctZDd12g2R8+vx7SHK1YoPz5cccF+uf7+b+aOLKPUTRHaxYoeyG72wKtcthziyHN0aoFyu3bvRaoavq5dWWvfvyYOlE1R9kC1T2neVZV02ZP4i/K3v7s2/GLzKPhHIeKFyCJE1VzNKZAZ+bu1T31SppXIGO2qDoC7my0XVDN0dACnRizd3YpXWVegbJHYMf543Voc0Oao+EFcuahHa9vNk0rUHLdtnPfncl+80TVHE0o0NT1x4tZnyF5wPdfvrM7WMbWPmqOphRoykbF4QvkTEIbyyDN0ZzvMrlvFGiX/EqIAvkWL1CT9V/6KrbxNEhztHSBjriIzh7wJo/BLi3YK+5tNUdzCpS7EznmbXz+6XnzTdfSHE0pUHKjLdYBV00rkHODbf9Aqg/N0YwCJRd3Lebw66YVqOZF2OQaaY7GFyi5xa7Xr2JegdKbfjs6fJgMzdHoAmVXAN3PuYkFMpZBV8fQOUlzNLJA+TOv9/RTzCyQ/b7z9uh7rS80R0MKZF71u3xnamqBmkxCl0afT6s5yhZo3Bg0OU8ukDMf142G97Cao8UKNO7SPr1Alb9LtEeDQ6o5WqlA3a/l0QIFcp8J7Rs7HutrjlYpUM+3FhctUaBiZIfKqDrOmqMFCjR04nmxSoGKwR3yl0eao1VmoAHf098WKtBJ2xv77WE9KNEcLbaIHjcbLVagR6tezjRHixXoNAY8RSxWLNCT9VbWmqMFC3Qa/b+2dQt0NuiiljldNUeLFqiMzt/c8gV60ftx0faDIs3RugUqo+e9/f0U6FWvL2trHzVH2c+08zjWvvrptx66xwJFbct0+8ZeczSoQK/cCbnXfdm9FyjK7suNcXOy1xwNL9CJd/b0uZAdqUCv6u/gbp2omqMpBSqcDnWZhI5ZoGcVc9KNq5jmaFaBrNvUHr+uP3aBHpmrheszveZoXoGclXWHq9j/oECF8zDp+p5qjmYWKH+KdNj6CgW6dPBbX6/zq6I7LFD+/Gi/DBpeoOzZ0vx6nV4PXT3ImqOpBcrvW/tfKg4vUPZsaf7oK/sVUyDL8AJN2OJZdq15fwXKX8KOUKD0TNB6Z49boPx95hEKNOuu87iXMOOx6dV9qzbjgjLlhElP89f3VHM0sUDZr7CMiVtvumljl1tNQi2mPc3RtALld6zPO/kpBRq+18bD6Bub0xzNKZD5zu9ArzKMb7SMfTvuPIa+edHUHI0vUHaLr6P9AqiYVCDnKvY0Kq9lXlNv76bmaGCBzF16Hp1+UzarQHW/uLCmIrujW39fc+TPB4NHl+mnmFagXcf81tGo/7Nb+6g5WrxAnaafYmKBqifjTmNzetMcrV2gXtNPMbVA3u1Y35FYY2mOVi5Qj5uvF5MLtMqRT52imqNlC9Tv4vVkeoGK7GfoNbLPuzVHaxaod3uKFQpUzOuQ8bZEc7RggQa0p1ikQMWMr8B716Y5WqxADV8iblinQCf1/zuOP/w90hytU6AxE8+LtQr0qP/lrPL81BwtUKBxs060YIGe9PlGdh1kzdGcAjX9wVSdZQv0zHoVenU0eRSiGXfHOM87NF4zYNEMWDQDFs2ARTNg0QxYNAMWzYBFM2DRDFg0AxbNgEUzYNEMWDQDFs2ARTNg0QxYNAMWzYBFM2DRDFg0AxbNgEUzYNEMWDQDFs2ARTNg0QxYNAMWzYBFM2DRDFg0AxbNgEUzYNEMWDQDFs2ARTNg0QxYNAMWzYBFM2DRDFg0AxbNgEUzYNEMWDQDFs2ARTNg0QxYNAMWzYBFM2DRDFg0AxbNgEUzYNEMWDQDeR9//AcemVzoqBL82gAAAABJRU5ErkJggg=="/>	
	<script src="<c:url value="/resources/js/project-scripts.js"/>"></script>
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
			<div class="table-wrapper">
				<sf:form name="addissue" method="post" modelAttribute="searchIssue">
					<table class="search-table">
						<tr>
							<td class="percent33"><s:message code="detail.issue.createdBy"/>:</td>
							<td>
								<sf:select path="createdByEmail" id="assigneeSelect">
									<option value="">
									<sf:options items="${userList}" itemValue="emailAddress" itemLabel="emailAddress"/>
								</sf:select>
							</td>
						</tr>
						<tr>
							<td class="percent33"><s:message code="detail.issue.modifiedBy"/>:</td>
							<td>
								<sf:select path="modifiedByEmail" id="assigneeSelect">
									<option value="">
									<sf:options items="${userList}" itemValue="emailAddress" itemLabel="emailAddress"/>
								</sf:select>
							</td>
						</tr>
						<tr>
							<td class="percent33"><s:message code="detail.issue.summary"/>:</td>
							<td>
								<s:message code="search.issue.summary.placeholder" var="summaryPlaceholder"/>
								<sf:input path="summary" placeholder="${summaryPlaceholder}"/> 
								<sf:errors path="summary" cssClass="error"/>
							</td>
						</tr>
						<tr>
							<td class="percent33"><s:message code="detail.issue.description"/>:</td>
							<td>
								<s:message code="search.issue.description.placeholder" var="descriptionPlaceholder"/>
								<sf:input path="description" placeholder="${descriptionPlaceholder}"/> 
								<sf:errors path="description" cssClass="error"/>
							</td>
						</tr>
						<tr>
							<td class="percent33"><s:message code="detail.issue.status"/>:</td>
							<td>
								<sf:select path="status" id="statusSelect">
									<option value="">
									<sf:options items="${statusList}" itemValue="name" itemLabel="name"/>
								</sf:select>
							</td>
						</tr>
						<tr>
							<td class="percent33"><s:message code="detail.issue.resolution"/>:</td>
							<td>
								<sf:select path="resolution" id="resolutionSelect">
									<option value="">
									<sf:options items="${resolutionList}" itemValue="name" itemLabel="name"/>
								</sf:select>
							</td>
						</tr>
						<tr>
							<td class="percent33"><s:message code="detail.issue.type"/>:</td>
							<td>
								<sf:select path="type">
									<option value="">
									<sf:options items="${typeList}" itemValue="name" itemLabel="name"/>
								</sf:select>
							</td>
						</tr>
						<tr>
							<td class="percent33"><s:message code="detail.issue.priority"/>:</td>
							<td>
								<sf:select path="priority">
									<option value="">
									<sf:options items="${priorityList}" itemValue="name" itemLabel="name"/>
								</sf:select>
							</td>
						</tr>
						<tr>
							<td class="percent33"><s:message code="detail.issue.project"/>:</td>
							<td>
								<sf:select path="projectName" id="projectSelect">
									<option value="">
									<sf:options items="${projectList}" itemValue="name" itemLabel="name"/>
								</sf:select>
							</td>
						</tr>
						<tr>
							<td class="percent33"><s:message code="detail.issue.assignee"/>:</td>
							<td>
								<sf:select path="assigneeEmail" id="assigneeSelect">
									<option value="">
									<sf:options items="${userList}" itemValue="emailAddress" itemLabel="emailAddress"/>
								</sf:select>
							</td>
						</tr>
					</table>
					<table class="search-button-wrapper">
						<tr>
							<td class="percent33">
								<input type="submit" value='<s:message code="search.issue.submit"/>' 
									title='<s:message code="search.issue.submit.title"/>' class="issueformbutton">
							</td>
							<td></td>
						</tr>
					</table>
				</sf:form>
			</div>
			<c:choose>
				<c:when test="${empty issueList}">
					<div class="not-found-block">
						<s:message code="search.issue.notfound.message"/>
					</div>
				</c:when>
				<c:otherwise>
					<div class="table-wrapper">
						<table id="myTable" class="tablesorter">
							<thead>
								<tr>
									<th class="firstColumn"><s:message code="table.issue.id"/></th>
									<th class="overf maxwidth140"><s:message code="table.issue.priority"/></th>
									<th class="overf maxwidth140"><s:message code="table.issue.assignee"/></th>
									<th class="overf maxwidth140"><s:message code="table.issue.type"/></th>
									<th class="overf maxwidth140"><s:message code="table.issue.status"/></th>
									<th class="overf maxwidth200"><s:message code="table.issue.summary"/></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${issueList}" var="issue">
									<tr>
										<td>
											<sec:authorize access="isAnonymous()">
												<a href="<c:url value="/ViewIssue/${issue.id}"></c:url>">
													<c:out value="${issue.id}"/>
												</a>
											</sec:authorize>
											<sec:authorize access="isAuthenticated()">
												<a href="<c:url value="/Issues/${issue.id}"></c:url>">
													<c:out value="${issue.id}"/>
												</a>
											</sec:authorize>
										</td>
										<td class="pr${issue.priority.id} overf maxwidth140">
											<c:out value="${issue.priority.name}"/>
										</td>
										<td class="overf maxwidth140">
											<c:out value="${issue.assignee.emailAddress}"/>
										</td>
										<td class="overf maxwidth140"><c:out value="${issue.type.name}"/></td>
										<td class="overf maxwidth140"><c:out value="${issue.status.name}"/></td>
										<td class="overf maxwidth200"><c:out value="${issue.summary}"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div id="pagesrefs">
						<c:if test="${pages gt 1}">
							<c:forEach begin="0" end="${pages-1}" var="val">
								<a href="#"><c:out value="${val}"/></a>
							</c:forEach>
						</c:if>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		<div id="substrate-footer"></div>
	</div>
</div>
<div id="footer">
	<c:import url="<%=JSPConstants.FOOTER_JSP%>"/>
</div>
</body>
</html>
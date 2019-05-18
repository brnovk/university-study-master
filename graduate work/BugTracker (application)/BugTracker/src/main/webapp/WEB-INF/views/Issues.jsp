<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="by.gsu.bugtracker.constants.JSPConstants"%>
<%@page import="by.gsu.bugtracker.constants.Constants"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<title><s:message code="page.title.list.issues"/></title>
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
	<sec:authorize access="isAuthenticated()" var="sq">
		<script type="text/javascript"><c:out value = 'var isLogged = true;'/></script>
	</sec:authorize>
	<sec:authorize access="isAnonymous()" var="sw">
		<script type="text/javascript"><c:out value = 'var isLogged = false;'/></script>
	</sec:authorize>
	<script src="<c:url value="/resources/js/project-scripts.js"/>"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			var rootUrl = (isLogged) ? '<c:url value = "/Issues/"/>' : '<c:url value = "/ViewIssue/"/>';
			var index = rootUrl.lastIndexOf(';');
			var prefix = rootUrl.slice(0, index);
			var suffix = rootUrl.slice(index);
			var sortConfig = {
				orderby: 0,
				order: 1,
				page: 0
			};
			var table = document.getElementById('myTable');
			var getIssues = function() {
				$.getJSON("<c:url value='/IssuesPaginator'/>",sortConfig , function( data ) {
					var tableBody = table.getElementsByTagName('tbody');
					$(tableBody).empty();
					for (var i = 0; i < data.length; i++) {
						var tr = document.createElement('TR');
						for (var j = 0; j < data[i].length; j++) {
							var td = document.createElement('TD');
							tr.appendChild(td);
						}
						if ('console' in self && 'log' in console) {	// for IE console.log
							console.log(tr);
						}
						tableBody[0].appendChild(tr);
					}
					var rows = table.rows;
					var i = 1;
					$.each( data, function( key, val ) {
						var cells = rows[i++].children;
						var j = 0;
						$.each(val, function(key, prop) {
							if (j === 0) {
								var a = document.createElement('a');
								a.setAttribute("href", prefix + "/" + prop + suffix);
								a.innerHTML = prop;
								cells[j].appendChild(a);
							} else {
								if (j === 1 || j === 2 || j === 3 || j === 4) {
									cells[j].className = 'header column overf maxwidth140';
								}
								if (j === 5) {
									cells[j].className = 'header column overf maxwidth200';
								}
								cells[j].innerHTML = prop;
							};
							j++;
						});
					});
				});
			};
			var tmp = document.getElementById('pagesrefs');
			if (tmp !== null) {		// for IE chech NULL
				var pagesrefs = tmp.getElementsByTagName('a');
				for(var i=0,l=pagesrefs.length;i<l;i++){
					$(pagesrefs[i]).click(function(e) {
						var target = e && e.target || window.event.srcElement;
						sortConfig.page = target.innerHTML;
						var newActiveId = 'pag'+$.trim(target.innerHTML);
						// for IE document.getElementsByClassName("pag");
						var pags = document.querySelectorAll('.pag');
						for (var i = 0; i < pags.length; i++) {
						    var currentId = pags[i].id;
						    if (currentId == newActiveId) { // set active
						    	document.getElementById(currentId).className = "pag active";
						    } else {
						    	document.getElementById(currentId).className = "pag";
						    }
						}
						e.preventDefault() || (e.returnValue = false);
						getIssues();
					});
				}
			}
			$("#myTable").click(function(e){
				var target = e && e.target || window.event.srcElement;

				if (target.tagName != 'TH') return;
				var ths = table.getElementsByTagName('th');
				if (sortConfig.order === 0) {
					$(ths[sortConfig.orderby]).removeClass('headerSortUp');
				} else {
					$(ths[sortConfig.orderby]).removeClass('headerSortDown');
				}
				if (target.cellIndex === sortConfig.orderby) {
					if (sortConfig.order === 0) {
						sortConfig.order = 1;
					} else {
						sortConfig.order = 0;
					}
				}
				sortConfig.orderby = target.cellIndex;
				if (sortConfig.order === 0) {
					$(ths[sortConfig.orderby]).addClass('headerSortUp');
				} else {
					$(ths[sortConfig.orderby]).addClass('headerSortDown');
				}
				getIssues();
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
			<c:choose>
				<c:when test="${empty issueList}">
					<div class="not-found-block">
						<s:message code="issues.issue.notfound.message"/>
					</div>
				</c:when>
				<c:otherwise>
					<div class="table-wrapper">
						<table id="myTable" class="tablesorter">
							<thead>
								<tr>
									<th class="header firstColumn">
										<s:message code="table.issue.id"/>
									</th>
									<th class="header column overf maxwidth140">
										<s:message code="table.issue.priority"/>
									</th>
									<th class="header column overf maxwidth140">
										<s:message code="table.issue.assignee"/>
									</th>
									<th class="header column overf maxwidth140">
										<s:message code="table.issue.type"/>
									</th>
									<th class="header column overf maxwidth140">
										<s:message code="table.issue.status"/>
									</th>
									<th class="header column overf maxwidth200">
										<s:message code="table.issue.summary"/>
									</th>
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
										<td class="overf maxwidth140"><c:out value="${issue.priority.name}"/></td>
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
					<div class="paginator-wrapper">
						<div id="pagesrefs">
							<c:if test="${pages gt 1}">
								<c:forEach begin="0" end="${pages-1}" var="val">
									<c:choose>
										<c:when test="${val eq 0}">
											<a href="#" class="active pag" id="pag<c:out value="${val}"/>" >
												<c:out value="${val}"/>
											</a>
										</c:when>
										<c:otherwise>
											<a href="#" class="pag" id="pag<c:out value="${val}"/>">
												<c:out value="${val}"/>
											</a>
										</c:otherwise>
									</c:choose>	
								</c:forEach>
							</c:if>
						</div>
		 			</div>
				</c:otherwise>
			</c:choose>
		</div>
		<div id="substrate-footer">
		</div>
	</div>
</div>
<div id="footer">
	<c:import url="<%=JSPConstants.FOOTER_JSP %>"/>
</div>
</body>
</html>
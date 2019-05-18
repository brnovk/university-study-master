<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Subtask 1</title>
	<link rel="stylesheet" href="css/app-style.css">
</head>
<body>
	<h1>
		Finding information on all planets,<br>on which life is present,
		and their satellites in a given galaxy.
	</h1>
	<a href="<c:url value="/index.jsp"/>" title="To main page">To main</a><br>
	<a href="<c:url value='<%="/ViewDataController"%>'/>" 
		title="Show all database data">Show all database data</a><br>
	<a href="<c:url value="subtask1-preview.jsp"/>" 
		title="Subtask 1 (choice galaxy)">Subtask 1 (choice galaxy)</a><br>
	<a href="<c:url value='<%="/Subtask3Controller"%>'/>" title="Subtask 3">Subtask 3</a><br>
	<a href="<c:url value='<%="/Subtask4Controller"%>'/>" title="Subtask 4">Subtask 4</a><br><hr>
    
	<c:choose>
		<c:when test="${subtask1ResultList eq null or empty subtask1ResultList}">
			In this galaxy of planets with life there.
		</c:when>
		<c:otherwise>
			<table>
				<caption>
					Planets, on which there is life, and satellites of planets in this galaxy.
				</caption>
				<thead>
					<tr>
						<th>Planet</th>
						<th>Planet radius</th>
						<th>Core temperature</th>
						<th>Existence atmosphere</th>
						<th>Satellite</th>
						<th>Satellite radius</th>
						<th>Distance to planet</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="resultLine" items="${subtask1ResultList}">
						<tr>
						<c:forEach var="item" items="${resultLine}">
							<td><c:out value="${item}"/></td>
						</c:forEach>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:otherwise>
	</c:choose>

</body>
</html>

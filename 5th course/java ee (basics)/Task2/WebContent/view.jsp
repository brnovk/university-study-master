<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>All database data</title>
	<link rel="stylesheet" href="css/app-style.css">
</head>
<body>
	<h1>Show all database data</h1><hr>
	<a href="<c:url value="/index.jsp"/>" title="To main page">To main</a><br>
	<a href="<c:url value="subtask1-preview.jsp"/>" title="Subtask 1">Subtask 1</a><br>
	<a href="<c:url value='<%="/Subtask3Controller"%>'/>" title="Subtask 3">Subtask 3</a><br>
	<a href="<c:url value='<%="/Subtask4Controller"%>'/>"
		title="Subtask 4">Subtask 4</a><br><hr>

	<c:choose>
		<c:when test="${galaxiesList eq null or empty galaxiesList}">
			List of galaxies is empty.
		</c:when>
		<c:otherwise>
			<table>
				<caption>Table of galaxies</caption>
				<thead>
					<tr>
						<th>id</th>
						<th>Galaxy</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="currentGalaxy" items="${galaxiesList}">
					<tr>
						<c:forEach var="item" items="${currentGalaxy}">
							<td>
				    			<c:out value="${item}" />
						    </td>
					     </c:forEach>
				     </tr>
				</c:forEach>
				</tbody>
			</table>
		</c:otherwise>
	</c:choose>

	<c:choose>
		<c:when test="${planetsList eq null or empty planetsList}">
			List of planets is empty.
		</c:when>
		<c:otherwise>
			<table>
				<caption>Table of planets</caption>
				<thead>
					<tr>
						<th>id</th>
						<th>Planet</th>
						<th>Radius</th>
						<th>Core temperature</th>
						<th>Existence atmosphere</th>
						<th>Existence life</th>
						<th>Galaxy</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="currentPlanet" items="${planetsList}">
					<tr>
						<c:forEach var="item" items="${currentPlanet}">
							<td>
				    			<c:out value="${item}" />
						    </td>
					     </c:forEach>
				     </tr>
				</c:forEach>
				</tbody>
			</table>
		</c:otherwise>
	</c:choose>

	<c:choose>
		<c:when test="${satellitesList eq null or empty satellitesList}">
			Satellite list is empty.
		</c:when>
		<c:otherwise>
			<table>
				<caption>Table satellites</caption>
				<thead>
					<tr>
						<th>id</th>
						<th>Satellite</th>
						<th>Radius</th>
						<th>Distance to planet</th>
						<th>Planet</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="currentSatellite" items="${satellitesList}">
					<tr>
						<c:forEach var="item" items="${currentSatellite}">
							<td>
				    			<c:out value="${item}" />
						    </td>
					     </c:forEach>
				     </tr>
				</c:forEach>
				</tbody>
			</table>
		</c:otherwise>
	</c:choose>

</body>
</html>

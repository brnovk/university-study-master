<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Subtask 3</title>
	<link rel="stylesheet" href="css/app-style.css">
</head>
<body>
	<h1>
		Finding information about the planet, Galaxy, in which it is located,<br>
		and its satellites, which is the maximum number of satellites,<br>
		but with the lowest overall volume of these satellites.
	</h1><hr>
	<a href="<c:url value="/index.jsp"/>" title="To main page">To main</a><br>
	<a href="<c:url value='<%="/ViewDataController"%>'/>" 
		title="Show all database data">Show all database data</a><br>
	<a href="<c:url value="subtask1-preview.jsp"/>" title="Subtask 1">Subtask 1</a><br>
	<a href="<c:url value='<%="/Subtask4Controller"%>'/>" 
		title="Subtask 4">Subtask 4</a><br><hr>

	<c:choose>
		<c:when test="${subtask3List eq null or empty subtask3List}">
			Result of the query is missing.
		</c:when>
		<c:otherwise>

			<div class="descpiption">Planet:</div>
			<div class="value"><c:out value="${subtask3List[0]}"/></div><br>
		
			<div class="descpiption">Radius:</div>
			<div class="value"><c:out value="${subtask3List[1]}"/></div><br>

			<div class="descpiption">Core temperature:</div>
			<div class="value"><c:out value="${subtask3List[2]}"/></div><br>

			<div class="descpiption">Existence of an atmosphere:</div>
			<div class="value"><c:out value="${subtask3List[3]}"/></div><br>

			<div class="descpiption">Existence of life:</div>
			<div class="value"><c:out value="${subtask3List[4]}"/></div><br>

			<div class="descpiption">Galaxy:</div>
			<div class="value"><c:out value="${subtask3List[5]}"/></div><br>

			<div class="descpiption">Number of satellites:</div>
			<div class="value"><c:out value="${subtask3List[6]}"/></div><br>

			<div class="descpiption">Total radius of satellites:</div>
			<div class="value"><c:out value="${subtask3List[7]}"/></div>
		</c:otherwise>
	</c:choose>

</body>
</html>

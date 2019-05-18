<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Subtask 4</title>
	<link rel="stylesheet" href="css/app-style.css">
</head>
<body>
	<h1>
		Finding information about the galaxy,<br>
		the amount of nuclear temperatures of the planets the most.
	</h1><hr>
	<a href="<c:url value="/index.jsp"/>" title="To main page">To main</a><br>
	<a href="<c:url value='<%="/ViewDataController"%>'/>" 
		title="Show all database data">Show all database data</a><br>
	<a href="<c:url value="subtask1-preview.jsp"/>" title="Subtask 1">Subtask 1</a><br>
	<a href="<c:url value='<%="/Subtask3Controller"%>'/>"
		title="Subtask 3">Subtask 3</a><br><hr>

	<c:choose>
		<c:when test="${subtask4List eq null or empty subtask4List}">
			Result of query is missing.
		</c:when>
		<c:otherwise>

			<div class="descpiption">Galaxy:</div>
			<div class="value"><c:out value="${subtask4List[0]}"/></div><br>

			<div class="descpiption">Amount nuclear temperatures of planets:</div>
			<div class="value"><c:out value="${subtask4List[1]}"/></div>
		</c:otherwise>
	</c:choose>

</body>
</html>

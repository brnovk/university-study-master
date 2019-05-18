<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Index page</title>
	<link rel="stylesheet" href="css/app-style.css">
</head>
<body>
	<h1>Task 1</h1><hr>
    <c:if test="${not empty errorMessage}">
    	<div class="error">
	        <c:out value="${errorMessage}"/>
    	</div><hr>
    </c:if>
	<a href="<c:url value='<%="/Subtask1Controller"%>'/>" title="Subtask 1">
		Subtask 1 - Name of country and language
	</a><br>
	<a href="<c:url value="subtask2-preview.html"/>" title="Subtask 2">
		Subtask 2 - Display temperature in different colors
	</a><br>
	<a href="<c:url value='<%="/Subtask3Controller"%>'/>" title="Subtask 3">
		Subtask 3 - Show developer names and the date/time
	</a><br>
	<a href="<c:url value="subtask4-preview.html"/>" title="Subtask 4">
		Subtask 4 - Calculation of the trigonometric functions
	</a><br>
	<a href="<c:url value="subtask5-preview.html"/>" title="Subtask 5">
		Subtask 5 - Selecting and displaying images
	</a><br>
	<a href="<c:url value="subtask6-index.jsp"/>" title="Subtask 6">
		Subtask 6 - Phonebook
	</a>
</body>
</html>

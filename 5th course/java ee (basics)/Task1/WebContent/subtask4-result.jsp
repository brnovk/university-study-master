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
	<h1>Calculation of trigonometric functions in degrees and radians<br>
		with a specified precision.<br>Selection of functions must be via 
		drop-down list.</h1><hr>
	<a href="<c:url value="index.jsp"/>" title="To main page">To main</a><br>
	<a href="<c:url value="subtask4-preview.html"/>" 
		title="Back to previous">Back to previous</a><br>
	<div>
		<div class="descpiption">Source number:</div>
		<div class="value"><c:out value="${number}"/></div><br>
		
		<div class="descpiption">Function:</div>
		<div class="value"><c:out value="${function}"/></div><br>
	
		<div class="descpiption">Result in degrees:</div>
		<div class="value"><c:out value="${resultInDegrees}"/></div><br>
		
		<div class="descpiption">Result in radians:</div>
		<div class="value"><c:out value="${resultInRadians}"/></div>
	</div>
</body>
</html>

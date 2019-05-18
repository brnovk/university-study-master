<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Subtask 5</title>
	<link rel="stylesheet" href="css/app-style.css">
</head>
<body>
	<h1>Selection of image by themes (nature, cars, kids, etc.)<br>
		and display it.</h1><hr>
	<a href="<c:url value="index.jsp"/>" title="To main page">To main</a><br>
	<a href="<c:url value="subtask5-preview.html"/>" 
		title="Back to previous">Back to previous</a><br>
	
		<div>Image on theme: <c:out value="${theme.displayName}"/></div>
		<div class="<c:out value="${theme}"/>"></div>
</body>
</html>

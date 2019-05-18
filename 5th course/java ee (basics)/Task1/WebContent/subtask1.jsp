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
	<h1>Display full country name and language</h1><hr>
	<a href="<c:url value="index.jsp"/>" title="To main page">To main</a><br>
		
	<c:choose>
		<c:when test="${subtask1Locale eq null}">
			Result missing.
		</c:when>
		<c:otherwise>
			<div class="descpiption">Country:</div>
			<div class="value">
				<c:out value="${subtask1Locale.displayCountry}"/>
			</div><br>
			<div class="descpiption">Language:</div>
			<div class="value">
				<c:out value="${subtask1Locale.displayLanguage}"/>
			</div>
		</c:otherwise>
	</c:choose>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Subtask 2</title>
	<style type="text/css" media="screen">
		.blue {
			color: blue;
		}
		.red {
			color: red;
		}
	</style>
	<link rel="stylesheet" href="css/app-style.css">
</head>
<body>
	<h1>Set temperature.<br>If it is less zero, 
		print value of temperature in blue,<br>
		if more, then red.</h1><hr>
	<a href="<c:url value="index.jsp"/>" title="To main page">To main</a><br>
	<a href="<c:url value="subtask2-preview.html"/>" 
		title="Back to previous">Back to previous</a><br>
	<c:choose>
		<c:when test="${not empty errorMessage}">
	    	<div class="error">
		        <c:out value="${errorMessage}"/>
	    	</div><hr>
		</c:when>
		<c:otherwise>
			<div class="descpiption">
				<div class="<c:out value="${color}"/>">
					<c:out value="${temperature}"/>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</body>
</html>

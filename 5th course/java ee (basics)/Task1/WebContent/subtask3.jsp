<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/jstl/fmt"  prefix="fmt"%>
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
	<h1>Create an application that displays last name of developer,<br>
		date and time of receipt task,<br>
		as well as the date and time of execution task.</h1><hr>
	<a href="<c:url value="index.jsp"/>" title="To main page">To main</a><br>
	<div>
		<div class="descpiption">Last name developer:</div>
		<div class="value"><c:out value="${lastName}"/></div><br>

		<div class="descpiption">Date and time of receipt task:</div>
		<div class="value"><fmt:formatDate pattern='yyyy-MM-dd : HH-mm' 
			value="${dateReceived}" /></div><br>

		<div class="descpiption">Date and time of execution task:</div>
		<div class="value"><fmt:formatDate pattern='yyyy-MM-dd : HH-mm'
			value="${dateExecution}" /></div>
	</div>
</body>
</html>

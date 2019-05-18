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
	</h1><hr>
	<a href="<c:url value="/index.jsp"/>" title="To main page">To main</a><br>
	<a href="<c:url value='<%="/ViewDataController"%>'/>" 
		title="Show all database data">Show all database data</a><br>
	<a href="<c:url value='<%="/Subtask3Controller"%>'/>" title="Subtask 3">Subtask 3</a><br>
	<a href="<c:url value='<%="/Subtask4Controller"%>'/>" title="Subtask 4">Subtask 4</a><br><hr>
	
    <c:if test="${not empty errorMessage}">
    	<div class="error">
	        <c:out value="${errorMessage}"/>
    	</div><hr>
    </c:if>
    
	<c:choose>
		<c:when test="${task1HelperGalaxiesList eq null or empty task1HelperGalaxiesList}">
			No found galaxies in the database
		</c:when>
		<c:otherwise>
			<form action="Subtask1Controller" method="POST" accept-charset="utf-8">
				<label for="idGalaxyName">Galaxy:</label>
				<select id="idGalaxyName" name="searchGalaxyName" required="required">
					<c:forEach var="item" items="${task1HelperGalaxiesList}">
						<option value="<c:out value="${item}"/>"><c:out value="${item}" /></option>
					</c:forEach>
				</select><br>
				<input type="submit" name="Submit">
			</form>
		</c:otherwise>
	</c:choose>

</body>
</html>

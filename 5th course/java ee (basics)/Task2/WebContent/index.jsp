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
	<h1>Task 2 - Planets</h1><hr>
	<a href="<c:url value='<%="/ViewDataController"%>'/>" 
		title="Show all database data">Show all database data</a><br>
	<a href="<c:url value="subtask1-preview.jsp"/>" title="Subtask 1">Subtask 1</a><br>
	<a href="<c:url value='<%="/Subtask3Controller"%>'/>" title="Subtask 3">Subtask 3</a><br>
	<a href="<c:url value='<%="/Subtask4Controller"%>'/>" title="Subtask 4">Subtask 4</a><br>
	
    <c:if test="${not empty errorMessage}">
    	<div class="error">
	        <c:out value="${errorMessage}"/>
    	</div><hr>
    </c:if>
 
	<div>
		<h2>Insert galaxy</h2>
		<form action="InsertGalaxyController" method="GET" accept-charset="utf-8">

			<label for="idInsertGalaxyName">Galaxy:</label>
			<input id="idInsertGalaxyName" type="text" name="galaxyName" 
				value="" placeholder="Galaxy" required><br>
			<input type="submit" name="Submit1">
		</form>
	</div><hr>

	<div>
		<h2>Insert planet</h2>
		<form action="InsertPlanetController" method="POST" accept-charset="utf-8">

			<label for="idInsertPlanetName">Planet:</label>
			<input id="idInsertPlanetName" type="text" name="planetName" 
				value="" placeholder="Planet" required><br>

			<label for="idInsertPlanetRadius">Radius:</label>
			<input id="idInsertPlanetRadius" type="text" name="planetRadius" 
				value="" placeholder="Radius" required><br>

			<label for="idInsertPlanetCoreTemperature">Core temperature:</label>
			<input id="idInsertPlanetCoreTemperature" type="text" name="planetCoreTemperature" 
				value="" placeholder="Core temperature" required><br>

			<label for="idInsertPlanetExistAtmosphere">Existence atmosphere:</label>
			<select id="idInsertPlanetExistAtmosphere" name="planetExistAtmosphere" required>
				<option value="False" selected="selected">False</option>
				<option value="True">True</option>
			</select><br>

			<label for="idInsertPlanetExistLife">Existence life:</label>
			<select id="idInsertPlanetExistLife" name="planetExistLife" required>
				<option value="False" selected="selected">False</option>
				<option value="True">True</option>
			</select><br>

			<label for="idInsertPlanetGalaxyName">Galaxy:</label>
			<select id="idInsertPlanetGalaxyName" name="planetGalaxyName">
				<option value="" selected="selected">&lt;Not specified&gt;</option>
				<c:choose>
					<c:when test="${helperGalaxiesList ne null}">
						<c:forEach var="item" items="${helperGalaxiesList}">
							<option value="<c:out value="${item}"/>"><c:out value="${item}" /></option>
						</c:forEach>
					</c:when>
				</c:choose>
			</select><br>

			<input type="submit" name="Submit2">
		</form>
	</div><hr>

	<div>
		<h2>Insert satellite</h2>
		<form action="InsertSatelliteController" method="POST" accept-charset="utf-8">

			<label for="idInsertSatelliteName">Satellite:</label>
			<input id="idInsertSatelliteName" type="text" name="satelliteName" 
				value="" placeholder="Satellite" required><br>

			<label for="idInsertSatelliteRadius">Radius:</label>
			<input id="idInsertSatelliteRadius" type="text" name="satelliteRadius" 
				value="" placeholder="Radius" required><br>

			<label for="idInsertSatelliteDistanceToPlanet">Distance to planet:</label>
			<input id="idInsertSatelliteDistanceToPlanet" type="text" name="satelliteDistanceToPlanet" 
				value="" placeholder="Distance to planet" required><br>

			<label for="idInsertSatellitePlanetName">Planet:</label>
			<select id="idInsertSatellitePlanetName" name="satellitePlanetName">
				<option value="" selected="selected">&lt;Not specified&gt;</option>
				<c:choose>
					<c:when test="${helperPlanetsList ne null}">
						<c:forEach var="item" items="${helperPlanetsList}">
							<option value="<c:out value="${item}"/>"><c:out value="${item}"/></option>
						</c:forEach>
					</c:when>
				</c:choose>
			</select><br>

			<input type="submit" name="Submit3">
		</form>
	</div>
</body>
</html>

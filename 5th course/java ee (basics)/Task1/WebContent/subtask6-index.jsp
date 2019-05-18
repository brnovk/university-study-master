<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Subtask 6</title>
	<link rel="stylesheet" href="css/app-style.css">
</head>
<body>
	<h1>Phonebook.<br>
		Table must contain last name, address, phone.<br>
		Search should be made on the part name or part phone.<br>
		Results should be displayed together with date of execution in JSP. </h1><hr>
	<a href="<c:url value="index.jsp"/>" title="To main page">To main</a><br>
	
    <c:if test="${not empty errorMessage}">
    	<div class="error">
	        <c:out value="${errorMessage}"/>
    	</div><hr>
    </c:if>
 
	<form name="appendForm" action="Subtask6AppendController" method="POST"
			accept-charset="utf-8">
		<div>
			<label for="idAppendName">Last name:</label>
			<input type="text" name="surname" id="idAppendName"
				placeholder="Last name" required/>
		</div>
		<div>
			<label for="idAppendPhone">Phone. Valid delimiters:
				<strong>-</strong> <strong>(</strong> <strong> ) </strong></label>
			<input type="text" name="phone" id="idAppendPhone"
				placeholder="(8029) 555-35-35" required/>
		</div>
		<div>
			<label for="idAppendAddress">Address:</label>
			<input type="text" name="address" id="idAppendAddress"
				placeholder="Address" required/>
		</div>
		<div>
			<input type="submit" value="Submit data" />
		</div>
	</form>

	<form name="searchPhoneForm" action="Subtask6SearchController"
		method="GET" accept-charset="utf-8">
		<div>
			<label for="idSearchPhone">
				Phone or part of phone (no delimiters):</label>
			<input type="text" name="phone" id="idSearchPhone"
				placeholder="5553535" required/>
		</div>
		<div>
			<input type="submit" name="searchPhone" value="Search phone"/>
		</div>
	</form>

	<form name="searchSurnameForm" action="Subtask6SearchController" method="GET"
			accept-charset="utf-8">
		<div>
			<label for="idSearchSurname">
				Last name or part of last name (any case):</label>
			<input type="text" name="surname" id="idSearchSurname"
				placeholder="Last name" required/>
		</div>
		<div>
			<input type="submit" name="searchSurname" value="Search last name"/>
		</div>
	</form>

	<c:choose>
		<c:when test="${nodeList eq null or empty nodeList}">
			List not contains entries.
		</c:when>
		<c:otherwise>
			<table>
				<caption>List of entries</caption>
				<thead>
					<tr>
						<th>Phone</th>
						<th>Last name</th>
						<th>Address</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="currentNode" items="${nodeList}">
					<tr>
						<td>
			    			<c:out value="${currentNode.phone}" />
					    </td>
						<td>
			    			<c:out value="${currentNode.surname}" />
					    </td>
						<td>
			    			<c:out value="${currentNode.address}" />
					    </td>
				     </tr>
				</c:forEach>
				</tbody>
			</table>
		</c:otherwise>
	</c:choose>
</body>
</html>

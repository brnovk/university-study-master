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
	<a href="<c:url value="subtask6-index.jsp"/>" 
		title="Back to previous">Back to previous</a><br>

	<c:choose>
		<c:when test="${listOfFound eq null or empty listOfFound}">
			Specified value is not found.
		</c:when>
		<c:otherwise>
			<table>
				<caption>
					Found entries by value: <c:out value="${searchValue}"/>.<br>
					Date perform a search: <c:out value="${dateExecution}"/>
				</caption>
				<thead>
					<tr>
						<th>Phone</th>
						<th>Last name</th>
						<th>Address</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="currentNode" items="${listOfFound}">
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

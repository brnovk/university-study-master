<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<body>
 
	<c:if test="${not empty errCode}">
		<h1>${errCode} : System Errors</h1>
	</c:if>
 
	<c:if test="${empty errCode}">
		<h2>System Errors</h2>
	</c:if>
 
	<c:if test="${not empty errMsg}">
		<h4>${errMsg}</h4>
	</c:if>
 
</body>
</html>
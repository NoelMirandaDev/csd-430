<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/views/generalErrorPage.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://module11.edu/tags" prefix="db" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Database Table Creation</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/style.css">
</head>
<body>
	<h2>Creating and initializing database table 'applicants' ...</h2>
	
	<!-- custom tag checking if table 'applicants' exists, if not it is created, then a sample entry is inserted -->
	<db:createTable />
	
	<!-- Checks the request attribute 'createTableStatus' which was set by the custom tag of createTable -->
	<c:choose>
		<c:when test="${createTableStatus == 'success'}">
			<p style="color: green;">Table and sample data created successfully.</p>
		</c:when>
		
		<c:when test="${createTableStatus == 'failure'}">
			<p style="color: red;">There was a problem creating the table or inserting data.</p>
		</c:when>
		
		<c:otherwise>
			<p style="color: red;">Status unknown</p>
		</c:otherwise>
	</c:choose>
	
	
	<form action="${pageContext.request.contextPath}/views/second.jsp" method="GET">
		<input type="submit" value="Go to Second Page">
	</form>
</body>
</html>
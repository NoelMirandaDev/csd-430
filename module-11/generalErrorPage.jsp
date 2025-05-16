<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Unexpected Error</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/style.css">
</head>
<body>
	<h2>Oh no, we encountered an unexpected error!</h2>
	<p class="errorMessage">We apologize for the inconvenience.</p>
	   
	<c:if test="${not empty exception}">
	   <p class="errorMessage">${exception}</p>
	</c:if>
	 
	 <p class="errorMessage">Please check back later or return to the 
	 <a href="${pageContext.request.contextPath}/views/second.jsp">Form page</a>.</p>
	
	<div class="sadFaceContainer">
		<img src="${pageContext.request.contextPath}/views/sadface.png">
	</div>
	
</body>
</html>
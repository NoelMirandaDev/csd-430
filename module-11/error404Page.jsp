<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Error 404</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/style.css">
</head>
<body>

	<h2>Oh no, not the 404 Error!</h2>
	<p class="errorMessage">We apologize for the inconvenience.
	<p class="errorMessage">The page you are looking for is currently unavailable.</p>
	<p class="errorMessage">Please check back later or return to the 
	<a href="${pageContext.request.contextPath}/views/second.jsp">Form page</a>.</p>
	   
	<div class="sadFaceContainer">
		<img src="${pageContext.request.contextPath}/views/sadface.png">
	</div>

</body>
</html>
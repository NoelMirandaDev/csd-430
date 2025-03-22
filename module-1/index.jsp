<!-- 
Noel Miranda 
Module 1 Assignment 1
First JSP Project
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My First JSP Page</title>
</head>
<body>
	<h1>Server Side Development Module 1 Assignment 1</h1>
	
	<%
	String message = "This message, the user-agent, and date below were output through Java scriplets (Java code embedded within an HTML file)<br>" +
					 "within a JSP page. When the web server receives the HTTP request for the JSP page, it forwards the request to the<br>" +
					 "JSP engine. The JSP engine converts the JSP page into a Java Servlet, which is then compiled and executed by the<br>" +
					 "servlet engine. After execution, the response is sent back to the client's browser, which displays the content.";
							 
	out.println(message);
							 
	Date today = new Date();
	%>
	
	<p>This is the User-Agent: <%=request.getHeader("User-Agent")%></p>
	
	<p>Today's date: <%=today%></p>
	
</body>
</html>
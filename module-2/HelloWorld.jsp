<!-- 
Author: Noel Miranda
Module 2 Assignment
Objective: create a JSP file, starting with the “Hello World” example in our text. Add several 
items expanding on this example having a minimum of 3 scriplet sections in your code.
 -->
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Module 2 Assignment</title>
	</head>

	<body>
	
		<h1 style="text-align:center;">Hello from Eclipse!</h1>
		
			<!-- First scriplet storing a formatted date and time -->
			<%
				String dateTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("MM/dd/yyyy hh:mm:ss a"));
			%>
		
		<p><b>Date:</b> <%= dateTime.split(" ")[0] %> <b>| Time:</b> <%= dateTime.split(" ")[1] %> <%= dateTime.split(" ")[2] %> </p>
		
			<!-- Second scriplet retrieving and updating the current session visit count -->
			<% 
				Integer count = (Integer) session.getAttribute("visitCount");
				count = (count == null) ? 1 : count + 1;
				session.setAttribute("visitCount", count);
			%>
		
		<p><b>Number of times you have visited/refreshed this page (Session-Based):</b> <%=count%></p>
		<hr>
		
		<h2 style="color:blue;">Random Generator</h2>
		
			<!-- Third scriplet storing random integers in an array-->
			<%
				int[] randomNums = new int[10];
				
				
				for (int i = 0; i < randomNums.length; i++ ) {
					randomNums[i] = (int) (Math.random() * 10000);
				}
			%>
		
		<p><b>10 random integers generated:</b> </p>
		
		<!-- Paragraph with embedded fourth scriplet for outputting numbers from array -->
		<p style="color:red; background-color: lightgrey; width: 23%; text-align: center;">
			<% 
				for (int number : randomNums) {
					out.print(number + "<br>");
				}
			%>
		</p>
		
	</body>
</html>
<!-- 
Author: Noel Miranda
Module 4 Assignment
Objective: Create a JSP that outputs the requested content, 
displaying all of the information in a table format.
Use a FORM for the user's input.
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Login Page</title></head>
<body style="display: grid; place-items: center; height: 100vh;">

	<%
		// Variable for error message to direct user 
		String errorMessage = "";
		
		// Checks to see if request is POST to display table of form input
		if (request.getMethod().equals("POST")) {
			String userName = request.getParameter("userName");
			String userPassword = request.getParameter("userPassword");
			
			// Checks to see if user did not submit blank fields or spaces
			if (userName == null || userName.isBlank() || 
					userPassword == null || userPassword.isBlank()) {
				errorMessage = "Incorrect field inputs (empty or spaces detected)";
				
			} else {
	%>
	
				<div style="margin-top: -25%;">
				<p>Welcome <%= userName%>!</p>
				<hr>
				<p><b>Found Below is a Table for the User Inputs:</b></p>
				
				<table border="1" style="text-align: center; background-color: black; width: 100%;">
					<tr style="background-color: grey;"><th>User Name</th><th>Password</th></tr>
					<tr style="background-color: lightblue;"><td><%= userName%></td><td><%= userPassword%></td>
				</table>
				<br>
				<a href="<%= request.getRequestURI() %>" style="color: blue;">Back to Login Page.</a>
				</div>
	<%
				// Necessary to prevent displaying table and login page at the same time
				return;
			}
		}
	%>
	
	<div style="margin-top: -25%;">
	
		<h1 style="text-align: center;">Some Application</h1>
		
		<form method="POST" action="<%= request.getRequestURI()%>">
		
			<fieldset style="background-color: lightblue; padding: 10px; text-align: center;">
				<legend>Login</legend>
				
				<label for="uName">Username:</label>
				<input type="text" id="uName" name="userName" maxlength="20" style="margin: 10px;"><br>
				
				<label for="uPassword">Password:</label>
				<input type="password" id="uPassword" name="userPassword" maxlength="20" style="margin: 10px;"><br>
				
				<% if (!errorMessage.isEmpty()) { %>
				
				<div style="color: red; font-size: .8em;"><%= errorMessage%></div>
				
				<% } %>
				
				<input type="submit" value="Login" style="margin: 10px;"><br>
				
				<a href="<%= request.getRequestURI() %>" style="font-size: .8em">Refresh Page</a>
			</fieldset>
		</form>
	</div>
	
</body>
</html>
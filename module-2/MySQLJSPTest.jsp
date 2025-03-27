<!-- 
Noel Miranda 
Module 2
Objective: Testing Connection of MySQL database with JSP. 
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.Connection, java.sql.DriverManager, java.sql.SQLException,
    java.sql.PreparedStatement, java.sql.ResultSet"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Testing MySQL Connection with JSP</title>
</head>
	<body style="justify-items: center; background-color: lightgrey;">
		<h1 style="text-align:center; width: 100%;">Databasedb Table Fans Displayed Below</h1>
		<br>
		
			<%
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					
					try (Connection conn = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/databasedb", "username", "password");
						PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM fans");) {
						
						ResultSet rs = pstmt.executeQuery();
						
						out.print("<table border=1 style=\"width: 80%; background-color: lightblue; text-align:center;\">");
						
						out.print("<tr style=\"background-color: grey \">" +
							"<th>ID</th>" +
							"<th>First Name</th>" +
							"<th>Last Name</th>" +
							"<th>Favorite Team</th>" +
						"</tr>");
						
						while (rs.next()) {
							out.print("<tr>" +
							"<td>" + rs.getInt("ID") + "</td>" +
							"<td>" + rs.getString("firstname") + "</td>" +
							"<td>" + rs.getString("lastname") + "</td>" +
							"<td>" + rs.getString("favoriteteam") + "</td>" +
							"</tr>");
						}
						
						out.print("</table>");
					}
				} catch (ClassNotFoundException | SQLException e) {
					out.print("We apologize for the Error.<br>Connection error: " + e.getMessage());
				}
			%>
		
	</body>
</html>
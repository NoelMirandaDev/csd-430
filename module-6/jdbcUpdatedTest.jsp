<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.Connection, java.sql.DriverManager, java.sql.SQLException,
    java.sql.PreparedStatement, java.sql.ResultSet, java.sql.ResultSetMetaData, java.util.Locale, 
    java.text.NumberFormat"%>
<!DOCTYPE html>
<html>
<head>
<title>JDBC test</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<div class="navbar">
	<a href="/ebookshop/eshop" class="navbar-icon"><img src="/ebookshop/images/book.png" 
		alt="book icon">Online Bookshop</a>
</div>
<div class="center-container">

	<h2>JSP-Mysql-Tomcat Connection Test</h2>
<%
	try {
		Class.forName(application.getInitParameter("mysqlDriver"));
		// Try-with-resources to automactically close Connection, Statement, and ResultSets
		try (
				Connection conn = DriverManager.getConnection(
					application.getInitParameter("dbUrl"),
					application.getInitParameter("dbUser"),
					application.getInitParameter("dbPassword"));
				
				/* This query is based of the textbook, uncomment to use
				PreparedStatement pstmt = conn.prepareStatement("select * from books");
				*/
				
				// This query uses alias column names and replaces the category 
				// id in the table for the actual category name
				PreparedStatement pstmt = conn.prepareStatement(
						"SELECT " +
							"b.book_id AS `Book ID`, " +
							"b.title AS `Title`, " +
							"b.author AS `Author`, " +
							"b.price AS `Price`, " +
							"c.category_name AS `Category` " +
						"FROM books b " +
						"JOIN categories c ON b.category_id = c.category_id;"
						);
				
				ResultSet rs = pstmt.executeQuery();
			)
		{
				
%>
	<table>
		<%
			ResultSetMetaData resMetaData = rs.getMetaData();
			int nCols = resMetaData.getColumnCount(); // Number of columns
		%>
		<tr>
			<%
				// Iterates through metadata to create table headings (using alias names instead)
				for (int kCol = 1; kCol <= nCols; kCol++) {
				out.print("<th><b>" + resMetaData.getColumnLabel(kCol) + "</b></th>");
			}
			%>
		</tr>
		
		<%
			// Iterates through query result of prepared statement to display 
			// the books table from the database
			while (rs.next()) {
				// Initialize NumberFormat class to format book price value to US currency
				NumberFormat dollarFormatter = NumberFormat.getCurrencyInstance(Locale.US);
		%>
		
		<tr>
			<%
				// iterates and adds into the html table the data of each column per row
				// while rs.next()
				for (int kCol = 1; kCol <= nCols; kCol++) {
					// Column 4 of the result set is the price of the book, therefore it needs a proper currency format
					if (kCol == 4) {
						double price = Double.valueOf(rs.getString(kCol));
						out.print("<td>" + dollarFormatter.format(price) + "</td>");
					} else {
						out.print("<td>" + rs.getString(kCol) + "</td>");
					}
				}
			%>
		</tr>
<%
			} // While(rs.next()..)
%>
	</table>
	
	<!-- Message gets executed only if the connection and query are successful -->
	<h1 id="pass-message">Test Passed!</h1>
<%
		} // try-with-resources	
	} catch (ClassNotFoundException | SQLException e) {
%>
		<!-- Message gets executed only if the connection or query were unsuccessful -->
		<p>We apologize for the Error.
		<br>
		Connection error: <%=e.getMessage()%></p>
		<h1 id="error-message">Test Failed!</h1>
<%
	} // catch..
%>
</div>
	
</body>
</html>
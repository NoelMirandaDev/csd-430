package model;

import java.sql.Connection;
import java.sql.DriverManager;

import javax.servlet.ServletContext;

public class DBManager {
	
	// Static block runs once when the class is loaded.
    // It loads the MySQL JDBC driver so it can use DriverManager to connect later.
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("MySQL Driver not found. ", e);
		}
	}
	
	// Returns a live database connection using parameters defined in web.xml.
	public static Connection getConnection(ServletContext context) throws Exception {
		try {
			// Gets database configuration from <context-param> in web.xml
			String url = context.getInitParameter("dbUrl");
			String user = context.getInitParameter("dbUser");
			String password = context.getInitParameter("dbPassword");
			
			// Uses DriverManager to create and return a connection
			return DriverManager.getConnection(url, user, password);
		} catch (Exception e) {
			// Rethrows as a RuntimeException to make errors easier to spot and display JSP error page
			throw new RuntimeException("Failed to create database connection. ", e);
		}
	}
}
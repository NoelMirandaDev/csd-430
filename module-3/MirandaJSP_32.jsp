<!-- 
Author: Noel Miranda
Module 3 Assignment
Objective: Create a JSP that declares and initializes a String array. 
Use a for-each loop to display the array.
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>JSP_32</title></head>
<body style="justify-items: center; background-color: lightgrey;">

	<!-- Declared and initiliazed String array-->
	<%
		String[] stringArray = {"Apple", "Orange", "Banana", "Mango", "Watermelon", "Kiwi"};
	%>
	
	<h1 style="text-align: center; color: blue;">String Array Iteration with for-each Loop</h1>
	<h2>String array consists of: </h2>
		<ol>
			<%
			// for-each loop iterating through string array
				for(String e : stringArray) {
					out.print("<li>" + e + "</li><br>");
				}
			%>
		</ol>
</body>
</html>
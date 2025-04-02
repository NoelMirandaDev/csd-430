<!-- 
Author: Noel Miranda
Module 3 Assignment
Objective: Create a JSP that declares and initializes an int array. Then, 
using loop iteration and selection, go through the array displaying each 
element along with identifying even and odd values.
-->
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>JSP_31</title></head>
<body style="justify-items: center;">
	<%
		// Declaring and initiliazing an array with 10 random integers
		int[] arrayInt = new int[10];
		for (int i = 0; i < arrayInt.length; i++) {
			arrayInt[i] = (int)(Math.random() * 1000);
		}
	%>
	
	<h1 style="text-align: center; color: blue;">The Server Holds an Array of 10 Random Integers</h1>
	<h2 style="text-decoration: underline;">Here are the elements of the array: </h2>
	
	<!-- Scriplet going through each array element, identifying even/odd, and displaying it -->
	<% for (int i=0; i < arrayInt.length; i++) { %>
	
		<p>Array Element at index <%= i%> is <b><%= arrayInt[i]%></b>
		
		<%
			String isOddEven = (arrayInt[i] % 2 == 0) ? "Even" : "Odd";
		%>
		
		and it is an <b><%= isOddEven %></b> integer.</p>
	<% } %>
	
</body>
</html>
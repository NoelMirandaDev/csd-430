<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page session="true" import="java.util.Vector, ebookshop.Book"%>
   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>E-bookshop</title>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<div id="navbar">
	<a href="/ebookshop/eshop" id="navbar-icon"><img src="/ebookshop/images/book.png" 
		alt="book icon">Online Bookshop</a>
</div>
<div class="center-container">
	<h2>Shopping Cart</h2>
	<br>
	
<% // Scriplet 1: check whether the booklist exists in the session.
	Vector<String> booklist = 
		(Vector<String>)session.getAttribute("ebookshop.list");

	//If the booklist is null (it does not exist), redirect to the eshop page.
	if (booklist == null) {
		response.sendRedirect("/ebookshop/eshop"); // Redirect to /eshop
	}
	else {
%>
	<!-- Form to add books to the cart -->
	<form name="addForm" action="eshop" method="POST">
		<input type="hidden" name="do_this" value="add"> <!-- Hidden field to identify action as 'add' -->
		Book:
		<select name=book> <!-- Dropdown to select a book -->
			
<% // Scriplet 2: Loop through the booklist and display each book in the dropdown.
	for (int i = 0; i < booklist.size(); i++) {
		out.println("<option>" + booklist.elementAt(i) + "</option>"); // Add each book to the select options.
	}
%>
		</select>
		<!-- Input field to specify quantity, default value is 1 -->
		Quantity: <input type="text" name="qty" size="3" value="1">
		<input type="submit" value="Add to Cart"> <!-- Button to submit the form and add the book to cart -->
	</form>
	<br>
	
<% // Scriptlet 3: Check if the shopping cart (shoplist) is empty.
	Vector<ebookshop.Book> shoplist = 
		(Vector<ebookshop.Book>)session.getAttribute("ebookshop.cart");
	
	// If the shopping cart has items, display them.
	if (shoplist != null && shoplist.size() > 0) {
%>
	<!-- Displays cart contents in a table -->
	<table>
	<tr>
		<th>Title</th>
		<th>Price</th>
		<th>Quantity</th>
		<th></th>
	</tr>
	
<% // Scriplet 4: Loop through the shopping cart and display each book's details.
	for (int i = 0; i < shoplist.size(); i++) {
		Book aBook = shoplist.elementAt(i); // Get the current book from the cart.
%>
	<tr>
		<!-- Form to remove a book from the cart -->
		<form name="removeForm" action="eshop" method="POST">
			<!-- Hidden field to identify which book to remove -->
			<input type="hidden" name="position" value="<%=i%>">
			<!-- Hidden field to specify 'remove' action -->
			<input type="hidden" name="do_this" value="remove">
			<td><%=aBook.getTitle()%></td> <!-- Display the title of the book -->
			<td align="right">$<%=aBook.getPrice()%></td> <!-- Display the price of the book -->
			<td align="right"><%=aBook.getQuantity()%></td> <!-- Display the quantity of the book in the cart -->
			<td><input  type="Submit" class="red" value="Remove from Cart"></td> <!-- Button to remove the book from cart -->
		</form>
	</tr>
	
<%
	} // for (int i..)
%>

	</table>
	<br>
	
	<div id="checkout-clear-container">
		<!-- Form to checkout the items in the cart -->
		<form name="checkoutForm" action="eshop" method="POST">
			<input type="hidden" name="do_this" value="checkout"> <!-- Hidden field to specify 'checkout' action -->
			<input type="submit" class="green" value="Checkout"> <!-- Button to proceed to checkout -->
		</form>
		
		<form name="removeAllForm" action="eshop" method="POST">
			<input type="hidden" name="do_this" value="removeAll"> <!-- Hidden field to specify 'checkout' action -->
			<input type="submit" class="red" value="Clear Cart"> <!-- Button to proceed to checkout -->
		</form>
	</div>
	
<%
		} // if (shoplist..
	} // if (booklist..else..	
%>
</div>
</body>
</html>
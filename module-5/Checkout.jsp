<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" import="java.util.Vector, ebookshop.Book"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>E-BookShop Checkout</title>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<div id="navbar">
	<a href="/ebookshop/eshop" id="navbar-icon"><img src="/ebookshop/images/book.png" 
		alt="book icon">Online Bookshop</a>
</div>
<div class="center-container">
	<h2>Thank you for your order!</h2>
	<h2>Order Summary</h2>
	<br>
	<table>
		<tr>
			<th>Title</th>
			<th align="right">Price</th>
			<th align="right">Quantity</th>
		</tr>
		
<%
	//Retrieves the shopping cart (a Vector of Book objects) from the session
	Vector<Book> shoplist =
		(Vector<Book>)session.getAttribute("ebookshop.cart");
	
	//Loop through each book in the shopping cart
	for (Book anOrder : shoplist) {
%>
		<tr>
			<!-- Display the book's title, price, and quantity in table rows -->
			<td><%=anOrder.getTitle()%></td>
			<td align="right">$<%=anOrder.getPrice()%></td>
			<td align="right"><%=anOrder.getQuantity()%></td>
		</tr>
		
<%
	}
	// End the session to clear the cart after checkout is complete
	session.invalidate();
	
%>

		<tr>
			<!-- Display the totals row with overall price and quantity -->
			<td id="totals">TOTALS</td>
			<td id="totals" align="right">$<%=(String)request.getAttribute("dollars")%></td>
			<td id="totals" align="right"><%=(String)request.getAttribute("books")%></td>
		</tr>
		
	</table>
	<br>
	<!-- Link to return to the shopping page -->
	<a href="/ebookshop/eshop">Buy more!</a>
</div>
</body>
</html>
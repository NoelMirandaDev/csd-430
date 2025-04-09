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
	<h1>Your Online BookShop - Checkout</h1>
	<hr><br>
	<table border="1">
		<tr>
			<td>Title</td>
			<td align="right">Price</td>
			<td align="right">Quantity</td>
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
			<td>TOTALS</td>
			<td align="right"><%=(String)request.getAttribute("dollars")%></td>
			<td align="right"><%=(String)request.getAttribute("books")%></td>
		</tr>
	</table>
	<br>
	<!-- Link to return to the shopping page -->
	<a href="/ebookshop/eshop">Buy more!</a>
</body>
</html>
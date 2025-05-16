<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/views/generalErrorPage.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://module11.edu/tags" prefix="db" %>
<%@ page import="model.ApplicantBean" %>

<jsp:useBean id="applicant" class="model.ApplicantBean" scope="request" />
<jsp:setProperty name="applicant" property="*" /> <!-- Only sets values if there are matching request parameters. -->

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Bellevue University Application Form</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/views/style.css">
</head>
<body>
	<c:if test="${pageContext.request.method == 'GET'}"> <!-- Only displays form for get requests -->
		<h2>Inquiry Form - Bellevue University</h2>
		
		<!-- Form -->
		<form method="POST" action="${pageContext.request.requestURI}">
		
			First Name: <input type="text" name="firstName" required 
			pattern="[A-Za-z\s]+" maxlength="50"/><br />
			
			Last Name: <input type="text" name="lastName" required 
			pattern="[A-Za-z\s]+" maxlength="50"/><br/>
			
			Email: <input type="email" name="email" required /><br/>
			
			Phone: <input type="text" name="phone" required 
			pattern="\d{10}" title="Enter 10-digit phone number"/><br/>
			
			Gender:
			<select name="gender" required>
				<option value="" disabled selected>Select</option>
				<option>Male</option>
				<option>Female</option>
			</select><br/>
			
			DOB: <input type="date" name="dob" required /><br/>
			
			City: <input type="text" name="city" required maxlength="50" /><br/>
			
			State: <input type="text" name="state" required maxlength="50" /><br/>
			
			<input type="submit" value="Submit Inquiry" />
			
		</form>
	</c:if>
	
	<c:if test="${pageContext.request.method == 'POST'}"> <!-- Only displays table for post requests (after form submission) -->
		<!-- Custom tag to insert applicant bean only when form is submitted -->
		<db:insertApplicant applicant="${applicant}" />
		
		<!-- Custom tag to load all the applicants from the Database -->
		<db:listApplicants />
		
		<h2>Bellevue University</h2>
		
		<!-- Displays insert success/failure messages -->
		<c:choose>
			<c:when test="${insertStatus == 'success'}">
				<p style="color:green;">Applicant record inserted successfully!</p>
			</c:when>
			
			<c:when test="${insertStatus == 'sql_error'}">
				<p style="color: red;">Sorry! System failed to insert applicant record.</p>
			</c:when>
			
			<c:when test="${insertStatus == 'failure'}">
				<p style="color: red;">System unexpectedly failed and was unable to insert applicant record.</p>
			</c:when>
		</c:choose>
		
		<!-- Checks to see if attribute 'applicantList' is empty, set by custom tag 'listAppliancts' -->
		<c:if test="${empty applicantList}">
   			 <p>No applicants found.</p>
		</c:if>
		
		<!-- If attribute not empty then it displays all applicant records in table format-->
		<c:if test="${not empty applicantList}">
			<h3>All Applicant Inquiries in the Database are Listed Below:</h3>
			<table>
				<tr>
					<th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Gender</th>
					<th>DOB</th><th>City</th><th>State</th>
				</tr>
				
				<c:forEach var="a" items="${applicantList}">
					<tr>
						<td>${a.id}</td>
						<td>${a.firstName} ${a.lastName}</td>
						<td>${a.email}</td>
						<td>${a.phone}</td>
						<td>${a.gender}</td>
						<td>${a.dob}</td>
						<td>${a.city}</td>
						<td>${a.state}</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
		
		<!-- New GET request initiated if submit button click to start the process over -->
		<form method="GET" action="${pageContext.request.requestURI}">
			<input type="submit" value="Back to form" />
		</form> 
	</c:if>
</body>
</html>
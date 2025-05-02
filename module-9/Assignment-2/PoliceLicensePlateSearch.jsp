<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>License Plate Data</title>
</head>
<body>

<!-- Fetches the raw contents of the licensePlate.xml file and stores it as a string in licensePlateXML. -->
<c:import url="licensePlate.xml" var="licensePlateXML"/>

<!-- verifies that variable holding xml raw contents is not empty -->
<c:if test="${not empty licensePlateXML}">

	<!-- Takes the raw XML string and parses it into an XPath-ready document stored in plateData. -->
	<x:parse xml="${licensePlateXML}" var="plateData"/>
	
	<h1>License Plate Searched: <x:out select="$plateData/licensePlate/@number"/></h1>
	
	<h2>Owner Information</h2>
	<p>
	  Name:
	  <x:out select="$plateData/licensePlate/owner/ownerName/first"/> 
	  <x:out select="$plateData/licensePlate/owner/ownerName/last"/>
	</p>
	
	<h3>Vehicle Info (Displayed only if stolen)</h3>
	<x:if select="$plateData/licensePlate/owner/vehicle[@status='stolen']">
	  <ul>
	    <li>Make: <x:out select="$plateData/licensePlate/owner/vehicle/make"/></li>
	    <li>Model: <x:out select="$plateData/licensePlate/owner/vehicle/model/modelName"/></li>
	    <li>Year: <x:out select="$plateData/licensePlate/owner/vehicle/model/year"/></li>
	    <li>Color: <x:out select="$plateData/licensePlate/owner/vehicle/color/colorName"/></li>
	  </ul>
	</x:if>
	
	<h3>Criminal Records - Speeding</h3>
	<!-- The XPath below is different from the rest in that it is not specific (full path). This XPath expression searches through the
	whole plateData content for elements of record type with a subelement of offense with the value of 'Speeding' -->
	<x:forEach select="$plateData//record[offense='Speeding']" var="rec">
	  <p>
	    Offense: <x:out select="$rec/offense"/> <br/>
	    Date: <x:out select="$rec/date"/> <br/>
	    Location: <x:out select="$rec/location"/>
	  </p>
	</x:forEach>
</c:if>

</body>
</html>
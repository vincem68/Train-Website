<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>

<html>

<head><title>Invalid Order</title></head>

<body>

	<h1>Error</h1>
	<br>
	There was an error when processing your order. Order information may be incorrect. Please enter the correct information.
	
	<br>
	
	<form method = "get" action = "reservation.jsp">
		<input type = "submit" value = "Back">
	</form>

</body>

</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>

<html>

<head><title>Invalid</title></head>

<body>

	<h1>Error</h1>
	<br>
	<br>
	There was a problem trying to delete your reservation. Please ensure that the reservation information entered is valid.
	<br>
	<form type = "get" action = "cancel.jsp">
		<input type = "submit" value= "Back">
	</form>

</body>

</html>
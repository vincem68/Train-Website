<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="head.jsp" %>
</head>
<body>
	<% try {
		session.invalidate();
		response.sendRedirect("login.jsp");
	} catch (Exception e) {
		
	} %>
</body>
</html>
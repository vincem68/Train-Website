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
	
	<% if (session.getAttribute("loggedIn") != null && (Boolean)session.getAttribute("loggedIn")) { 
		response.sendRedirect("index.jsp"); 
	} else { %>
	<div class="container mx-auto" style="width: 800px;">
		<div class="card">
			<div class="card-body">
			<h3 class="display-4 text-center">Customer Login</h3>
			<form action="loginPost.jsp" method="post">
			  <div class="form-group">
			    <label for="formGroupExampleInput">Username</label>
			    <input type="text" name="username" class="form-control" id="usernameInput" placeholder="Enter Username">
			  </div>
			  <div class="form-group">
			    <label for="formGroupExampleInput2">Password</label>
			    <input type="password" name="password" class="form-control" id="passwordInput" placeholder="Enter Password">
			  </div>
			  <div class="form-group">
			  	<input class="btn btn-success btn-lg btn-block" type="submit" value="Login">
			  	<small class="form-text text-muted">
			  		Don't have an account? <a href="register.jsp"> Register </a>
			  	</small>
			  </div>
			</form>	
			</div>
		</div>
		<small class="text-right form-text text-muted">
	  		<a href="employeeLogin.jsp"> Employee Login </a>
	  	</small>
	</div>
	<%
	}	
	%>
</body>
</html>
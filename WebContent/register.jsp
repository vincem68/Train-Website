<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
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
			<h3 class="display-4 text-center">Create Account</h3>
			<form action="registerPost.jsp" method="post">
			  <div class="form-group">
			  	<div class="form-row">
			  		<div class="col">
			  		  <label for="firstname">First Name</label>
				      <input type="text" name="firstname" class="form-control" id="firstnameInput" placeholder="First name" required>
				      <small class="form-text text-muted">
			  			25 characters max.
			  		  </small>
				    </div>
				    <div class="col">
				      <label for="lastname">Last Name</label>
				      <input type="text" name="lastname" class="form-control" id="lastnameInput" placeholder="Last name" required>
				      <small class="form-text text-muted">
			  			25 characters max.
			  		  </small>
				    </div>
			  	</div>
			  </div>
			  <div class="form-group">
			    <label for="email">Email Address</label>
			    <input type="text" name="email" class="form-control" id="emailInput" placeholder="Enter Username" required>
			    <small class="form-text text-muted">
			  		50 characters max.
			  	</small>
			  </div>
			  <div class="form-group">
			    <label for="username">Username</label>
			    <input type="text" name="username" class="form-control" id="usernameInput" placeholder="Enter Username" required>
			    <small class="form-text text-muted">
			  		20 characters max.
			  	</small>
			  </div>
			  <div class="form-group">
			    <label for="password">Password</label>
			    <input type="password" name="password" class="form-control" id="passwordInput" placeholder="Enter Password" required>
			    <small class="form-text text-muted">
			  		20 characters max.
			  	</small>
			  </div>
			  <div class="form-group">
			  	<input class="btn btn-success btn-lg btn-block" type="submit" value="Register">
			  	<small class="form-text text-muted">
			  		Have an account? <a href="login.jsp">Login</a>
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
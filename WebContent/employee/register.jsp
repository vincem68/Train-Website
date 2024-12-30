<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../head.jsp" %>
</head>
<body>
	<% if (session.getAttribute("loggedIn") == null || !((Boolean)session.getAttribute("loggedIn"))) {
			response.sendRedirect("../login.jsp");
	} else if (session.getAttribute("isAdmin") != null && (Integer)session.getAttribute("isAdmin") == 1) { %>
	<%@ include file="../header.jsp" %>

	<div class="container mx-auto" style="width: 800px;">
		<br>
		<div class="text-right">
			<a href="employees.jsp">Manage Employees</a>
		</div>
		<div class="card">
			<div class="card-body">
			<h3 class="display-4 text-center">Register Employee</h3>
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
			    <label for="ssn">Social Security</label>
			    <input type="text" name="ssn" class="form-control" id="emailInput" placeholder="Enter SSN" required>
			    <small class="form-text text-muted">
			  		11 characters max. Format ###-##-####
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
			  </div>
			</form>	
			</div>
		</div>
	</div>
	<%
	} else { %>
		<div class="container">
			<div class="alert alert-warning">
				You do not have permissions to view this page. <a href="../index.jsp">Home</a>
			</div>
		</div>
	<% } %>
</body>
</html>
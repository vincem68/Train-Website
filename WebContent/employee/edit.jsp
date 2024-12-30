<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../head.jsp" %>
</head>
<body>
	<% try {
		if (session.getAttribute("loggedIn") == null || !((Boolean)session.getAttribute("loggedIn"))) {
			response.sendRedirect("../login.jsp");
		} else if (session.getAttribute("isAdmin") != null && (Integer)session.getAttribute("isAdmin") == 1) {
			
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			PreparedStatement stmt = null;
			
			String ssn = request.getParameter("ssn");

			String str = "SELECT * FROM Employees where ssn = ?";
			stmt = con.prepareStatement(str);

			stmt.setString(1, ssn);
			ResultSet emp = stmt.executeQuery();
			
			if (emp.next()) { %>
				<%@ include file="../header.jsp" %>
				<% 
					String fname = emp.getString("first_name");
					String lname = emp.getString("last_name");
					String username = emp.getString("username");
					String password = emp.getString("password");
				%>
				<div class="container mx-auto" style="width: 800px;">
					<br>
					<div class="text-right">
						<a href="employees.jsp">Manage Employees</a>
					</div>
					<div class="card">
						<div class="card-body">
						<h3 class="display-4 text-center">Edit Employee Information</h3>
						<div class="text-muted text-center">Employee SSN: <%= ssn %></div>
						<br>
						<form action="update.jsp" method="post">
						  <input type="hidden" name="ssn" value="<%= ssn %>">
						  <div class="form-group">
						  	<div class="form-row">
						  		<div class="col">
						  		  <label for="firstname">First Name</label>
							      <input 
							      	type="text"
							      	name="firstname" 
							      	class="form-control" 
							      	id="firstnameInput" 
							      	placeholder="First name" 
							      	required 
							      	value="<%= fname %>">
							      <small class="form-text text-muted">
						  			25 characters max.
						  		  </small>
							    </div>
							    <div class="col">
							      <label for="lastname">Last Name</label>
							      <input 
							      	type="text" 
							      	name="lastname" 
							      	class="form-control" 
							      	id="lastnameInput" 
							      	placeholder="Last name" 
							      	required
							      	value="<%= lname %>">
							      <small class="form-text text-muted">
						  			25 characters max.
						  		  </small>
							    </div>
						  	</div>
						  </div>
						  <div class="form-group">
						    <label for="username">Username</label>
						    <input 
						    	type="text" 
						    	name="username" 
						    	class="form-control" 
						    	id="usernameInput" 
						    	placeholder="Enter Username" 
						    	required
						   		value="<%= username %>">
						    <small class="form-text text-muted">
						  		20 characters max.
						  	</small>
						  </div>
						  <div class="form-group">
						    <label for="password">Password</label>
						    <input 
						    	type="password" 
						    	name="password" 
						    	class="form-control" 
						    	id="passwordInput" 
						    	placeholder="Enter Password" 
						    	required
						    	value="<%= password %>">
						    <small class="form-text text-muted">
						  		20 characters max.
						  	</small>
						  </div>
						  <div class="form-group">
						  	<input class="btn btn-success btn-lg btn-block" type="submit" value="Update">
						  </div>
						</form>	
						</div>
					</div>
				</div>
			<%
			} else {
			%> 
			<div class="container">
				<div class="alert alert-warning">
					That user doesn't exist <a href="employees.jsp">Back To Employees Page</a>
				</div>
			</div>
			<%
			}
			emp.close();
			stmt.close();
			con.close();
		} else { %>
			<div class="container">
				<div class="alert alert-warning">
					You do not have permissions to view this page. <a href="../index.jsp">Home</a>
				</div>
			</div>
	<%  }		
	} catch (Exception e) { %>
		<div class="container">
			<div class="alert alert-warning">
				Oops! Something went wrong. <a href="employees.jsp">Back To Employees Page</a>
			</div>
		</div>
	<% } %>
</body>
</html>
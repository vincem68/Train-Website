<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../head.jsp" %>
</head>
<style>
	.nav-item {
		margin: 0px 5px;
	}
</style>
<body>
	
	<% try {
		if (session.getAttribute("loggedIn") == null || !((Boolean)session.getAttribute("loggedIn"))) {
			response.sendRedirect("../login.jsp");
		} else if (session.getAttribute("isAdmin") != null && (Integer)session.getAttribute("isAdmin") == 1){ %>
			<%@ include file="../header.jsp" %>
			
			<%  
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				
				Statement getEmployees = con.createStatement();
				
				ResultSet emp = getEmployees.executeQuery("select * from Employees where isadmin = 0 order by last_name asc");
			%>
			<% if (session.getAttribute("updatedEmployee") != null) { %>
				<div class="container">
					<div class="alert alert-success">
						Employee <% out.print((String)session.getAttribute("updatedEmployee")); %> successfully updated!
						<% session.setAttribute("updatedEmployee", null); %>
					</div>
				</div>
			<% } %>
			<% if (session.getAttribute("deletedEmployee") != null) { %>
				<div class="container">
					<div class="alert alert-danger">
						Employee <% out.print((String)session.getAttribute("deletedEmployee")); %> was deleted!
						<% session.setAttribute("deletedEmployee", null); %>
					</div>
				</div>
			<% } %>
			<% if (emp.next()) { %>
				<div class="container mt-3">
					<ul class="nav">
					  <li class="nav-item">
					    <a href="../manage/dashboard.jsp">Manager Dashboard</a>
					  </li>
					  <li class="nav-item">
					    <a href="../manage/reservations.jsp">See Reservations</a>
					  </li>
					  <li class="nav-item">
					  	<a href="../manage/report.jsp">Sales Report</a>
					  </li>
					</ul>
					<div class="text-right">
						<a href="register.jsp">Register an Employee</a>
					</div>
					<div class="card">
						<div class="card-body">
							<h1>Customer Representatives</h1>
							<ul class="list-group">
							<% do {
								String fname = emp.getString("first_name");
								String lname = emp.getString("last_name");
								String ssn = emp.getString("ssn");
								String username = emp.getString("username");
							%>
								  <li class="list-group-item">
								  	<div class="row">
									  	<div class="text-muted form-text col-6">
									  		 <%= ssn %>
									  	</div>
								  		<div class="col-6 text-right">
								  			<div class="btn-group">
									  		<form action="edit.jsp" method="post">
									 			<input type="hidden" name="ssn" value="<%= ssn %>">
									 			<input type="submit" value="edit" class="btn btn-success">
									 		</form>
									 		<form action="delete.jsp" method="post">
									 			<input type="hidden" name="ssn" value="<%= ssn %>">
									 			<input type="submit" value="delete" class="btn btn-danger">
									 		</form>
									 		</div>
								  		</div>
								  		<div class="col-12">
								  			<hr>
									  		<strong>Username:</strong> <%= username %>
									  		<br>
								 			<strong>Name (Last, First):</strong> <%= lname %>, <%= fname %>
								 		</div>
								 	</div>
								 	
								  </li>
							<% } while (emp.next()); %>
							</ul>
						</div>
					</div>
				
			<% } else { %>
				<div class="container">
					<div class="alert alert-warning">
						No customer representatives. <a href="employeeRegister.jsp">Register an Employee</a>
					</div>
				</div>
			<% } %>
			
			<% 
			 	emp.close();
				getEmployees.close();
				con.close();
			%>
			</div>
		<% } else { %>
			<div class="container">
				<div class="alert alert-warning">
					You do not have permissions to view this page. <a href="../index.jsp">Home</a>
				</div>
			</div>
		<% }
		
	} catch (Exception e) {
		 	out.print(e);
	 } %>
</body>
</html>
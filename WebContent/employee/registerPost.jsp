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
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			PreparedStatement stmt = null;
			
			//Get the selected radio button from the index.jsp
			String fname = request.getParameter("firstname");
			String lname = request.getParameter("lastname");
			String ssn = request.getParameter("ssn");
			String username = request.getParameter("username");
			String password = request.getParameter("password");

			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM Employees where username = ?";
			stmt = con.prepareStatement(str);
			//Run the query against the database.
			stmt.setString(1, username);
			ResultSet result = stmt.executeQuery();
			
			if (result.first()) { %>
				<div class="container">
					<div class="alert alert-warning">
						An account with that username already exists. <a href="register.jsp">Back To Register</a> 
					</div>
				</div>
			<%
			} else {
				try {
					String insert = "INSERT INTO Employees(ssn, first_name, last_name, username, password, isAdmin) ";
					insert += "VALUES (?, ?, ?, ?, ?, 0)";
					stmt = con.prepareStatement(insert);
					
					stmt.setString(1, ssn);
					stmt.setString(2, fname);
					stmt.setString(3, lname);
					stmt.setString(4, username);
					stmt.setString(5, password);
					
					stmt.executeUpdate();
					stmt.close();
					
					response.sendRedirect("employees.jsp");
				} catch (Exception e) { 
					if (e.toString().contains("Duplicate entry")) {

						%> 
						<div class="container">
							<div class="alert alert-warning">
								An account with this social security number exists. <a href="register.jsp">Back To Register</a> 
							</div>
						</div>
						<%
					} else {
						out.print(e);
						%>
						
						<div class="container">
							<div class="alert alert-warning">
								Oops! Something went wrong. <a href="register.jsp">Back To Register</a> 
							</div>
						</div>
						<%
					}
				}
			 }
			result.close();
			con.close();
		%>
		
			
		<%} catch (Exception e) {
			%>
			<div class="container">
				<div class="alert alert-warning">
					Oops! Something went wrong. <a href="register.jsp">Back To Register</a> 
				</div>
			</div>
		<% } %>
</body>
</html>
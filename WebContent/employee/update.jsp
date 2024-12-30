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
			String str = "SELECT * FROM Employees where username = ? and ssn != ?";
			stmt = con.prepareStatement(str);
			//Run the query against the database.
			stmt.setString(1, username);
			stmt.setString(2, ssn);
			ResultSet result = stmt.executeQuery();

			if (result.first()) { %>
				<div class="container">
					<div class="alert alert-warning">
						Another account with that username already exists. <a href="edit?ssn=<%= ssn %>">Back To Edit Form</a> 
					</div>
				</div>
			<%
			} else {
				try {
					String update = "UPDATE Employees set username = ?, first_name = ?, last_name = ?, password = ? WHERE ssn = ? ";
					stmt = con.prepareStatement(update);
					
					stmt.setString(1, username);
					stmt.setString(2, fname);
					stmt.setString(3, lname);
					stmt.setString(4, password);
					stmt.setString(5, ssn);
					
					stmt.executeUpdate();
					stmt.close();
					
					session.setAttribute("updatedEmployee", ssn);
				 	response.sendRedirect("employees.jsp");
				} catch (Exception e) {
					out.print(e);
					%>
					<div class="container">
						<div class="alert alert-warning">
							Oops! Something went wrong. <a href="edit?ssn=<%= ssn %>">Back To Edit Form</a> 
						</div>
					</div>
					<%
				}
			}
			result.close();
			con.close();
		%>
		
			
		<%} catch (Exception e) {
			%>
			<div class="container">
				<div class="alert alert-warning">
					Oops! Something went wrong. <a href="employees.jsp">Back To Employees Page</a> 
				</div>
			</div>
		<% } %>
</body>
</html>
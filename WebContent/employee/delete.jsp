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
			
			
			String ssn = request.getParameter("ssn");

			String str = "DELETE FROM Employees where ssn = ?";
			stmt = con.prepareStatement(str);

			stmt.setString(1, ssn);
			stmt.executeUpdate();
			
			session.setAttribute("deletedEmployee", ssn);
			response.sendRedirect("employees.jsp");
		
			
		} catch (Exception e) {
			%>
			<div class="container">
				<div class="alert alert-warning">
					Oops! Something went wrong. <a href="employees.jsp">Back To Employees Page</a> 
				</div>
			</div>
		<% } %>
</body>
</html>
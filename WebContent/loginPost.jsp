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
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			PreparedStatement stmt = null;
			//Get the selected radio button from the index.jsp
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM Customers where username= ? AND password= ?";
			stmt = con.prepareStatement(str);
			stmt.setString(1, username);
			stmt.setString(2, password);
			//Run the query against the database.
			ResultSet result = stmt.executeQuery();
						
			if (result.first()) {
				session.setAttribute("loggedIn", true);
				session.setAttribute("username", result.getString("username"));
				session.setAttribute("email", result.getString("email_address"));
				session.setAttribute("firstname", result.getString("first_name"));
				session.setAttribute("lastname", result.getString("last_name"));
				
				response.sendRedirect("index.jsp");
			} else { %>
				<div class="container">
					<div class="alert alert-warning"> 
						Username/password incorrect. Please try again. 
						<a href="login.jsp">Back to Login.</a>
					</div>
				</div>
			<% }
			
			db.closeConnection(con);
			
		%>
		
			
		<%} catch (Exception e) {
			out.print(e);
		} %>
</body>
</html>
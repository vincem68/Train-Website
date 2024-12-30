<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Registration</title>
</head>
<body>
<%try {
		ApplicationDB db= new ApplicationDB();
		Connection con= db.getConnection();
		String email = request.getParameter("email");
		String user = request.getParameter("username");
		String pw = request.getParameter("password");
		String firstName= request.getParameter("fname");
		String lastName= request.getParameter("lname");
		String verifyEmail = "SELECT * FROM Customers WHERE email_address = ?";
		PreparedStatement ps1 = con.prepareStatement(verifyEmail);
		ps1.setString(1, email);
		ResultSet result1=ps1.executeQuery();
		if(result1.first()==false){
			String verifyUser = "SELECT * FROM Customers WHERE username = ?";
			PreparedStatement ps2 = con.prepareStatement(verifyUser);
			ps2.setString(1, user);
			ResultSet result2=ps2.executeQuery();
			if(result2.first()==false){
				PreparedStatement newTuple= con.prepareStatement("INSERT INTO Customers (email_address, username, password, first_name, last_name) VALUES (?, ?, ?, ?, ?)");
				newTuple.setString(1, email);
				newTuple.setString(2, user);
				newTuple.setString(3, pw);
				newTuple.setString(4, firstName);
				newTuple.setString(5, lastName);
				newTuple.executeUpdate();
				response.sendRedirect("registerSuccess.jsp");
			}
			else
				response.sendRedirect("registerFailed.jsp");
		}
		else
			response.sendRedirect("registerFailed.jsp");
		con.close();
	}
	catch (Exception error){
		out.print(error);
	}
	%>
</body>
</html>
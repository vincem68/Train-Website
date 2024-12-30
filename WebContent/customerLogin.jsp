<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html>
<html>
<head>
<title>Customer Login</title>
</head>
<body>
	<%
		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			String user = request.getParameter("username");
			String pw = request.getParameter("password");
			String verify = "SELECT * FROM Customers WHERE username= ? AND password = ?";
			PreparedStatement ps = con.prepareStatement(verify);
			ps.setString(1, user);
			ps.setString(2, pw);
			ResultSet result = ps.executeQuery();
			if (result.first()) {
				session.setAttribute("active", true);
				session.setAttribute("firstname", result.getString("first_name"));
				session.setAttribute("lastname", result.getString("last_name"));
				session.setAttribute("email", result.getString("email_address"));
				response.sendRedirect("customerLoginSuccess.jsp");
			} else {
				response.sendRedirect("loginFailed.jsp");
			}
			db.closeConnection(con);
		} catch (Exception error) {
			out.print(error);
		}
	%>

</body>
</html>
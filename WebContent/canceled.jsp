<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>


<html>
 <head><title>Order Canceled</title></head>
 
 <body>
 
 	<%
 		try {
 			ApplicationDB app = new ApplicationDB();
 			Connection c = app.getConnection();
 			Statement state = c.createStatement();
 			
 			
 			String check2 = "SELECT * FROM Reservations WHERE reservation_number = ?";
 			
 			String number = request.getParameter("reservation_number");
 			PreparedStatement hey = c.prepareStatement(check2);
 			hey.setString(1, number);
 			ResultSet r = hey.executeQuery();
 			
 			if (!(r.first())){
 				response.sendRedirect("invalidCancel.jsp");
 			}
 			else {
 			
	 			String check = "DELETE FROM Reservations WHERE reservation_number = ?";
	 			
	 			PreparedStatement p = c.prepareStatement(check);
	 			p.setString(1, number);
	 			
	 			p.executeUpdate();
	 			
				out.print("Your order has been successfully canceled.");
				%>
				<br>
				<form method = "get" action = "schedules.jsp">
					<input type = "submit" value = "Return to Reservation Page">
				</form>
 				<%
 			}
 			
 			app.closeConnection(c);
 		}
 		
 		catch (Exception uhOh){
 			out.print(uhOh);
 		}
 	%>
 
 </body>

 
 </html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>

<html>



	<head><title>Reservation Management</title></head>
<body>
	<h1>Here are your reservations</h1>
	<br>
	
	<%
		try {
			ApplicationDB app = new ApplicationDB();
			Connection c = app.getConnection();
			Statement s = c.createStatement();
			
			String email = (String)session.getAttribute("email"); //out.print(email);
			String check = "SELECT DISTINCT r.reservation_number, r.origin, r.destination, r.total_fare, r.passenger, r.reserved_on, r.schedule_id "+
					"FROM Reservations r, ScheduledStops s "+
					"WHERE r.schedule_id = s.schedule_id AND r.email_address = ? AND NOW() < s.departure_time";
			PreparedStatement p = c.prepareStatement(check);
			p.setString(1, email);
			ResultSet r = p.executeQuery();
			
			
		
				%> 
				<table border = 3>
					<tr>
						<th>Reservation Number</th>
						<th>Origin</th>
						<th>Destination</th>
						<th>Total Fare</th>
						<th>Passenger</th>
						<th>Date Reserved</th>
						<th>Schedule ID</th>
					</tr>
					<% while (r.next()) {
						%>
						<tr>
							<td><%= r.getString("reservation_number") %></td>
						    <td><%= r.getString("origin") %></td>
							<td><%= r.getString("destination") %></td>
							<td><%= r.getString("total_fare") %></td>
							<td><%= r.getString("passenger") %></td>
							<td><%= r.getString("reserved_on") %></td>
							<td><%= r.getString("schedule_id") %></td>
						</tr>
			<% 		} %>
						
				</table>
				<%
			
			c.close();
			
		}
		catch (Exception uhOh){
			out.print(uhOh);
		}
	%>
	
	Type in the number of the reservation you want to cancel below
	<br>
	(You can only cancel one at a time)
	<form method = "post" action= "canceled.jsp">
		<input type = "text" name = "reservation_number">
		<input type = "submit" value = "Cancel">
	</form>
	
	<br>
	
	<form method = "get" action = "schedules.jsp">
		<input type = "submit" value = "Go Back">
	</form>
</body>

</html>
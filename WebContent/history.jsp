<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>

<html>


<head><title>Customer History</title></head>

<body>

	<%
		try {
			ApplicationDB app = new ApplicationDB();
			Connection c = app.getConnection();
			Statement s = c.createStatement();
			
			String email = (String)session.getAttribute("email");
			String check = "SELECT DISTINCT r.reservation_number, r.origin, r.destination, r.total_fare, r.passenger, r.reserved_on, r.schedule_id "+
					"FROM Reservations r, ScheduledStops s "+
					"WHERE r.schedule_id = s.schedule_id AND r.email_address = ? AND NOW() < s.departure_time";
			PreparedStatement p = c.prepareStatement(check);
			p.setString(1, email);
			
			//put here where to get the email
			
			ResultSet r = p.executeQuery();
			%>
			
			<br>
			<h3>These are your current reservations:</h3>
			<br>
			<table border = 3>
				<tr>
					<th>Reservation Number</th>
					<th>Origin</th>
					<th>Destination</th>
					<th>Total Fare</th>
					<th>Passenger</th>
					<th>Reserved On</th>
					<th>Schedule_id</th>
				</tr>
				<%
					while (r.next()) { %>
				<tr> 
					<td><%= r.getString("reservation_number") %></td>
					<td><%= r.getString("origin") %></td>
					<td><%= r.getString("destination") %></td>
					<td><%= r.getString("total_fare") %></td>
					<td><%= r.getString("passenger") %></td>
					<td><%= r.getString("reserved_on") %></td>
					<td><%= r.getString("schedule_id") %></td>
					
				</tr>
				<% 
					}
				
				%> 
				
			
			</table>
			<br>
			
			<% r.close();
			String check2 = "SELECT DISTINCT r.reservation_number, r.origin, r.destination, r.total_fare, r.passenger, r.reserved_on, r.schedule_id "+
					"FROM Reservations r, ScheduledStops s "+
					"WHERE r.schedule_id = s.schedule_id AND r.email_address = ? AND NOW() > s.departure_time";
					
			PreparedStatement p2 = c.prepareStatement(check2);
			p2.setString(1, email);
			ResultSet r2 = p2.executeQuery();
			
		    %>
			
			<br>
			<h3>These are your past reservations:</h3>
			<br>
			<table border = 3>
				<tr>
					<th>Reservation Number</th>
					<th>Origin</th>
					<th>Destination</th>
					<th>Total Fare</th>
					<th>Passenger</th>
					<th>Reserved On</th>
					<th>Schedule_id</th>
				</tr>
				<%
					while (r2.next()) { %>
				<tr> 
					<td><%= r2.getString("reservation_number") %></td>
					<td><%= r2.getString("origin") %></td>
					<td><%= r2.getString("destination") %></td>
					<td><%= r2.getString("total_fare") %></td>
					<td><%= r2.getString("passenger") %></td>
					<td><%= r2.getString("reserved_on") %></td>
					<td><%= r2.getString("schedule_id") %></td>
					<!-- I put email address here just in case -->
				</tr>
				<% 
					}
				
				%> 
				
			
			</table>
			<br>
			
			<% r2.close();
					
			c.close();
		}
		
		catch (Exception uhOh){
			out.print(uhOh);
		}
	%>




	<br>
	<form method = "get" action = "schedules.jsp">
		<input type = "submit" value = "Back To Reservations">
	</form>

</body>
</html>

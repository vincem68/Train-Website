<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>

<html>

<head><title>Scheduled Stops</title></head>

<body>

	<h3>Here are the scheduled stops associated with your chosen schedule</h3>
	
	<%
		try {
			ApplicationDB app = new ApplicationDB();
			Connection c = app.getConnection();
			Statement s = c.createStatement();
			
			
			String idnumber = request.getParameter("id");
			String check2 = "SELECT * FROM Schedules WHERE schedule_id = ? and NOW() < departure_date";
			PreparedStatement p2 = c.prepareStatement(check2);
			p2.setString(1, idnumber);
			ResultSet r2 = p2.executeQuery();
			
			if (!(r2.first())){
				response.sendRedirect("invalidOrder.jsp");
			}
			else {
			
			
			
			String check = "SELECT s.schedule_id, s.transit_name, s.station_id, t.name, s.arrival_time, s.departure_time " +
					"FROM ScheduledStops s, Stations t " +
					"WHERE s.station_id = t.station_id AND s.schedule_id = ? ORDER BY s.departure_time";
			PreparedStatement p = c.prepareStatement(check);
			p.setString(1, idnumber);
			ResultSet r = p.executeQuery();
			
			//maybe have another query here to check if ID is good
			
            %>
			
			<table border = 3>
			
				<tr>
					<th>Schedule ID</th>
					<th>Transit Name</th>
					<th>Station ID</th>
					<th>Station Name</th>
					<th>Arrival Date</th>
					<th>Departure Time</th>
				</tr>
				
				<% while (r.next()) { %> <!-- I don't know if we need the alias -->
						<tr>
							<td><%= r.getString("schedule_id") %></td>
							<td><%= r.getString("transit_name") %></td>
							<td><%= r.getString("station_id") %></td>
							<td><%= r.getString("name") %></td>
							<td><%= r.getString("arrival_time") %></td>
							<td><%= r.getString("departure_time") %></td>
						</tr>
					<%
				}
			
			%>
			</table>
			<% 
			}
			c.close();
		}
		catch (Exception uhOh) {
			out.print(uhOh);
		}
	%>
	
	<br>
	<h3>Enter below the desired origin and destination stations from the stops above</h3>
	
	<br>
	
	<form method = "post" action = "reserved.jsp"> <!-- remember to know of get is good -->
		To ensure no errors, enter again the Schedule ID from the resulting stops:<input type = "text" name = "id">
		<br>
		Enter the Station ID of the origin station:<input type = "text" name = "origin">
		<br>
		Enter the Station ID of the destination station:<input type = "text" name = "destination">
		<br>
		Enter the name of the passenger for this reservation:<input type = "text" name = "passname">
		
		<br>
		<h3>What kind of trip are you planning?</h3>
		<br>
		<select name  = "trip">
			<option value = "one_way">One-way Trip</option>
			<option value = "round">Round-Trip</option>
		</select>
		<br>
		
		<h3>Please select your current status below:</h3>
		<br>
		<input type = "radio" name = "status" value = "adult">Adult
		<br>
		<input type = "radio" name = "status" value = "child">Child
		<br>
		<input type = "radio" name = "status" value = "senior">Senior
		<br>
		<input type = "radio" name = "status" value = "disabled">Disabled
		<br>
		<input type = "submit" value = "Confirm Reservation">
	</form>
	
	
	
	
	<br>
	
	<form method = "get" action = "reservation.jsp">
		<input type = "submit" value = "Choose a Different Schedule">
	</form>
	
</body>

</html>
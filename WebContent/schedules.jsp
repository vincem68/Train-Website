<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
 
<html>

<head><title>Schedules</title></head>
<%@ include file="head.jsp" %>
<body>
	<%@ include file="header.jsp" %>
	<div class="container-fluid">
	<h1>Ready to get on a trip? Take a look at what schedules we got:</h1>

	<br>
		<%
			try {
				ApplicationDB app = new ApplicationDB();
				Connection c = app.getConnection();
				Statement s = c.createStatement();
				
				String check = "SELECT s.schedule_id, s.transit_name, " +
						"s.arrival_date, s.departure_date, s.fare, st.station_id, st.name, ss.arrival_time, ss.departure_time " +
						"FROM Schedules s, ScheduledStops ss, Stations st " +
						"WHERE s.schedule_id = ss.schedule_id AND ss.station_id = st.station_id AND s.departure_date > NOW()"+
						"ORDER BY s.schedule_id, ss.arrival_time";
				PreparedStatement p = c.prepareStatement(check);
				ResultSet r = p.executeQuery();
				
				%>
				
				<table border = 3>
				
					<tr>
						<td>Schedule ID</td>
						<td>Transit Name</td>
						<td>Arrival Date</td>
						<td>Departure Date</td>
						<td>Fare</td>
						<td>Station ID></td>
						<td>Station Stop</td>
						<td>Station Arrival Time</td>
						<td>Station Departure Time</td>
					</tr>
					
					<% while (r.next()) { %> <!-- I don't know if we need the alias -->
							<tr>
								<td><%= r.getString("schedule_id") %></td>
								<td><%= r.getString("transit_name") %></td>
								<td><%= r.getString("arrival_date") %></td>
								<td><%= r.getString("departure_date") %></td>
								<td><%= r.getString("fare") %></td>
								<td><%= r.getString("station_id") %></td>
								<td><%= r.getString("name") %></td>
								<td><%= r.getString("arrival_time") %></td>
								<td><%= r.getString("departure_time") %></td>
							</tr>
						<%
					}
				
				%>
				</table>
				<% r.close();
				c.close();
			}
		   catch (Exception uhOh) {
			   out.print(uhOh);
		   }
		%> 
		
	<br>
	Got a question that needs answering?
	<a href=qaCustomers.jsp>Browse and Ask Q&A Board</a>
	<br>
	
	Know where you're heading? Search a trip by origin, destination, and date:
	
	<form method = "post" action = "searched.jsp">
			<br>
			Enter Origin station:
			<br>
			<input type = "text" name = "originStation" required>
			<br>
			Enter Destination Station:
			<br>
			<input type = "text" name = "destinationStation" required>
			<br>
			Enter Date of Travel (MM-DD):
			<br> 
			<input type = "text" name = "date">
			<br>
			<input type = "submit" value ="Search">
			
	</form>
	
	<br>
	
	Undecided? Browse all our current trips. Sort by the following:
	<br>
	<form method = "get" action = "sorted.jsp">
		<select name = "sort">
			<option value = "arrival_date"> By Arrival Time </option>
			<option value = "departure_date"> By Departure Time </option>
			<option value = "fare"> By Fare </option>
		
		</select>
		<br> 
		<input type = "submit" value = "Submit">
	</form>
	
	<br>
	Know where you want to go? Time to make a reservation:
	<br>
	<form method = "get" action = "reservation.jsp">
		<input type = "submit" value = "Make Reservation">
	</form>
	
	<br>
	Have to cancel current trips? 
	<br>
	<form method = "get" action = "cancel.jsp">
		<input type = "submit" value = "Click Here">
	</form>
	<br>
	
	Click here to see your reservation history.
	
	<form method = "get" action = "history.jsp">
		<input type = "submit" value = "History">
	</form>
	
	<br>
	<form method = "get" action = "logout.jsp">
		<input type = "submit" value = "Logout">
	</form>
	</div>
	  <!-- put the home page here -->
</body>

</html>
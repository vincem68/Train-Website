<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>

<html>

<head><title>Sorted Schedule</title></head>

<body>

	<%
		try {
			ApplicationDB app = new ApplicationDB();
			Connection c = app.getConnection();
			Statement state = c.createStatement();
			
			String the_order = request.getParameter("sort");
			
			String check = 
					"SELECT s.schedule_id, s.transit_name, " +
							"s.arrival_date, s.departure_date, s.fare, st.name, ss.arrival_time, ss.departure_time " +
							"FROM Schedules s, ScheduledStops ss, Stations st " +
							"WHERE s.schedule_id = ss.schedule_id AND ss.station_id = st.station_id AND s.departure_date > NOW()";
							
			
			// right now this is just ordering them without taking away anything. 
	        if (the_order.equals("fare")){
	        	check += " ORDER BY s.fare ASC";
	        }
	        else if (the_order.equals("departure_date")){
	        	check += " ORDER BY s.departure_date ASC";
	        }
	        else {
	        	check += " ORDER BY s.arrival_date ASC";
	        }
	        PreparedStatement hold = c.prepareStatement(check);
	        ResultSet r = hold.executeQuery();
	        
	        
	    	%>
			
			<table border = 3>
			
				<tr>
					<th>Schedule ID</th>
					<th>Transit Name</th>
					<th>Arrival Date</th>
					<th>Departure Date</th>
					<th>Fare</th>
					<th>Station Stop</th>
					<th>Station Arrival Time</th>
					<th>Station Departure Time</th>
				</tr>
				
				<% while (r.next()) { %> <!-- I don't know if we need the alias -->
						<tr>
							<td><%= r.getString("schedule_id") %></td>
							<td><%= r.getString("transit_name") %></td>
							<td><%= r.getString("arrival_date") %></td>
							<td><%= r.getString("departure_date") %></td>
							<td><%= r.getString("fare") %></td>
							<td><%= r.getString("name") %></td>
							<td><%= r.getString("arrival_time") %></td>
							<td><%= r.getString("departure_time") %></td>
						</tr>
					<%
				}
			
			%>
			</table>
			<% 

	     
	        c.close();
		}
	
	 catch (Exception uhOh){
		 out.print(uhOh);
	 }
	
	
	%>
	
	<br>
	
	Know where you're heading? Search a trip by origin, destination, and date:
	
	<form method = "post" action = "searched.jsp">
			<br>
			Enter Origin station:
			<br>
			<input type = "text" name = "originStation">
			<br>
			Enter Destination Station:
			<br>
			<input type = "text" name = "destinationStation">
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
	<form method = "get" action = "logout2.jsp">
		<input type = "submit" value = "Logout">
	</form>
     <!-- original -->
     <!--  
	<br>
	<form method = "get" action = "schedules.jsp">
		<input type = "submit" value = "Go Back to Schedule Searching">
	</form>
	<br>
	Ready to make a reservation?
	<form method = "get" action = "reservation.jsp">
		<input type = "submit" value = "Click here">
	</form>
	<br> -->
</body>

</html>
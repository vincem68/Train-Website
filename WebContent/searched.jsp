<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>

<html>

<head><title>Searched Schedules</title></head>

<body>       

	<%
		try {
			ApplicationDB app = new ApplicationDB();
			Connection c = app.getConnection();
			Statement state = c.createStatement();
			
			String a = request.getParameter("originStation");
			String b = request.getParameter("destinationStation");
			String time = request.getParameter("date");
			String part = "AND s.departure_date LIKE '%" + time + "%'";
			
			
			
			
			
			String check2 = "SELECT s.schedule_id, t1.departure_time AS the_origin, t2.arrival_time AS the_destination " +
					"FROM (select s.schedule_id, u.departure_time FROM Schedules s, Stations t, ScheduledStops u " +
						    "WHERE s.schedule_id = u.schedule_id AND u.station_id = t.station_id AND t.name = ?) t1, " +
						    "(SELECT s.schedule_id, u.arrival_time FROM Schedules s, Stations t, ScheduledStops u " +
						    "WHERE s.schedule_id = u.schedule_id AND u.station_id = t.station_id AND t.name = ?) t2, Schedules s " +
						"WHERE t2.schedule_id = t1.schedule_id AND s.schedule_id = t1.schedule_id AND s.schedule_id = t2.schedule_id " + part;
			
			PreparedStatement p3 = c.prepareStatement(check2);
			p3.setString(1, a); p3.setString(2, b);
			ResultSet r3 = p3.executeQuery();
			if (!(r3.first())) {
				response.sendRedirect("invalidSearch.jsp");
			}
			else {
			r3.close(); p3.close();
			String check = "SELECT s.schedule_id, t1.departure_time AS the_origin, t2.arrival_time AS the_destination " +
					"FROM (select s.schedule_id, u.departure_time FROM Schedules s, Stations t, ScheduledStops u " +
						    "WHERE s.schedule_id = u.schedule_id AND u.station_id = t.station_id AND t.name = ?) t1, " +
						    "(SELECT s.schedule_id, u.arrival_time FROM Schedules s, Stations t, ScheduledStops u " +
						    "WHERE s.schedule_id = u.schedule_id AND u.station_id = t.station_id AND t.name = ?) t2, Schedules s " +
						"WHERE t2.schedule_id = t1.schedule_id AND s.schedule_id = t1.schedule_id AND s.schedule_id = t2.schedule_id " + part;
			//out.println(check);
			
			PreparedStatement p = c.prepareStatement(check);
			p.setString(1, a); p.setString(2, b); //p.setString(3, time);
			
			ResultSet r = p.executeQuery();
			
			ArrayList<String> ids = new ArrayList<String>();
			while (r.next()){
				String hold = r.getString("schedule_id");
				ids.add(hold);
				String hold2 = r.getString("the_origin");
				ids.add(hold2);
				String hold3 = r.getString("the_destination");
				ids.add(hold3);
			}
			
			r.close(); p.close();
			
			%> <h3>Here are schedules that contain your planned route:</h3>
			<br>
			<%
			
			while (ids.size() != 0){
				String make = "SELECT * FROM ScheduledStops WHERE schedule_id = ? AND departure_time >= ? AND arrival_time <= ? ORDER BY departure_time";
				PreparedStatement p2 = c.prepareStatement(make);
				p2.setString(1, ids.get(0)); p2.setString(2, ids.get(1)); p2.setString(3, ids.get(2));
				
				ResultSet r2 = p2.executeQuery(); 
				%> 
				<table border = 3>
					<br> 
					<tr>
						<th>Schedule ID</th>
						<th>Transit Name</th>
						<th>Station ID</th>
						<th>Arrival Time</th>
						<th>Departure Time</th>
					</tr>
					<% while (r2.next()) { %>
					<tr>
						<td><%= r2.getString("schedule_id") %></td>
						<td><%= r2.getString("transit_name") %></td>
						<td><%= r2.getString("station_id") %></td>
						<td><%= r2.getString("arrival_time") %></td>
						<td><%= r2.getString("departure_time") %></td>
					</tr>
					<% } %>
				</table> <br> <% 
				r2.close(); p2.close();
				ids.remove(2); ids.remove(1); ids.remove(0);
			}
			}
			
			c.close();
			
		
			
		}
		catch (Exception uhOh) {
			out.print(uhOh);
		}
	%>
	

	<br>
	<form method = "get" action = "reservation.jsp">
		Ready to make a reservation?
		<br>
		<input type = "submit" value = "Book a trip">
	</form>
	<br>
	Not what you're looking for? Go back to search again:
	<br>
	<form method = "get" action = "schedules.jsp">
		<input type = "submit" value = "Return to Home">
	</form>

</body>

</html>
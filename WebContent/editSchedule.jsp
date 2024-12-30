<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Schedules</title>
</head>
<body> 
Edit Schedule Origin Departure Times, Destination Arrival Times, Trains, and/or Fare
<br>
	<form action="editScheduleProcess.jsp" method="post">
	Schedule ID: <input type="text" name="scheduleID" required> *Required Field<br>
		<br>
		*Fill in at least one field <br>
		Train ID: <input type="text" name="trainID"> <br>
		<br>
		*Time in YYYY-MM-DD HH:MM:SS Format <br>
		Origin Departure Time: <input type="text" name="originDeparture"> <br>
		Destination Arrival Time: <input type="text" name="destArrival"> <br>
		Fare (Enter in dollar amounts without the dollar sign): <input type="text" name="fare">
		<br> <input type="submit" value="Submit">
		</form>
		<br>
		<a href=editScheduleStop.jsp>Edit an Individual Stop</a>
		<br>
		<br>
		<a href=scheduleOperations.jsp>Return to Schedule Dashboard</a>
		<br>
	<br> Current Available Schedules
	<br>
	<table>
	<br>
	<tr bgcolor="#A52A2A">
		<td><b>Schedule ID</b></td>
		<td><b>Transit Line</b></td>
		<td><b>Train ID</b></td>
		<td><b>Origin Departure Time</b></td>
		<td><b>Destination Arrival Time</b></td>
		<td><b>Schedule Fare</b></td>
		<td><b>Station ID</b></td>
		<td><b>Station Name</b></td>
		<td><b>Arrival Time</b></td>
		<td><b>Departure Time</b></td>
	</tr>
	<%
		try {
			ApplicationDB app = new ApplicationDB();
			Connection con = app.getConnection();
			String scheduleInfo = "SELECT s.schedule_id, s.transit_name, s.train_id, s.departure_date, s.arrival_date, s.fare, stops.station_id, Stations.name, stops.arrival_time, stops.departure_time FROM Schedules s, ScheduledStops stops, Stations WHERE s.schedule_id=stops.schedule_id AND stops.station_id=Stations.station_id ORDER BY s.schedule_id, stops.arrival_time";
			PreparedStatement ps = con.prepareStatement(scheduleInfo);
			ResultSet result = ps.executeQuery();
			while (result.next()) {
	%>
	<tr bgcolor="#DEB887">
		<td><%=result.getString("schedule_id")%></td>
		<td><%=result.getString("transit_name")%></td>
		<td><%=result.getString("train_id")%></td>
		<td><%=result.getString("departure_date")%></td>
		<td><%=result.getString("arrival_date")%></td>
		<td><%=result.getString("fare")%></td>
		<td><%=result.getString("station_id")%></td>
		<td><%=result.getString("name")%></td>
		<td><%=result.getString("arrival_time")%></td>
		<td><%=result.getString("departure_time")%></td>
	</tr>
	<%
		}
			con.close();
		} catch (Exception error) {
			out.print(error);
		}
	%>
	</table>
</body>
</html>
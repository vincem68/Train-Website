<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Schedule Operations</title>
<%@ include file="head.jsp" %>
</head>
<body>
	<%@ include file="../header.jsp" %>
	Schedule Operations
	<br>
	<br>
	<form method="get" action="editSchedule.jsp">
		<input type="submit" value="Edit Schedules">
	</form>
	<br>
	<form method="get" action="addSchedule.jsp">
		<input type="submit" value="Add Schedules">
	</form>
	<br>
	<form method="get" action="deleteSchedule.jsp">
		<input type="submit" value="Delete Schedules">
	</form>
	<br>
	<br> Current Available Schedules
	<br>
	<table>
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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Schedule Lookup</title>
</head>
<body>
Station ID <%out.print(request.getParameter("stationID")+" as "+request.getParameter("stopType"));%>
<br>
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
			String scheduleInfo="";			
			if(request.getParameter("stopType").equals("origin")){
				scheduleInfo = "SELECT DISTINCT s.schedule_id, s.transit_name, s.train_id, s.departure_date, s.arrival_date, s.fare, stops.station_id, Stations.name, stops.arrival_time, stops.departure_time FROM (SELECT s.schedule_id, st.arrival_time FROM ScheduledStops st, Schedules s WHERE st.station_id=? AND st.schedule_id=s.schedule_id) AS Target, Schedules s, ScheduledStops stops, Stations WHERE stops.schedule_id=s.schedule_id AND s.schedule_id IN (Target.schedule_id) AND stops.station_id=Stations.station_id AND stops.arrival_time>=(SELECT Target.arrival_time WHERE Target.schedule_id=stops.schedule_id) ORDER BY stops.schedule_id, stops.arrival_time";
			}
			else{
				scheduleInfo = "SELECT DISTINCT s.schedule_id, s.transit_name, s.train_id, s.departure_date, s.arrival_date, s.fare, stops.station_id, Stations.name, stops.arrival_time, stops.departure_time FROM (SELECT s.schedule_id, st.arrival_time FROM ScheduledStops st, Schedules s WHERE st.station_id=? AND st.schedule_id=s.schedule_id) AS Target, Schedules s, ScheduledStops stops, Stations WHERE stops.schedule_id=s.schedule_id AND s.schedule_id IN (Target.schedule_id) AND stops.station_id=Stations.station_id AND stops.arrival_time<=(SELECT Target.arrival_time WHERE Target.schedule_id=stops.schedule_id) ORDER BY stops.schedule_id, stops.arrival_time";
			}
			PreparedStatement ps = con.prepareStatement(scheduleInfo);
			ps.setString(1, request.getParameter("stationID"));
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
	<a href=scheduleReservationLookup.jsp>Go back to Schedule/Reservation Lookup</a>
</body>
</html>
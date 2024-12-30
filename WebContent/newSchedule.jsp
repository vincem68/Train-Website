<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>New Schedule</title>
</head>
<body>
<%try {
		ApplicationDB db= new ApplicationDB();
		Connection con= db.getConnection();
		int scheduleID=1;
		String idQuery= "SELECT MAX(schedule_id) FROM Schedules";
		PreparedStatement ps1 = con.prepareStatement(idQuery);
		ResultSet max = ps1.executeQuery();
		if(max.first()==true){
			scheduleID=max.getInt(1)+1;
		}
		String trainID= request.getParameter("trainID");
		String transitLine = request.getParameter("transitLine");
		String stopQuery= "SELECT origin, destination FROM TransitLines WHERE transit_name=?";
		PreparedStatement ps2=con.prepareStatement(stopQuery);
		ps2.setString(1, transitLine);
		ResultSet stations= ps2.executeQuery();
		if(stations.first()==true){
		String origin= stations.getString(1);
		String destination= stations.getString(2);
		String originArrival= request.getParameter("originArrival");
		String originDeparture= request.getParameter("originDeparture");
		String destArrival= request.getParameter("destArrival");
		String destDeparture= request.getParameter("destDeparture");
		String fare= request.getParameter("fare");
		PreparedStatement newTuple= con.prepareStatement("INSERT INTO Schedules (schedule_id, train_id, departure_date, transit_name, arrival_date, fare) VALUES (?, ?, ?, ?, ?, ?)");
		newTuple.setString(1, Integer.toString(scheduleID));
		newTuple.setString(2, trainID);
		newTuple.setString(3, originDeparture);
		newTuple.setString(4, transitLine);
		newTuple.setString(5, destArrival);
		newTuple.setString(6, fare);
		newTuple.executeUpdate();
		PreparedStatement newTupleOrigin= con.prepareStatement("INSERT INTO ScheduledStops (schedule_id, transit_name, station_id, arrival_time, departure_time) VALUES (?, ?, ?, ?, ?)");
		newTupleOrigin.setString(1, Integer.toString(scheduleID));
		newTupleOrigin.setString(2, transitLine);
		newTupleOrigin.setString(3, origin);
		newTupleOrigin.setString(4, originArrival);
		newTupleOrigin.setString(5, originDeparture);
		newTupleOrigin.executeUpdate();
		PreparedStatement newTupleDest= con.prepareStatement("INSERT INTO ScheduledStops (schedule_id, transit_name, station_id, arrival_time, departure_time) VALUES (?, ?, ?, ?, ?)");
		newTupleOrigin.setString(1, Integer.toString(scheduleID));
		newTupleOrigin.setString(2, transitLine);
		newTupleOrigin.setString(3, destination);
		newTupleOrigin.setString(4, destArrival);
		newTupleOrigin.setString(5, destDeparture);
		newTupleOrigin.executeUpdate();
		response.sendRedirect("addScheduleSuccess.jsp");
		}
		else{
			response.sendRedirect("addStopFailure.jsp");
		}

		con.close();
	}
	catch (Exception error){
		out.print(error);
	}
	%>
</body>
</html>
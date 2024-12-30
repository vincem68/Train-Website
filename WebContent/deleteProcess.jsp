<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Process</title>
</head>
<body>
<%try {
		ApplicationDB db= new ApplicationDB();
		Connection con= db.getConnection();
		String scheduleID = request.getParameter("deleteID");
		String stationID = request.getParameter("deleteScheduleStation");
		if (stationID.isEmpty()){
			String deleteScheduledStops = "DELETE FROM ScheduledStops WHERE schedule_id= ?";
			PreparedStatement ps1=con.prepareStatement(deleteScheduledStops);
			ps1.setString(1, scheduleID);
			int deleted= ps1.executeUpdate();
			if(deleted==0){
				response.sendRedirect("deleteFailure.jsp");
			}
			String deleteSchedule = "DELETE FROM Schedules WHERE schedule_id= ?";
			PreparedStatement ps2=con.prepareStatement(deleteSchedule);
			ps2.setString(1, scheduleID);
			int deletedAgain=ps2.executeUpdate();
			response.sendRedirect("deleteSuccess.jsp");
		}
		else{
			String deleteSchedule = "DELETE FROM ScheduledStops WHERE schedule_id= ? AND station_id= ?";
			PreparedStatement ps1=con.prepareStatement(deleteSchedule);
			ps1.setString(1, scheduleID);
			ps1.setString(2, stationID);
			int deleted= ps1.executeUpdate();
			if(deleted==0){
				response.sendRedirect("deleteFailure.jsp");
			}
			response.sendRedirect("deleteSuccess.jsp");
		}
		con.close();
	}
	catch (Exception error){
		out.print(error);
	}
	%>
</body>
</html>
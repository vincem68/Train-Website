<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Schedule Stop Process</title>
</head>
<body>
<%try {
		ApplicationDB db= new ApplicationDB();
		Connection con= db.getConnection();
		int commaCheck=0;
		String scheduleID = request.getParameter("scheduleID");
		String stationID= request.getParameter("stationID");
		String arrivalTime= request.getParameter("arrival");
		String departureTime= request.getParameter("departure");
		String verifyStop= "SELECT * FROM ScheduledStops WHERE schedule_id= ? AND station_id=?";
		PreparedStatement ps1= con.prepareStatement(verifyStop);
		ps1.setString(1, scheduleID);
		ps1.setString(2, stationID);
		ResultSet check=ps1.executeQuery();
		if(check.first()==true){
			String editStatement = "UPDATE ScheduledStops SET ";
			String whereStatement= "WHERE schedule_id= "+scheduleID+" AND station_id= "+stationID;
			if(arrivalTime.isEmpty()==false){
				editStatement=editStatement+" arrival_time = '"+arrivalTime+"'";
				commaCheck=1;
			}
			if(departureTime.isEmpty()==false){
				if(commaCheck==1){
					editStatement=editStatement+",";
				}
				editStatement=editStatement+" departure_time= '"+departureTime+"'";
			}
			editStatement=editStatement+whereStatement;
			PreparedStatement ps2=con.prepareStatement(editStatement);
			ps2.executeUpdate();
			response.sendRedirect("editScheduleSuccess.jsp");
		}
		else response.sendRedirect("editScheduleFailure.jsp");
		con.close();
	}

	catch (Exception error){
		out.print(error);
	}
	%>
</body>
</html>
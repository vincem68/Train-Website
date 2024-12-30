<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Schedule Process</title>
</head>
<body>
<%try {
		ApplicationDB db= new ApplicationDB();
		Connection con= db.getConnection();
		int commaCheck=0;
		String scheduleID = request.getParameter("scheduleID");
		String trainID = request.getParameter("trainID");
		String originDeparture= request.getParameter("originDeparture");
		String destArrival= request.getParameter("destArrival");
		String fare= request.getParameter("fare");
		String editStatement= "UPDATE Schedules SET ";
		String whereStatement=" WHERE schedule_id= "+scheduleID;
		String verifySID= "SELECT * FROM Schedules WHERE schedule_iD= ?";
		PreparedStatement ps1=con.prepareStatement(verifySID);
		ps1.setString(1, scheduleID);
		ResultSet check=ps1.executeQuery();
		if(check.first()==true){
			if(trainID.isEmpty()==false){
				editStatement=editStatement+" train_id = "+trainID;
				commaCheck=1;
			}
			if(originDeparture.isEmpty()==false){
				if(commaCheck==1){
					editStatement=editStatement+",";
				}
				editStatement=editStatement+" departure_date= '"+originDeparture+"'";
				commaCheck=1;
			}
			if(destArrival.isEmpty()==false){
				if(commaCheck==1){
					editStatement=editStatement+",";
				}
				editStatement=editStatement+" arrival_date= '"+destArrival+"'";
				commaCheck=1;
			}
			if(fare.isEmpty()==false){
				if(commaCheck==1){
					editStatement=editStatement+",";
				}
				editStatement=editStatement+" fare= "+fare;
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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reservation Lookup</title>
</head>
<body>
Reservations for <%out.print(request.getParameter("transitLine")+" ");%> on <%out.print(request.getParameter("date"));%>
<br>
	<table>
	<tr bgcolor="#A52A2A">
		<td><b>Reservation Number</b></td>
		<td><b>Passenger</b></td>
		<td><b>Email Address used to Reserve</b></td>
	</tr>
<%try {
		ApplicationDB db= new ApplicationDB();
		Connection con= db.getConnection();
		String transitLine = request.getParameter("transitLine");
		String date = request.getParameter("date");
		String verifyStop= "SELECT r.* FROM Reservations r, Schedules s WHERE r.schedule_id=s.schedule_id AND s.transit_name=? AND CAST(s.departure_date AS DATE)=?";
		PreparedStatement ps1= con.prepareStatement(verifyStop);
		ps1.setString(1, transitLine);
		ps1.setString(2, date);
		ResultSet result=ps1.executeQuery();
		while (result.next()) {
			%>
			<tr bgcolor="#DEB887">
				<td><%=result.getString("reservation_number")%></td>
				<td><%=result.getString("passenger")%></td>
				<td><%=result.getString("email_address")%></td>
			</tr>
			<%
		}
		con.close();
	}
	catch (Exception error){
		out.print(error);
	}
	%>
	</table>
	<br>
	<a href=scheduleReservationLookup.jsp>Go back to Schedule/Reservation Lookup Dashboard</a>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Schedules</title>
</head>
<body>
	<form action="newSchedule.jsp" method="post">
		Create a New Schedule <br> Enter the Train that will be used and
		select the Transit Line: <br> <br> Train ID: <input
			type="text" name="trainID" required> <br>

		<%
			try {
				ApplicationDB app = new ApplicationDB();
				Connection con = app.getConnection();
				PreparedStatement ps = con.prepareStatement("SELECT * FROM TransitLines");
				ResultSet result = ps.executeQuery();
		%>
		Select Transit Line: <br> <select name="transitLine" size=1>
			<%
				while (result.next()) {
			%>
			<option><%=result.getString(1)%></option>
			<%
				}
			%>
		</select>&nbsp;<br> <br>*Time in YYYY-MM-DD HH:MM:SS Format <br> Origin Arrival Time: <input type="text" name="originArrival" required> <br>
		Origin Departure Time: <input type="text" name="originDeparture" required> <br>
		Destination Arrival Time: <input type="text" name="destArrival" required> <br>
		Destination Departure Time: <input type="text" name="destDeparture" required> <br>
		Fare (Enter in dollar amounts without the dollar sign): <input type="text" name="fare" required>
		<br> <input type="submit" value="Submit">
		<%
			con.close();
			} catch (Exception error) {
				out.print(error);
			}
		%>
	</form>
	<br>
	<a href=addScheduleStop.jsp>Add a stop to an existing schedule</a>
	<br>
	<br>
	<a href=scheduleOperations.jsp>Return to Schedule Dashboard</a>
</body>
</html>
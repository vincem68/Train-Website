<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Schedule Lookup and Reservation Lookup Dashboard</title>
<%@ include file="head.jsp" %>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container-fluid">
Lookup Schedules by Station ID as Origin/Destination
<br>
<br>
<form method="post" action="scheduleLookup.jsp">
Station ID:<input type="text" name="stationID" required> <br>
<input type="radio" name="stopType" value="origin" required> As Origin <input type="radio" name="stopType" value="destination" required> As Destination <br>
<input type="submit" value="Submit"> 
</form>
<br>
<br>
Lookup Reservations based on Transit Line and Date
<br>
<br>
<form method="post" action="reservationLookup.jsp">
<%
try {
			ApplicationDB app = new ApplicationDB();
			Connection con = app.getConnection();
			PreparedStatement ps= con.prepareStatement("SELECT * FROM TransitLines");
			ResultSet result=ps.executeQuery();
			%>
Select Transit Line:
<br>
		<select name="transitLine" size=1>
		<%while(result.next()){ %>
			<option><%=result.getString(1)%></option>
			<%} %>
		</select>&nbsp;<br> 
<% 			con.close();}catch (Exception error) {
			out.print(error);
		}%> 
Enter Date (yyyy-mm-dd):<input type="text" name="date" required> <br>
<input type="submit" value="Submit"> 
</form>
</div>
</body>
</html>
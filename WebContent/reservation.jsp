<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>

<html>


	<head><title>Order</title></head>

<body>
	<h1>Ready to book your next trip? Order here.</h1>
	<br>

	<%
		try {
			ApplicationDB app = new ApplicationDB();
			Connection c = app.getConnection();
			Statement s = c.createStatement();
			
			String check = "SELECT * FROM Schedules where departure_date > NOW()";
			PreparedStatement p = c.prepareStatement(check);
			ResultSet r = p.executeQuery();
			
			%>
			
			<table border = 3>
			
				<tr>
					<th>Schedule ID</th>
					<th>Train ID</th>
					<th>Departure Date</th>
					<th>Transit Name</th>
					<th>Arrival Date</th>
					<th>Fare</th>
				</tr>
				
				<% while (r.next()) { %> <!-- I don't know if we need the alias -->
						<tr>
							<td><%= r.getString("schedule_id") %></td>
							<td><%= r.getString("train_id") %></td>
							<td><%= r.getString("departure_date") %></td>
							<td><%= r.getString("transit_name") %></td>
							<td><%= r.getString("arrival_date") %></td>
							<td><%= r.getString("fare") %></td>
						</tr>
					<%
				}
			
			%>
			</table>
			<% 
			r.close();
			c.close();
		}
		catch (Exception uhOh){
			out.print(uhOh);
		}
	%>
<br>
<br>

	<form method = "post" action = "reservationStops.jsp">
		Enter the ID number of the desired schedule:<input type = "text" name = "id">
		<br>
		<input type = "submit" value = "Enter">
	</form>
	
	<br>
	
	
	
	Back to the Home page:
	<br>
	<form method= "get" action= "schedules.jsp">   
		<input type = "submit" value = "Back">

	</form>
	
</body>
</html>
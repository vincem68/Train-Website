<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>

<html>

<head><title>Reservation Confirmed</title></head>

<body>

	<%
		try {
			ApplicationDB app = new ApplicationDB();
			Connection c = app.getConnection();
			Statement s = c.createStatement();
			
			String userEmail = (String)session.getAttribute("email");
			String userStatus = request.getParameter("status");
			String userName = request.getParameter("passname");
			String sid = request.getParameter("id");
			String start = request.getParameter("origin");
			String end = request.getParameter("destination");
			String tripType = request.getParameter("trip");
			String statusType = request.getParameter("status");
		
			//first check if the origin station exists and grab departure time
			String see = "SELECT s.departure_time, w.fare FROM Schedules w, ScheduledStops s WHERE w.schedule_id = s.schedule_id AND s.schedule_id = ? AND s.station_id = ?"; 
			
			PreparedStatement p3 = c.prepareStatement(see);
			p3.setString(1, sid); p3.setString(2, start);
			ResultSet r2 = p3.executeQuery();
			
		//	out.print("test 1");
			if (!(r2.first())) {
				response.sendRedirect("invalidOrder.jsp");
			}
			else {
				
				String hold = r2.getString("departure_time"); String selectedFare = r2.getString("fare"); 
				r2.close(); p3.close();
				//now see if destination station exists and grab departure time
				String see2 = "SELECT departure_time FROM ScheduledStops WHERE schedule_id = ? AND station_id = ?";
				PreparedStatement p4 = c.prepareStatement(see2);
				p4.setString(1, sid); p4.setString(2, end);
				ResultSet r3 = p4.executeQuery();
				
				if (!(r3.first())){
					response.sendRedirect("invalidOrder.jsp");
				}
				else { 
					String hold2 = r3.getString("departure_time"); //here
					r3.close(); p4.close(); 
	/*				String fareCheck = "SELECT fare FROM Schedules WHERE schedule_id = ?"; 
					//out.print(sid);
					PreparedStatement p = c.prepareStatement(fareCheck);
					p.setString(1, sid);
					ResultSet r = p.executeQuery();
	
					String selectedFare = r.getString("fare");
					out.print(selectedFare);
					r.close(); */
					double calc = Double.parseDouble(selectedFare);
					
					String totalStations = "SELECT COUNT(*) AS amount FROM ScheduledStops WHERE schedule_id = ?";
					PreparedStatement p5 = c.prepareStatement(totalStations);
					p5.setString(1, sid);
					ResultSet r4 = p5.executeQuery();
					String total = "";
					if (r4.first()){
						total = r4.getString("amount");
					} 
					//String total = r4.getString("amount");
					r4.close(); p5.close();
					int all = Integer.parseInt(total);
					String stations = "SELECT COUNT(*) AS number FROM ScheduledStops WHERE schedule_id = ? AND (arrival_time > ? AND arrival_time < ?)";
					PreparedStatement p6 = c.prepareStatement(stations);
					p6.setString(1, sid); p6.setString(2, hold); p6.setString(3, hold2);
					ResultSet r5 = p6.executeQuery();
					String stops = "";
					if (r5.first()){
						stops = r5.getString("number");
					}
			//		String stops = r5.getString("number");
					int part = Integer.parseInt(stops);
					r5.close(); p6.close();
					
					double fraction = calc / all;
					
					double complete = fraction * part;
					
					if (tripType.equals("round")) {
						complete *= 2;
					}
					if (statusType.equals("child")) { //25% discount
						complete *= 0.75;
					}
					if (statusType.equals("senior")) { //35% discount
						complete *= 0.65;
					}
					if (statusType.equals("disabled")) { //50% discount
						complete *= 0.5;
					}
					
					String totalPrice = Double.toString(complete);
					
					out.print(start); out.print(end); out.print(totalPrice); out.print(userName); out.print(sid); out.print(userEmail);
					
					
					String check = "INSERT INTO Reservations (origin, destination, total_fare, passenger, reserved_on, schedule_id, email_address) VALUES (?, ?, ?, ?, NOW(), ?, ?)";
					PreparedStatement p2 = c.prepareStatement(check);
					p2.setString(1, start); p2.setString(2, end); p2.setString(3, totalPrice); p2.setString(4, userName); p2.setString(5, sid); p2.setString(6, userEmail);
					
					p2.executeUpdate();
				//	p2.close();
					
				}
			}
			
			c.close();
		}
		catch (Exception uhOh){
			out.print(uhOh);
		}
	%>

	<br>
	<h2>Your reservation has been successfully ordered.</h2>
	<br>
	
	<form method = "get" action = "reservation.jsp">
		<input type = "submit" value = "Back to Ordering">
	</form>
	
</body>

</html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../head.jsp" %>
</head>
<style>
	.nav-item {
		margin: 0px 5px;
	}
</style>
<body>
	<% try {
		if (session.getAttribute("loggedIn") == null || !((Boolean)session.getAttribute("loggedIn"))) {
			response.sendRedirect("../login.jsp");
		} else {
			if (session.getAttribute("isAdmin") != null && (Integer)session.getAttribute("isAdmin") == 1) { %>
			
			<%@ include file="../header.jsp" %>
			<% 
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				String getReservationsStmt = "select r.reservation_number,"; 
				getReservationsStmt += "(select st.name from Stations st where r.origin = st.station_id) as origin,"; 
				getReservationsStmt += "(select st.name from Stations st where r.destination = st.station_id) as destination,";
				getReservationsStmt += "s.transit_name,"; 
				getReservationsStmt += "c.username,";
				getReservationsStmt += "c.email_address,";
				getReservationsStmt += "r.reserved_on,";
				getReservationsStmt += "r.total_fare,";
				getReservationsStmt += "r.passenger,";
				getReservationsStmt += "(select ss.departure_time from ScheduledStops ss where r.origin = ss.station_id and ss.schedule_id = s.schedule_id) as departure_date,";
				getReservationsStmt += "s.train_id,";
				getReservationsStmt += "(select ss.arrival_time from ScheduledStops ss where r.destination = ss.station_id and ss.schedule_id = s.schedule_id) as arrival_date ";
				getReservationsStmt += "from Reservations r, Schedules s, Customers c ";
				getReservationsStmt += "where r.schedule_id = s.schedule_id and r.email_address = c.email_address ";
				
				PreparedStatement getReservations = null;
				ResultSet reservations = null;
			%>
			<div class="container mt-3">
				<ul class="nav">
					<li class="nav-item">
						<a href="dashboard.jsp">Manager Dashboard</a>
					</li>
					<li class="nav-item">
					    <a href="../employee/employees.jsp">Manage Employees</a>
					</li>
					<li class="nav-item">
					  	<a href="report.jsp">Sales Report</a>
					</li>
				</ul>
				<br>
				<div class="card">
					<div class="card-body">
						<div class="row">
							<div class="col-md-6">
								<h4>Reservations By Transit Line</h4>
								<%
									Statement getTransitLines = con.createStatement();
									ResultSet transitLines = getTransitLines.executeQuery("Select transit_name from TransitLines");
								%>
								<% if (transitLines.next()) { %>
								<form action="reservations.jsp" method="post">
									<div class="input-group">
										<select class="form-control" name="transitLine">
											<option disabled selected>Select Transit Line</option>
											<% do { %>
												<option><%= transitLines.getString("transit_name") %></option>
											<% } while(transitLines.next()); %>
										</select>
										<div class="input-group-append">
											<input class="btn btn-primary" type="submit" value="Submit">
										</div>
									</div>
								</form>
								<%
									}
									getTransitLines.close();
									transitLines.close();
									
									if (request.getParameter("transitLine") != null) {
										getReservationsStmt += "and s.transit_name = ? ";
										getReservationsStmt += "order by reserved_on desc;";
										
										getReservations = con.prepareStatement(getReservationsStmt);
										getReservations.setString(1, request.getParameter("transitLine"));
										reservations = getReservations.executeQuery();
									}
								%>
							</div>
							<div class="col-md-6">
								<h4>Reservations By Customer</h4>
								<%
									Statement getEmails = con.createStatement();
									ResultSet emails = getEmails.executeQuery("Select email_address, username from Customers");
								%>
								<% if (emails.next()) { %>
								<form action="reservations.jsp" method="post">
									<div class="input-group">
										<select class="form-control" name="email">
											<option disabled selected>Select a User</option>
											<% do { %>
												<option value="<%= emails.getString("email_address") %>"><%= emails.getString("username") %></option>
											<% } while(emails.next()); %>
										</select>
										<div class="input-group-append">
											<input class="btn btn-primary" type="submit" value="Submit">
										</div>
									</div>
								</form>
								<% 
									}
									getEmails.close();
									emails.close();
									
									if (request.getParameter("email") != null) {
										getReservationsStmt += "and c.email_address = ? ";
										getReservationsStmt += "order by reserved_on desc;";
										
										getReservations = con.prepareStatement(getReservationsStmt);
										getReservations.setString(1, request.getParameter("email"));
										reservations = getReservations.executeQuery();
									}
								%>
							</div>
							<div class="col-sm-12">
								<br>
								
								<% if (reservations != null) { %>
									<% if (request.getParameter("email") != null) {%>
										<h4> Reservations by <%= request.getParameter("email") %></h4>
									<% } else {%>
										<h4> Reservations for <%= request.getParameter("transitLine") %></h4>
									<% } %>
									
									<% if (reservations.next()) { %>
									<table class="table">
										<thead>
											<tr>
												<th scope="col">Reservation #</th>
										    	<th scope="col">Transit Line</th>
										    	<th scope="col">Origin</th>
										    	<th scope="col">Destination</th>
										    	<th scope="col">Reserved By</th>
										    	<th scope="col">Passenger</th>
										    	<th scope="col">Total Fare</th>
											</tr>
										</thead>
										<tbody>
											<% do {
												 String routeStmt = "select s.transit_name, st.name, ss.arrival_time, ss.departure_time, ";
												 		routeStmt += "(select count(*) from Schedules s, Stations st, ScheduledStops ss, Reservations r ";
												 		routeStmt += "where s.transit_name = ss.transit_name and ss.station_id = st.station_id and r.schedule_id = s.schedule_id ";
												 		routeStmt += "and r.reservation_number = ? and ss.departure_time >= ? and ss.arrival_time <= ?) num_of_stops ";
														routeStmt += "from Schedules s, Stations st, ScheduledStops ss, Reservations r ";
														routeStmt += "where s.transit_name = ss.transit_name and ss.station_id = st.station_id and r.schedule_id = s.schedule_id ";
														routeStmt += "and r.reservation_number = ? ";
														routeStmt += "and ss.departure_time >= ?";
														routeStmt += "and ss.arrival_time <= ?";
														routeStmt += "order by arrival_time asc;";
														
												PreparedStatement getRoutes = con.prepareStatement(routeStmt);
												getRoutes.setInt(1, reservations.getInt("reservation_number"));
												getRoutes.setTimestamp(2, reservations.getTimestamp("departure_date"));
												getRoutes.setTimestamp(3, reservations.getTimestamp("arrival_date"));
												getRoutes.setInt(4, reservations.getInt("reservation_number"));
												getRoutes.setTimestamp(5, reservations.getTimestamp("departure_date"));
												getRoutes.setTimestamp(6, reservations.getTimestamp("arrival_date"));
												ResultSet route = getRoutes.executeQuery();
												
											%>
												<tr>
													<td><%= reservations.getInt("reservation_number") %></td>
													<td>
														<%= reservations.getString("transit_name") %>
														<div class="text-muted form-text">
															TRAIN <%= reservations.getString("train_id") %>
														</div>
													</td>
													<td>
														<%= reservations.getString("origin") %>
														<div class="text-muted form-text">
															<%= reservations.getTimestamp("departure_date") %>
														</div>
													</td>
													<td>
														<%= reservations.getString("destination") %>
														<div class="text-muted form-text">
															<%= reservations.getTimestamp("arrival_date") %>
														</div>
													</td>
													<td>
														<%= reservations.getString("username") %>
														<div class="text-muted form-text">
															<%= reservations.getDate("reserved_on") %>
														</div>
													</td>
													<td><%= reservations.getString("passenger") %></td>
													<td class="format-fare"><%= reservations.getString("total_fare") %></td>
												</tr>
												<tr>
													<td colspan="7">
														<div><strong>Route</strong></div>
														<div>
															<% 
															if (route.next()) {
																int stop_num = 0;
																do {
																	stop_num++;
																	if (stop_num != route.getInt("num_of_stops")) { %>
																		<span><%= route.getString("name") %> -></span>
																	<% } else { %>
																		<span><%= route.getString("name") %></span>
																	<% }
																} while(route.next()); 
															} else {
															%>	
															
															<div class="alert alert-secondary">No Scheduled Route available.</div>
															<%
															}
															
															getRoutes.close();
															route.close();
															%>
																
														</div>
													</td>
												</td>
											<% } while(reservations.next()); %>
										</tbody>
									</table>
									
									<% } else { %>
										<div class="alert alert-secondary">No reservations made for this Transit Line.</div>
									<% }
										getReservations.close();
										reservations.close();
									%>
								<% } else { %>
									<div class="alert alert-secondary">No reservations.</div>
								<% } %>
							</div>
						</div>
					</div>
				</div>
			</div>
			
		<% con.close(); %>
		<% } else { %>
			<div class="container">
				<div class="alert alert-warning">
					You do not have permissions to view this page. <a href="../index.jsp">Home</a>
				</div>
			</div>
		<% }
		}
	
	} catch(Exception e) {
		out.print(e);
	} %>
<script>
	var fares = document.getElementsByClassName("format-fare");

	if (fares.length > 0) {
		for (var i = 0; i < fares.length; i++) {
			fares[i].textContent = currencyFormat(fares[i].textContent);
		}
	}
		
	function currencyFormat(txt) {
		return '$'+parseFloat(txt).toFixed(2);
	}
</script>
</body>
</html>
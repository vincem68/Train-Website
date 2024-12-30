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
					  	<a href="report.jsp">See Reservations</a>
					</li>
				</ul>
				<br>
				<div class="card">
					<div class="card-body">
						<h4>Generate Sales Report (Monthly*)</h4>
						<form action="report.jsp" method="post">
							<div class="input-group">
								<select class="form-control" name="month">
									<option disabled selected>Select Month</option>
									<option>January</option>
									<option>February</option>
									<option>March</option>
									<option>April</option>
									<option>May</option>
									<option>June</option>
									<option>July</option>
									<option>August</option>
									<option>September</option>
									<option>October</option>
									<option>November</option>
									<option>December</option>
								</select>
								<div class="input-group-append">
									<input class="btn btn-primary" type="submit" value="Submit">
								</div>
							</div>
							
							<% 
							if (request.getParameter("month") != null) {
								String getTotalSalesStmt = "select sum(r.total_fare) sales, count(*) reservations_count ";
										getTotalSalesStmt += "from Reservations r ";
										getTotalSalesStmt += "where monthname(reserved_on) = ?;";
			
								PreparedStatement getTotalSales = con.prepareStatement(getTotalSalesStmt);
								getTotalSales.setString(1, request.getParameter("month"));
								ResultSet totalSales = getTotalSales.executeQuery();
								
								if (totalSales.next()) { 
								%>
									<table class="table">
										<thead>
											<th scope="col">Total <%= request.getParameter("month") %> Sales</th>
											<th>Total <%= request.getParameter("month") %> Reservations</th>
										</thead>
										<tbody>
											<td id="totalSales"><%= totalSales.getFloat("sales") %></td>
											<td><%= totalSales.getInt("reservations_count") %></td>
										</tbody>
									</table>
								<%	
								} else { 
								%>
									<div class="alert alert-secondary">No sales yet for this month</div>
								<%
								}
								
								totalSales.close();
								getTotalSales.close();
							}
							%>
						</form>
						
						<div class="text-muted form-text">*Aggregate sales for each month</div>
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
	var rev = document.getElementById("totalSales");
	
	if (rev !== null) {
		rev.textContent = currencyFormat(rev.textContent);
	}
	
	function currencyFormat(txt) {
		return '$'+parseFloat(txt).toFixed(2);
	}
</script>
	
</body>
</html>
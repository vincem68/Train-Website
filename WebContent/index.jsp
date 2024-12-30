<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="head.jsp" %>
</head>
<style>
	.nav-item {
		margin: 0px 5px;
	}
</style>
<body>
	
	<% try {
		if (session.getAttribute("loggedIn") == null || !((Boolean)session.getAttribute("loggedIn"))) {
			response.sendRedirect("login.jsp");
		} else { %>
			<%@ include file="header.jsp" %>
			<div class="container mt-3">
				<h1>Welcome <% out.print(session.getAttribute("username")); %> </h1>
				<% 
				if (session.getAttribute("isAdmin") != null) { 
				%>
					<p> ssn: <% out.print(session.getAttribute("ssn")); %> </p>
					
					<% if ((Integer)session.getAttribute("isAdmin") == 1) { %>
						<a href="manage/dashboard.jsp">View Manager Dashboard</a>
					<% } else { %>
						<ul class="nav">
							<li class="nav-item">
								<a href="scheduleOperations.jsp">Edit Train Schedules</a>
							</li>
							<li class="nav-item">
							    <a href="qaEmployee.jsp">Answer Customer Questions</a>
							</li>
							<li class="nav-item">
							  	<a href="scheduleReservationLookup.jsp">Look up Schedules and Reservations</a>
							</li>
						</ul>
					<% } 
				} else {
					response.sendRedirect("schedules.jsp");
				} 
				 %>
			</div>
		<% } 
		
	} catch (Exception e) {
		 	out.print(e);
	 } %>
	
</body>
</html>
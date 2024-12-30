<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Employee Login Success</title>
</head>
<body>
Welcome <% out.print(session.getAttribute("firstname")); %>
<br>
<a href=scheduleOperations.jsp>Edit Train Schedules</a>
<br>
<a href=qaEmployee.jsp>Answer Customer Questions</a>
<br>
<a href=scheduleReservationLookup.jsp>Look up Schedules and Reservations</a>
<br>
<a href=logout.jsp> Logout </a>
</body>
</html>
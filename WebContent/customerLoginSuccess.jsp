<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Login Success</title>
</head>
<body>
Login Successful
<br>
Welcome <%out.print(session.getAttribute("firstname")+ " " + session.getAttribute("lastname")); %> <br>
Email is <%out.print(session.getAttribute("email")); %>
<br>
<a href=qaCustomers.jsp>Browse and Ask Q&A Board</a>
</body>
</html>
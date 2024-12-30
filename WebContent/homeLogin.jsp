<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Home Login</title>
</head>

<body>
	Welcome to the Train Site!
	<br> This is the customer login
	<br>
	<br>
	<form action="customerLogin.jsp" method="post">
		Username: <input type="text" name="username" required> <br>
		Password: <input type="password" name="password" required> <br>
		<input type="submit" value="Submit">
	</form>
	<br>
	<br>
	<br> Not registered yet? Sign up for a
	<a href=register.jsp> customer account </a>
	<br>
	<a href=employeeLoginPage.jsp>Employee login</a>

</body>
</html>
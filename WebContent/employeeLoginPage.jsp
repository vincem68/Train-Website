<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Employee Login</title>
</head>

<body>
This is the employee login
	<br>
	<br>
	<form action="employeeLogin.jsp" method="post">
		Username: <input type="text" name="username" required> <br>
		Password: <input type="password" name="password" required> <br>
		<input type="submit" value="Submit">
	</form>
	<br>
	<br>
	<br> Took a wrong turn? Go back to the 
	<a href=homeLogin.jsp> customer login </a>
	<br>
	Not registered for an employee account? Talk to your manager or supervisor. We can't set those up here :(

</body>
</html>
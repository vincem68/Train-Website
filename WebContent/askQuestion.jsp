<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ask Question</title>
</head>
<body>
Ask Your Question Here
<form method="get" action="questionProcess.jsp">
<textarea rows="4" cols="50" name="question"></textarea>
<br><br><input type="submit" value="Post Question" required>
</form></body>
<br>
<br>
Took a wrong turn? 
<br>
<a href="qaCustomers.jsp">Click here to go back to Q&A Dashboard</a>
</html>
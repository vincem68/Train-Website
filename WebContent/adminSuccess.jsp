<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Login Success</title>
</head>
<body>
Welcome <% out.print(session.getAttribute("firstname")); %>
<br>
<img src="https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2018/01/12201051/cute-puppy-body-image.jpg" alt="dog">
<br> 
Here's a picture of a dog. Thanks for being an admin.
<br>
That's all. You won't be able to do anything until later. For now, you can <a href=logout.jsp> logout</a>
</body>
</html>
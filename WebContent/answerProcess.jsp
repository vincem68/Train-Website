<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Answer Process</title>
</head>
<body>
	<%try {
		ApplicationDB db= new ApplicationDB();
		Connection con= db.getConnection();
		//requires session.setAttribute from employee login page for ssn
		String insert = "UPDATE Questions SET cr_ssn= ? , answer='"+request.getParameter("answer")+"'" + " WHERE question_id ="+session.getAttribute("currQuestionID");
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setString(1, (String)session.getAttribute("ssn"));
		ps.executeUpdate();
		db.closeConnection(con);
		response.sendRedirect("answerSuccess.jsp");
	}
	catch (Exception error){
		out.print(error);
	}
	%>
</body>
</html>
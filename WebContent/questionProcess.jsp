<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Question Process</title>
</head>
<body>
<%try {
	//REQUIRES SESSION GETATTRIBUTE EMAIL
		ApplicationDB db= new ApplicationDB();
		Connection con= db.getConnection();
		int questionID=1;
		String idQuery= "SELECT MAX(question_id) FROM Questions";
		PreparedStatement ps1 = con.prepareStatement(idQuery);
		ResultSet max = ps1.executeQuery();
		if(max.first()==true){
			questionID=max.getInt(1)+1;
		}
		String qCheck= "SELECT * FROM Questions WHERE question='"+request.getParameter("question")+"'";
		PreparedStatement ps2=con.prepareStatement(qCheck);
		ResultSet stations= ps2.executeQuery();
		if(stations.first()==true){
			response.sendRedirect("dupeQuestion.jsp");
		}
		else{
		String insert= "INSERT INTO Questions(question_id, email_address, question) VALUES(?,"+"'"+session.getAttribute("email")+"' "+", '"+request.getParameter("question")+"')";
		PreparedStatement newQuestion= con.prepareStatement(insert);
		newQuestion.setString(1, Integer.toString(questionID));
		newQuestion.executeUpdate();
		response.sendRedirect("askQuestionSuccess.jsp");
		}
		con.close();
	}
	catch (Exception error){
		out.print(error);
	}
	%>
</body>
</html>
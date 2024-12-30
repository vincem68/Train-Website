<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Answer Question</title>
</head>
<body>
	<table>
		<tr bgcolor="#B19CD9">
			<td><b>Question ID</b></td>
			<td><b>Customer Email Address </b></td>
			<td><b>Date Asked On</b></td>
			<td><b>Question</b></td>
			<%
				try {
					String qID=request.getParameter("questionID");
					session.setAttribute("currQuestionID", qID);
					ApplicationDB app = new ApplicationDB();
					Connection con = app.getConnection();
					String questionsQuery = "SELECT * FROM Questions q WHERE q.question_id="
							+ qID + " AND q.cr_ssn IS NULL";
					PreparedStatement ps = con.prepareStatement(questionsQuery);
					ResultSet result = ps.executeQuery();
					if (result.first() == false) {
						response.sendRedirect("answerFailure.jsp");
					} else {

						if(result.first()) {
							out.print(session.getAttribute("ssn"));
			%>
		<tr bgcolor="#ADD8E6">
			<td><%=result.getString("question_id")%></td>
			<td><%=result.getString("email_address")%></td>
			<td><%=result.getString("asked_on")%></td>
			<td><%=result.getString("question")%></td>

		</tr>
	</table>
	<%
		}
			}
			con.close();
		} catch (Exception error) {
			out.print(error);
		}
	%>
	<br>
	<br>
	<form method="get" action="answerProcess.jsp">
		Answer: <br>
		<textarea rows="4" cols="50" name="answer"></textarea>
		<br> <input type="submit" value="Reply">
	</form>
	<br>
	<br>
	<a href=qaEmployee.jsp>Return to Q&A Dashboard</a>
</body>
</html>
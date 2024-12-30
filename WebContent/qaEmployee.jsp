<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Employee Q&A Dashboard</title>
<%@ include file="head.jsp" %>
</head>
<body>
	<%@ include file="header.jsp" %>
	<div class="container-fluid">
	Employee Question & Answer Dashboard
	<br> 
	<br> Question ID's to be Answered:
	<%
		try {
			ApplicationDB app = new ApplicationDB();
			Connection con = app.getConnection();
			String notAnswered = "SELECT q.question_id FROM Questions q WHERE q.cr_ssn IS NULL ORDER BY q.question_id";
			PreparedStatement psNA = con.prepareStatement(notAnswered);
			ResultSet qTBA = psNA.executeQuery();
			while (qTBA.next()) {
	%>
	<td><%=qTBA.getString("question_id")%></td>
	<%
		out.print(" ");
	%>
	<%
		}
	%>
	<br>
	<br>
	Answer a Question <br>
		<form method="get" action="answerQuestion.jsp">
	Question ID: <input type="text" name="questionID" required> <br>
		<input type="submit" value="Submit">
	</form>
	<br>
	<br> Question Database
	<br>
	<br>
	<table>
		<tr bgcolor="#B19CD9">
			<td><b>Question ID</b></td>
			<td><b>Customer Email Address </b></td>
			<td><b>Date Asked On</b></td>
			<td><b>Question</b></td>
			<td><b>Customer Rep Name</b></td>
			<td><b>Date Answered On</b></td>
			<td><b>Answer</b></td>
		</tr>
		<%
			//String scheduleInfo = "SELECT q.question_id, q.email_address, q.asked_on, q.question, e.first_name, q.answered_on, q.answer FROM Questions q, Employees e WHERE q.cr_ssn=e.ssn ORDER BY q.question_id";
				String questionsQuery = "SELECT * FROM Questions q ORDER BY q.question_id";
				PreparedStatement ps = con.prepareStatement(questionsQuery);
				ResultSet result = ps.executeQuery();
				while (result.next()) {
		%>
		<tr bgcolor="#ADD8E6">
			<td><%=result.getString("question_id")%></td>
			<td><%=result.getString("email_address")%></td>
			<td><%=result.getString("asked_on")%></td>
			<td><%=result.getString("question")%></td>
			<%
				if (result.getString("cr_ssn") != null) {
							PreparedStatement name = con
									.prepareStatement("SELECT e.first_name FROM Questions q, Employees e WHERE e.ssn="
											+ "'"+ result.getString("cr_ssn")+"'");
							ResultSet crName = name.executeQuery();
							if (crName.first()) {
			%>
			<td><%=crName.getString("first_name")%></td>
			<td><%=result.getString("answered_on")%></td>
			<td><%=result.getString("answer")%></td>


			<%
				}
						} else {
			%>
			<td></td>
			<td></td>
			<td></td>
			<%
				}
			%>

		</tr>
		<%
			}
				con.close();
			} catch (Exception error) {
				out.print(error);
			}
		%>
	</table>
	</div>
</body>
</html>
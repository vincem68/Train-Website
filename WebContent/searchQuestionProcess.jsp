<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search Process</title>
</head>
<body>
	Search
	<br>
	<br>
	<a href=qaCustomers.jsp>Return to Q&A Dashboard</a>
	<br>
	<br> Search Results
	<table>
		<tr bgcolor="#B19CD9">
			<td><b>Date Asked On</b></td>
			<td><b>Question</b></td>
			<td><b>Answered By</b></td>
			<td><b>Date Answered On</b></td>
			<td><b>Answer</b></td>
		</tr>
		<%
			try {
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
				String searchTerms = request.getParameter("searchTerms");
				String[] words = searchTerms.trim().split("\\s+");
				if (words.length == 0) {
					response.sendRedirect("qaCustomers.jsp");
				}
				String searchBase = "SELECT * FROM Questions WHERE ";
				String searchQuestions = "question ";
				String searchAnswers = "answer ";
				for (int i = 0; i < words.length; i++) {
					if (i > 0) {
						searchQuestions = searchQuestions + " AND question ";
						searchAnswers = searchAnswers + " AND answer ";
					}
					String like = " LIKE '%" + words[i] + "%'";
					searchQuestions = searchQuestions + like;
					searchAnswers = searchAnswers + like;
				}
				String searchQuery = searchBase + searchQuestions + "OR " + searchAnswers;
				PreparedStatement ps = con.prepareStatement(searchQuery);
				ResultSet result = ps.executeQuery();
				while (result.next()) {
		%>
		<tr bgcolor="#ADD8E6">
			<td><%=result.getString("asked_on")%></td>
			<td><%=result.getString("question")%></td>
			<%
				if (result.getString("cr_ssn") != null) {
							PreparedStatement name = con
									.prepareStatement("SELECT e.first_name FROM Questions q, Employees e WHERE e.ssn="
											+ result.getString("cr_ssn"));
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
</body>
</html>
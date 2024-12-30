<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
	

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <a class="navbar-brand" href="<%= request.getContextPath() %>/index.jsp">Train Scheduler</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <% if (session.getAttribute("loggedIn") != null && (Boolean)session.getAttribute("loggedIn")) { %>
  <div class="collapse navbar-collapse" id="navbarText">
    <ul class="navbar-nav mr-auto">
     <!--  <li class="nav-item active">
        <a class="nav-link" href="./index.jsp">Home</a>
      </li> -->
    </ul>

    <span class="navbar-text">
      Hello <% out.print(session.getAttribute("firstname")); %> 
      <a href="<%= request.getContextPath() %>/logout.jsp">Logout</a>
    </span>
  <% } %>
  </div>
</nav>
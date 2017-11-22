<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Visit Logged</title>
</head>
<body>
	<%
			//List<String> list = new ArrayList<String>();
	
			try {
				String bar = request.getParameter("bar");
				String drinker = request.getParameter("drinker");
				String season = request.getParameter("season");
				
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				
				//Create a SQL statement
				PreparedStatement stmt = con.prepareStatement("INSERT INTO visited VALUES ((SELECT MAX(v.index) + 1 FROM visited v), ?, ?, ?)");
				stmt.setString(1, drinker);
				stmt.setString(2, season);
				stmt.setString(3, bar);
				//Run the query against the database.
				stmt.executeUpdate();
				
				out.print("<center><h2><a href='drinkerQueries.jsp'>Your visit has been logged, thank you for your input</a></h2></center>");

				//close the connection.
				con.close();
	
			} catch (SQLException e) {
				out.print(e.getMessage());
				out.print("<center><p><a href='drinkerQueries.jsp'> There was an internal error with the data base try again</a></p></center>");
			}
			%>

</body>
</html>
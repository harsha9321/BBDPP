<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Bars that sell beer</title>
	
	<link href="CSS/drinkerQ1.css" rel="stylesheet" type="text/css">
</head>
<body>
	<a id="home" href="main.jsp">HOME</a>

	<%
		String beer = request.getParameter("beer");
		try{
			int limit = Integer.parseInt(request.getParameter("limit"));
			
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			//Create a SQL statement
			PreparedStatement stmt = con.prepareStatement("SELECT bar as Bars FROM sells WHERE beer =? LIMIT ?;");
			stmt.setString(1, beer);
			stmt.setInt(2, limit);
			//Run the query against the database.
			ResultSet result = stmt.executeQuery();
			out.print("<table align=\"center\">");
			out.print("<tr><th>Bars</th></tr>");

			 while(result.next()){
				 out.print("<tr align=\"center\"><td>" + result.getString("Bars") + "</td></tr>");
			 }
			 out.print("</table>");
			//close the connection.
			con.close();
			
		}catch(Exception e){
			out.print("<center><h3>" + e.getMessage() + "</center></h3>");
			out.print("<center><h3>Something went wrong in backend try again.</h3></center>");
		}
	
	
	
	%>


</body>
</html>
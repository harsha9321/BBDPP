<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
	
	<%
				try {
					
				int limit  = Integer.parseInt(request.getParameter("limit"));
				
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				//Create a SQL statement
				PreparedStatement stmt2 = con.prepareStatement("SELECT sells.beer AS beer, COUNT(*) AS patrons FROM sells s, likes l, frequents f " +
															  "WHERE l.drinker = f.drinker AND l.beer = s.beer AND f.bar = s.bar AND s.bar =?" +
															  "GROUP BY s.beer ORDER BY COUNT(*) DESC LIMIT ?");
				stmt2.setString(1, barname);
				stmt2.setInt(2, limit);
				//Run the query against the database.
				ResultSet result = stmt2.executeQuery();
				out.print("<table>");
				out.print("<tr><th>Beer</th> <th>Number of Patrions</th></tr>");

				 while(result.next()){
					 out.print("<tr><td>" + result.getString("beer") + "</td><td>" + result.getString("patrons") + "</td></tr>");
				 }
				 out.print("</table>");
			//close the connection.
				con.close();
	
			} catch (Exception e) {
				System.out.println(e.getStackTrace() + "hello world");
			}
		%>
</body>
</html>
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
				out.println("test1");
				int limit  = Integer.parseInt(request.getParameter("limit"));
				out.println("test2");
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				//Create a SQL statement
				out.println("test3");
				PreparedStatement stmt2 = con.prepareStatement("SELECT s.beer AS beer, COUNT(*) AS patrons FROM sells s, likes l, frequents f " +
															  "WHERE l.drinker = f.drinker AND l.beer = s.beer AND f.bar = s.bar AND s.bar =?" +
															  "GROUP BY s.beer ORDER BY COUNT(*) DESC LIMIT ?");
				out.println("test4");
				stmt2.setString(1, (String)session.getAttribute("bar"));
				stmt2.setInt(2, limit);
				out.println("test5");
				//Run the query against the database.
				try{
					ResultSet result = stmt2.executeQuery();
					out.print("<table>");
					out.print("<tr><th>Beer</th> <th>Number of Patrions</th></tr>");
					out.println("test6");
					 while(result.next()){
						 out.print("<tr><td>" + result.getString("beer") + "</td><td>" + result.getString("patrons") + "</td></tr>");
					 }
					 out.print("</table>");
				//close the connection.
					con.close();
					out.println("test7");
				}catch(SQLException e){
					out.print(e.getMessage());
				}
				
	
			} catch (Exception e) {
				System.out.println(e.getStackTrace() + "hello world");
			}
		%>
</body>
</html>
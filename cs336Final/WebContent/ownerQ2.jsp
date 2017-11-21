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
				PreparedStatement stmt2 = con.prepareStatement("SELECT s.beer AS beer, COUNT(*) AS patrons FROM sells s, likes l, frequents f " +
															  "WHERE l.drinker = f.drinker AND l.beer = s.beer AND f.bar = s.bar AND s.bar =?" +
															  "GROUP BY s.beer ORDER BY COUNT(*) DESC LIMIT ?");
				stmt2.setString(1, (String)session.getAttribute("bar"));
				stmt2.setInt(2, limit);
				//Run the query against the database.
				try{
					ResultSet result = stmt2.executeQuery();
					out.print("<center><table>");
					out.print("<center><tr><th>Beer</th> <th>Number of Patrions</th></tr></center>");
					 while(result.next()){
						 out.print("<center><tr><td align=\"center\">" + result.getString("beer") + "</td>" +
						 			"<td align=\"center\">" + result.getString("patrons") + "</td></tr></center>");
					 }
					 out.print("</table></center>");
				//close the connection.
					con.close();
				}catch(SQLException e){
					out.print(e.getMessage());
				}
				
	
			} catch (Exception e) {
				System.out.println(e.getStackTrace() + "hello world");
			}
		%>
</body>
</html>
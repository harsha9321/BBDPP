<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Modifier Result</title>

<link href="CSS/newModifier.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div><a id="home" href="main.jsp">HOME</a></div>

	<%
		try{
			double modifier = Double.parseDouble(request.getParameter("modifier"));
			String season = request.getParameter("season");
			String bar = (String)session.getAttribute("bar");
			
			if(modifier < 0){
				out.print("<center><h2>The new modifier needs to be greater then 0.</h2></center>");
			}
			else {
				try{
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				Connection con2 = db.getConnection();

				//Create a SQL statement
				PreparedStatement stmt = con.prepareStatement("UPDATE sesonalModifer SET modifer = TRUNCATE(?, 2) WHERE bar = ? AND season ?;");
				stmt.setDouble(1, modifier);
				stmt.setString(2, bar);
				stmt.setString(3, season);
				//Run the query against the database.
				
				PreparedStatement stmt2 = con.prepareStatement("UPDATE seasonalprices JOIN sells set seasonalPrice = TRUNCATE((baseprice * ?), 2) " +
																"WHERE seasonalprices.bar = sells.bar and seasonalprices.bar = ? and seasonalprices.season = ?;");
				stmt2.setDouble(1, modifier);
				stmt2.setString(2, bar);
				stmt2.setString(3, season);
				stmt2.executeUpdate();
				
				PreparedStatement stmt3 = con2.prepareStatement("SELECT * FROM seasonalprices WHERE bar = ? AND season = ?;");
				stmt3.setString(1, bar);
				stmt3.setString(2, season);
				ResultSet result = stmt3.executeQuery();
				
				out.print("<center><h2>Your modifier has been accepted and applied</h2></center>");
				out.print("<table align=\"center\">");
				out.print("<tr><th>Beers</th><th>Season</th><th>Seasonal Price</th></tr>");

				 while(result.next()){
					 out.print("<tr align=\"center\"><td>" + result.getString("beer") + "</td><td>" + result.getString("season") + "</td><td>" + 
				 											result.getString("seasonalPrice") + "</td></tr>");
				 }
				 out.print("</table>");
				//close the connection.
				result.close();
				stmt.close();
				stmt2.close();
				stmt3.close();
				con.close();
				con2.close();
				} catch(SQLException e){
					out.print(e.getMessage());
				}
			}
		}catch(Exception e){
			out.print("<center><h2>The new modifier needs to be a number.</h2></center>");
		}
	
	%>

</body>
</html>
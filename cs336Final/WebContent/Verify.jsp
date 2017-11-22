<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Verification</title>
</head>
<body>
	<center>
	<p>This page is to verify our pattern, our pattern is that the seasonal price from the seasonalPrices 
		table is the product of the seasonal modifier and the base price of the beer at that bar, the query we used to verify this is: <br>
		SELECT * from seasonalModifer WHERE modifer NOT IN (SELECT ROUND(TRUNCATE((seasonalPrice / basePrice), 2), 1) as modifer
		FROM seasonalprices, sells WHERE seasonalprices.bar = sells.bar AND seasonalprices.beer = sells.beer group by sells.bar, seasonalprices.season); </p><br>
		
		<h4>If a table containing tuples appears then our Pattern failed.</h4>
	</center>
	
	<center>
		<%
			//List<String> list = new ArrayList<String>();
	
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				
				//Create a SQL statement
				Statement stmt = con.createStatement();
				
				//Run the query against the database.
				ResultSet result = stmt.executeQuery("SELECT * FROM seasonalModifer " + 
														"WHERE modifer NOT IN (SELECT ROUND(TRUNCATE((seasonalPrice / basePrice), 2), 1) AS modifer " +
														"FROM seasonalprices, sells WHERE seasonalprices.bar = sells.bar AND seasonalprices.beer = sells.beer " +
														"GROUP BY sells.bar, seasonalprices.season );");
				
				if(result.next() == false){
					out.print("<center>The pattern holds, The query does not return any tuples.");
				}
				else {
				
				out.print("<table align=\"center\">");
				out.print("<tr><th>Bar</th><th>Season</th><th>SeasonalModifier</th></tr>");

				 while(result.next()){
					 out.print("<tr align=\"center\"><td>" + result.getString("bar") + "</td><td>" + result.getString("season") + "</td><td>" + 
				 											result.getString("seasonalModifer") + "</td></tr>");
				 }
				 out.print("</table>");
				}
				//close the connection.
				result.close();
				stmt.close();
				con.close();
	
			} catch (SQLException e) {
				out.println(e.getMessage());
				out.print("<center><p><a href='main.jsp'> There was an internal error with the data base try again</a></p></center>");
			}
			%>
	
	
	</center>	
		
		
</body>
</html>
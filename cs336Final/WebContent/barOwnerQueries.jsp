<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<script type="text/javascript">
function showQueries() {
    if (document.getElementById('q1button').checked) {
        document.getElementById('q1').style.display = 'block';
    }
    else document.getElementById('q1').style.display = 'none';
    
    if (document.getElementById('q2button').checked) {
        document.getElementById('q2').style.display = 'block';
    }
    else document.getElementById('q2').style.display = 'none';
}
</script>

<title>Bar Owner Queries</title>
</head>
<body>
	<% 
		String barname = request.getParameter("bar");
		out.print("<center><h1>" + barname + "</h1></center>");
	%>
	<center>
	
	<p>What would you like to see:</p><br>
	
	Number of people that visit your bar per season: <input type="radio" onclick="javascript:showQueries();" name="q1button" id="q1button"><br>
	Beers liked by Patrons that frequent your bar: <input type="radio" onclick="javascript:showQueries();" name="q1button" id="q2button"><br>

	<div id="q1" style="display:none">
			<%
			List<String> list = new ArrayList<String>();

			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				//Create a SQL statement
				PreparedStatement stmt = con.prepareStatement("SELECT season, patrons FROM seasonalPatrons WHERE bar =?");
				stmt.setString(1, barname);
				//Run the query against the database.
				ResultSet result = stmt.executeQuery();
				out.print("<table>");
				out.print("<tr><th>Season</th> <th>Patrons</th></tr>");

				 while(result.next()){
					 out.print("<tr><td>" + result.getString("season") + "</td><td>" + result.getString("patrons") + "</td></tr>");
				 }
				 out.print("</table>");
			//close the connection.
				con.close();
	
			} catch (Exception e) {
				System.out.println(e.getStackTrace());
			}
			%>
	</div>
	
	<div id="q2" style="display:none">
		<p>hello world</p>
		<form method="post" action="barOwnerQueries.jsp">
			Limit to: <select name="limit" size=1> 
				<option value="10">10</option>
				<option value="20">20</option>
				<option value="50">50</option>
				<option value="75">75</option>
				<option value="100">100</option>
				
			</select>  beers
			<br> <input type="submit" value="Submit" name="submit">
		</form>
		
		<%
			if(request.getParameter("submit") != null){
				try {
					
				int limit  = Integer.parseInt(request.getParameter("limit"));
				String bname = request.getParameter("submit");
				
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				//Create a SQL statement
				PreparedStatement stmt2 = con.prepareStatement("SELECT sells.beer AS beer, COUNT(*) AS patrons FROM sells s, likes l, frequents f " +
															  "WHERE l.drinker = f.drinker AND l.beer = s.beer AND f.bar = s.bar AND s.bar =?" +
															  "GROUP BY s.beer ORDER BY COUNT(*) DESC LIMIT ?");
				stmt2.setString(1, bname);
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
		}
		%>
	
	</div>
	</center>
	
</body>
</html>
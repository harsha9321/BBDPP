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
		if (document.getElementById('showOptions').onclick) {
	        document.getElementById('options').style.display = 'block';
	    }
		
	    if (document.getElementById('q1button').checked) {
	        document.getElementById('q1').style.display = 'block';
	    }
	    else document.getElementById('q1').style.display = 'none';
	    
	    if (document.getElementById('q3button').checked) {
	        document.getElementById('q3').style.display = 'block';
	    }
	    else document.getElementById('q3').style.display = 'none';
	    
	    if (document.getElementById('q4button').checked) {
	        document.getElementById('q4').style.display = 'block';
	    }
	    else document.getElementById('q4').style.display = 'none';
	    
	    if (document.getElementById('q2button').checked) {
	        document.getElementById('q2').style.display = 'block';
	    }
	    else document.getElementById('q2').style.display = 'none';
	
	}
	</script>
	
	<title>Bar Owner Queries</title>
	
	<link href="CSS/barOwnerQueries.css" rel="stylesheet" type="text/css">
</head>
<body>
	
	<a id="home" href="main.jsp">HOME</a>
	
	<% 
		String barname = request.getParameter("bar");
		if(barname != null){
			session.setAttribute("bar",barname);
		}
		out.print("<center><h1 class='Queries'>" + session.getAttribute("bar") + "</h1></center>");
	%>
	<center>
	
	<h3 class="Queries">What would you like to see:</h3><br>
	
	<div class="Queries">
		<a onclick="showQueries()" class="butt" id="showOptions" style="cursor:pointer">Run Queries</a>
		<a href="barOwnerUpdates.jsp" class="butt">Update your bar</a>
		
		<div id="options" style="display:none">
			<p> Number of people that have visited your bar by season: <input type="radio" onclick="javascript:showQueries();" name="q1button" id="q1button"> </p>
			<p> Age range of the patrons that frequent your bar: <input type="radio" onclick="javascript:showQueries();" name="q1button" id="q3button"></p>
			<p> Age range of the patrons that have visited your bar: <input type="radio" onclick="javascript:showQueries();" name="q1button" id="q4button"></p>
			<p> Beers liked by Patrons that frequent your bar: <input type="radio" onclick="javascript:showQueries();" name="q1button" id="q2button"></p>	
		</div>
	</div>
	<div id="q1" style="display:none">
			<%
			//List<String> list = new ArrayList<String>();

			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				//Create a SQL statement
				PreparedStatement stmt = con.prepareStatement("SELECT season, COUNT(*) AS patrons FROM visited WHERE bar =? GROUP BY season;");
				stmt.setString(1, (String)session.getAttribute("bar"));
				//Run the query against the database.
				ResultSet result = stmt.executeQuery();
				out.print("<table class='table'>");
				out.print("<tr><th>Season</th> <th>Patrons</th></tr>");

				 while(result.next()){
					 out.print("<tr><td>" + result.getString("season") + "</td><td>" + result.getString("patrons") + "</td></tr>");
				 }
				 out.print("</table>");
			//close the connection.
				result.close();
				stmt.close();
				con.close();
	
			} catch (SQLException e) {
				System.out.println(e.getMessage() + "hello");
			}
			%>
	</div>
	
	<div id="q3" style="display:none">
		<%
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				//Create a SQL statement
				PreparedStatement stmt2 = con.prepareStatement("SELECT ager.AgeRange, COALESCE(TotalWithinRange, 0) AS TotalWithinRange " +
																"FROM(SELECT \"21 - 30\" AS AgeRange UNION SELECT \"31 - 40\" " +
																"UNION SELECT \"41 - 50\" UNION SELECT \"51 - 60\" UNION SELECT \"60 < age\") ager " +
																"LEFT JOIN (SELECT CASE WHEN age >= 21 and age <= 30 then \"21 - 30\" " +
																"WHEN age >= 31 and age <= 40 then \"31 - 40\" " + 
																"WHEN age >= 41 and age <= 50 then \"41 - 50\" " +
																"WHEN age >= 51 and age <= 60 then \"51 - 60\" " + 
																"WHEN age > 60 then \"60 < age\" " +
																" END AS AgeRange, COUNT(*) AS TotalWithinRange " +
																"FROM (SELECT d.age FROM drinkers d, frequents f WHERE d.name = f.drinker AND f.bar =?) x " +
																"GROUP BY 1) y ON ager.AgeRange = y.AgeRange;");
				stmt2.setString(1, (String)session.getAttribute("bar"));
				//Run the query against the database.
				ResultSet result = stmt2.executeQuery();
				out.print("<table class='table'>");
				out.print("<tr><th>AgeRange</th> <th>Patrons</th></tr>");

				 while(result.next()){
					 out.print("<tr><td>" + result.getString("ager.AgeRange") + "</td><td>" + result.getString("TotalWithinRange") + "</td></tr>");
				 }
				 out.print("</table>");
			//close the connection.
				result.close();
				stmt2.close();
				con.close();
	
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
			%>
	</div>
	
	<div id="q4" style="display:none">
		<%
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				//Create a SQL statement
				PreparedStatement stmt3 = con.prepareStatement("SELECT ager.AgeRange, COALESCE(TotalWithinRange, 0) AS TotalWithinRange " +
																"FROM(SELECT \"21 - 30\" AS AgeRange UNION SELECT \"31 - 40\" " +
																"UNION SELECT \"41 - 50\" UNION SELECT \"51 - 60\" UNION SELECT \"60 < age\") ager " +
																"LEFT JOIN (SELECT CASE WHEN age >= 21 and age <= 30 then \"21 - 30\" " +
																"WHEN age >= 31 and age <= 40 then \"31 - 40\" " + 
																"WHEN age >= 41 and age <= 50 then \"41 - 50\" " +
																"WHEN age >= 51 and age <= 60 then \"51 - 60\" " + 
																"WHEN age > 60 then \"60 < age\" " +
																" END AS AgeRange, COUNT(*) AS TotalWithinRange " +
																"FROM (SELECT d.age FROM drinkers d, visited v WHERE d.name = v.drinker AND v.bar =?) x " +
																"GROUP BY 1) y ON ager.AgeRange = y.AgeRange;");
				stmt3.setString(1, (String)session.getAttribute("bar"));
				//Run the query against the database.
				ResultSet result = stmt3.executeQuery();
				out.print("<table class='table'>");
				out.print("<tr><th>AgeRange</th> <th>Patrons</th></tr>");

				 while(result.next()){
					 out.print("<tr><td>" + result.getString("ager.AgeRange") + "</td><td>" + result.getString("TotalWithinRange") + "</td></tr>");
				 }
				 out.print("</table>");
			//close the connection.
				result.close();
				stmt3.close();
				con.close();
	
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
			%>
	</div>
	
	<div id="q2" style="display:none">
	
		<form class="Queries" method="post" action="ownerQ2.jsp">
			Limit to: <select name="limit" size=1> 
				<option value="10">10</option>
				<option value="20">20</option>
				<option value="50">50</option>
				<option value="75">75</option>
				<option value="100">100</option>
				
			</select>  beers
			<br> <input id="subButt" type="submit" value="Submit" name="submit" id="submit">
		</form>	
	</div>
	</center>
	
</body>
</html>
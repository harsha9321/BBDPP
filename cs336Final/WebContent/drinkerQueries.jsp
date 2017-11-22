<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Drinker Queries</title>
	
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
	
	<link href="CSS/drinkerQueries.css" rel="stylesheet" type="text/css">

</head>
<body>

	<a id="home" href="main.jsp">HOME</a>

	<center>
	<div id="blockOne">
		<p>Search for a bar that sell specific beers: <input type="radio" onclick="javascript:showQueries();" name="q1button" id="q1button"></p>
		<p>Let us know what bar you have visited: <input type="radio" onclick="javascript:showQueries();" name="q1button" id="q2button"></p>
	</div>
	</center>
	<div id="q1" style="display:none">
		<center>
		<form id="form" method="post" action="drinkerQ1.jsp">
		
		<%
			//List<String> list = new ArrayList<String>();
	
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				
				//Create a SQL statement
				Statement stmt = con.createStatement();
				String str = "SELECT * FROM beers";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				
				out.print("<p class='blockTwo'> Bars that sell: <select name =\"beer\" size=1 <p>");
				 while(result.next()){
					 out.print("<option value=\"" + result.getString("name") + "\">" + result.getString("name") + "</option>");		
				}
				out.print("</select><br>");
				//close the connection.
				result.close();
				stmt.close();
				con.close();
	
			} catch (SQLException e) {
				out.print("<center><p>There was an internal error with the data base try again</p></center>");
			}
			%>
			
	  		Limit to: <select name="limit" size=1>
	  			<option value="5">5</option> 
				<option value="10">10</option>
				<option value="20">20</option>
				<option value="50">50</option>
				<option value="75">75</option>
				<option value="100">100</option>
				
			</select>  bars
			
			<br><input class="butt" type="submit" value="Submit">
			</form>
		</center>			
	</div>
	
	<div id="q2" style="display:none">
		<center>
		<form id="form" method="post" action="drinkerQ2.jsp">
		
		<%
			//List<String> list = new ArrayList<String>();
	
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				
				//Create a SQL statement
				Statement stmt = con.createStatement();
				String str = "SELECT * FROM drinkers";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				
				out.print("<p class='blockTwo'>My Name is: <select name =\"drinker\" size=1 </p>");
				 while(result.next()){
					 out.print("<option value=\"" + result.getString("name") + "\">" + result.getString("name") + "</option>");		
				}
				out.print("</select><sub><i>&nbsp&nbspIf you dont see your name go back and join our database</i></sub><br>");
				//close the connection.
				result.close();
				stmt.close();
				con.close();
	
			} catch (SQLException e) {
				out.print("<center><p><a href='drinkerQueries.jsp'> There was an internal error with the data base try again</a></p></center>");
			}
			%>
			
		<%
			//List<String> list = new ArrayList<String>();
	
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				
				//Create a SQL statement
				Statement stmt = con.createStatement();
				String str = "SELECT * FROM bars";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				
				out.print("Bar that i visited: <select name =\"drinker\" size=1");
				 while(result.next()){
					 out.print("<option value=\"" + result.getString("name") + "\">" + result.getString("name") + "</option>");		
				}
				out.print("</select><sub><i>&nbsp&nbspIf you dont see your bar, that means it is not a part of our database</i></sub><br>");
				//close the connection.
				result.close();
				stmt.close();
				con.close();
	
			} catch (SQLException e) {
				out.print("<center><p><a href='drinkerQueries.jsp'> There was an internal error with the data base try again</a></p></center>");
			}
			%>
			
		<%
			//List<String> list = new ArrayList<String>();
	
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				
				//Create a SQL statement
				Statement stmt = con.createStatement();
				String str = "SELECT * FROM seasons";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				
				out.print("Season that I visited the bar: <select name =\"drinker\" size=1");
				out.print("<option value=\"fall\">fall</option>");
				 while(result.next()){
					 out.print("<option value=\"" + result.getString("name") + "\">" + result.getString("name") + "</option>");		
				}
				out.print("</select><sub><i>&nbsp&nbspIf you dont see the season that you visited, you are on the wrong planet.</i></sub><br>");
				//close the connection.
				result.close();
				stmt.close();
				con.close();
	
			} catch (SQLException e) {
				out.print("<center><p><a href='drinkerQueries.jsp'> There was an internal error with the data base try again</a></p></center>");
			}
			%>

			<br><input class="butt" type="submit" value="Submit">
			</form>
		</center>			
	</div>
	
</body>
</html>
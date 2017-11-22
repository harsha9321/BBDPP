<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bar Updates</title>

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
	
	<link href="CSS/barOwnerUpdates.css" rel="stylesheet" type="text/css">	
</head>
<body>
	<a id="home" href="main.jsp">HOME</a>
	<div id="test"></div>
	<center>
	<div class="div">
		Add a new beer to sell: <input type="radio" onclick="javascript:showQueries();" name="q1button" id="q1button"><br>
		Add a seasonal modifier to prices: <input type="radio" onclick="javascript:showQueries();" name="q1button" id="q2button"><br>
	</div>
	<div class="div" id="q1" style="display:none">		
		<form method="post" action="newBeer.jsp">
			New Beer Name: <input type="text" name="beer"><br>
			Base Price: <input type="text" name="price"><br>
			<input class="butt" type="submit" value="submit">
		</form>
	</div>
	
	<div class="div" id="q2" style="display:none">
		<form method="post" action="newModifier.jsp">
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
				
				out.print("Season: <select name =\"season\" size=1 <p>");
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
			Modifier: <input type="text" name="modifier"><br>
			<input class="butt" type="submit" value="submit">
		</form>

	</div>
	
	
	</center>

</body>
</html>
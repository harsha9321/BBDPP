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
	
</head>
<body>

	<center>
		Add a new beer to sell: <input type="radio" onclick="javascript:showQueries();" name="q1button" id="q1button"><br>
		Add a seasonal modifier to prices: <input type="radio" onclick="javascript:showQueries();" name="q1button" id="q2button"><br>
	
	<div id="q1" style="display:none">
		hello world
		
		<form method="post" action="newBeer.jsp">
			New Beer Name: <input type="text" name="beer"><br>
			Base Price: <input type="text" name="price"><br>
			<input type="submit" value="submit">
		</form>
	</div>
	
	<div id="q2" style="display:none">
		die in a fire
	</div>
	
	
	</center>

</body>
</html>
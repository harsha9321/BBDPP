<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.ApplicationDB"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Drinker Info Entry</title>
	
	<link href="CSS/DrinkerPage.css" rel="stylesheet" type="text/css">
<script type="text/javascript">	
	function showQueries() {
    if (document.getElementById('form').onclick) {
        document.getElementById('inputForm').style.display = 'block';
    }
    else document.getElementById('q1').style.display = 'none';
}
</script>
</head>
<body>
	<a id="home" href="main.jsp">HOME</a>

	<div id="wrapper">
		
		<h3>User Page</h3>
		<hr>
		<div id="notForm">
			<a onclick="showQueries()" id="form">Become a part of our Database</a>
			<a href="drinkerQueries.jsp" id="lookUp">(Look up bars)</a>
		</div>
		
		<div id="inputForm" style="display:none">
		<form method="post" action="drinkerInput.jsp">
			First Name: <sub><i>(Required)</i></sub> <br>
			<input class="inp" type="text" name="firstname"><br>
			Last Name: <sub><i>(Required)</i></sub><br>  
			<input class="inp" type="text" name="lastname"><br>
			Age: <sub><i>(Must be over 21)</i></sub><br>
			<input class="inp" type="text" name="age"><br>
			Gender:<br>
			<select name="gender" size=1>
				<option value="M">Male</option>
				<option value="F">Female</option>
			</select><br>
			<br><input id= "butt" type="submit" value="Submit">
			</form>
		</div>
	</div>

</body>
</html>
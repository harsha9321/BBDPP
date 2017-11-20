<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Drinker Info Entry</title>
	
	<link href="CSS/DrinkerPage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrapper">
		
		<h3>User page</h3>
		<hr>
		<form method="post" action="drinkerInput.jsp">
			First Name: <br>
			<input class="inp" type="text" name="firstname"><br>
			Last Name:<br>  
			<input class="inp" type="text" name="lastname"><br>
			Age: <br>
			<input class="inp" type="text" name="age"><br>
			Gender:<br>
			<select name="gender" size=1>
				<option value="M">Male</option>
				<option value="F">Female</option>
			</select><br>
			<br><input id= "butt" type="submit" value="Submit">
			</form>
		
	</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="com.google.gson.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Graph Test</title>
		
		<script type="text/javascript" src="C:/Users/Patrick_2/workspace_BID/cs336Final/fusioncharts/fusioncharts.js"></script>
		<script type="text/javascript" src="C:/Users/Patrick_2/workspace_BID/cs336Final/fusioncharts/fusioncharts.theme.ocean.js"></script>
		
		<script type="text/javascript">
		Gson gson = new Gson();
        
        // Form the SQL query that returns the top 10 most populous countries
        String sql="SELECT Name, Population FROM Country ORDER BY Population DESC LIMIT 10";
		</script>
			
	</head>
	<body>
		<div id="chart"></div>
	</body>
</html>
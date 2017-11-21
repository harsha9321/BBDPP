<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="com.google.gson.*" %>

<%@page import="fusioncharts.FusionCharts" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Graph Test</title>
		
		<script type="text/javascript">
		
			<?php 
				/* Open connection to "zing_db" MySQL database. */
				$mysqli = new mysqli("jdbc:mysql://bar-beer-drinker-plus.cix4c2nzx8tc.us-east-2.rds.amazonaws.com:3306", "cs336", "password", "BarBeerDrinkersPlusPlus");
				 
				/* Check the connection. */
				if (mysqli_connect_errno()) {
				    printf("Connect failed: %s\n", mysqli_connect_error());
				    exit();
				}		
			
			var myData=[<?php 
			while($info=mysqli_fetch_array($data))
			    echo $info['f_data'].','; \ ?>];
			
			$data=mysqli_query($mysqli,"select age, count(*) as count from drinkers group by age asc");
			?>
			var myLabels=[<?php 
			while($info=mysqli_fetch_array($data))
			    echo '"'.$info['f_name'].'",'; ?>];
			
			
				$mysqli->close(); 
			?>
			
			
			
			window.onload=function(){
			zingchart.render({
			    id:"myChart",
			    width:"100%",
			    height:400,
			    data:{
			    "type":"bar",
			    "title":{
			        "text":"Drinker Ages"
			    },
			    "scale-x":{
			        "labels":myLabels
			    },
			    "series":[
			        {
			            "values":myData
			        }
			]
			}
			});
			};
			
			
		</script>
	
	</head>
	<body>
		<div id="myChart"></div>		
	</body>
</html>
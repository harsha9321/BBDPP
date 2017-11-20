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
		<!-- 
			<script type="text/javascript" src="C:/Users/Patrick_2/workspace_BID/cs336Final/fusioncharts/fusioncharts.js"></script>
		-->
		<script type="text/javascript" src="fusioncharts/js/fusioncharts.js"></script>
		<script type="text/javascript" src="C:/Users/Patrick_2/workspace_BID/cs336Final/fusioncharts/fusioncharts.theme.ocean.js"></script>			
	
		<script type="text/javascript" src="C:/Users/Patrick_2/workspace_BID/cs336Final/fusioncharts/fusioncharts.js"></script>
		<script src="fusioncharts.js"></script>
	
	</head>
	<body>
		<div id="chart"></div>
		
		<%
			String hostdb = "jdbc:mysql://bar-beer-drinker-plus.cix4c2nzx8tc.us-east-2.rds.amazonaws.com:3306/BarBeerDrinkersPlusPlus";  // MySQl host
			String userdb = "cs336";  // MySQL username
			String passdb = "password";  // MySQL password
			String namedb = "BarBeerDrinkersPlusPlus";  // MySQL database name
			
			// Establish a connection to the database
		    DriverManager.registerDriver(new com.mysql.jdbc.Driver());
		    Connection con = DriverManager.getConnection("jdbc:mysql://" + hostdb + "/" + namedb , userdb , passdb);
		%>
		
		<%
			Gson gson = new Gson();
			        
	        
	        // Form the SQL query that returns the top 10 most populous countries
	        String sql="select age, count(*) as count from drinkers group by age asc";
	
	        // Execute the query.
	        PreparedStatement pt=con.prepareStatement(sql);    
	        ResultSet rs=pt.executeQuery();
	        
	        Map<String, String> chartobj = new HashMap<String, String>();
	        
	        chartobj.put("caption" , "All ages that Frequent the Bars");
	        chartobj.put("paletteColors" , "#0075c2");
	        chartobj.put("bgColor" , "#ffffff");
	        chartobj.put("borderAlpha", "20");
	        chartobj.put("canvasBorderAlpha", "0");
	        chartobj.put("usePlotGradientColor", "0");
	        chartobj.put("plotBorderAlpha", "10");
	        chartobj.put("showXAxisLine", "1");
	        chartobj.put("xAxisLineColor" , "#999999");
	        chartobj.put("showValues" , "1");
	        chartobj.put("divlineColor" , "#999999");
	        chartobj.put("divLineIsDashed" , "1");
	        chartobj.put("showAlternateHGridColor" , "0");
	        
	     // Push the data into the array using map object.
	        ArrayList arrData = new ArrayList();
	        while(rs.next())
	        {
	            Map<String, String> lv = new HashMap<String, String>();
	            lv.put("label", rs.getString("Ages"));
	            lv.put("value", rs.getString("Count"));
	            arrData.add(lv);             
	        }
	        
	        //close the connection.
	        rs.close();

	        //create 'dataMap' map object to make a complete FC datasource.
	        
	         Map<String, String> dataMap = new LinkedHashMap<String, String>();  
	    /*
	        gson.toJson() the data to retrieve the string containing the
	        JSON representation of the data in the array.
	    */
	         dataMap.put("chart", gson.toJson(chartobj));
	         dataMap.put("data", gson.toJson(arrData));
	         
	         FusionCharts column2DChart= new FusionCharts(
	                    "column2d",// chartType
	                    "chart1",// chartId
	                    "600","400",// chartWidth, chartHeight
	                    "chart",// chartContainer
	                    "json",// dataFormat
	                    gson.toJson(dataMap) //dataSource
	                );
		%>
		
	</body>
</html>
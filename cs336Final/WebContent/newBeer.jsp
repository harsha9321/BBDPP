<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
	
	<link href="CSS/newBeer.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div>
		<a id="home" href="main.jsp">HOME</a>
	</div>

	<%
		String bar = (String)session.getAttribute("bar");
		String beer = request.getParameter("beer");
		if(beer.compareTo("") == 0){
			out.print("<center><h2>Beer name cannot be blank.</h2></center>");
		}
		else{
			try{
				double baseprice = Double.parseDouble(request.getParameter("price"));
				
				if(baseprice < 0){
					out.print("<center><h2>Price need to be greater then 0</h2></center>");
				}
				else{
					try{
						//Get the database connection
						ApplicationDB db = new ApplicationDB();	
						Connection con = db.getConnection();
						Connection con2 = db.getConnection();
						Connection con3 = db.getConnection();

						//Create a SQL statement
						Statement stmt = con.createStatement();
						Statement stmt4 = con2.createStatement();
						
						String[] seasons = new String[4];
						seasons[0] = "fall";
						seasons[1] = "spring";
						seasons[2] = "summer";
						seasons[3] = "winter";

						//Populate SQL statement with an actual query. It returns a single number. The number of beers in the DB.
						String str = "SELECT * FROM beers";
						boolean status = false;
						//Run the query against the DB
						try{
							ResultSet result = stmt.executeQuery(str);
						
						//Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
						while(result.next()){
							if(result.getString("name").compareTo(beer) == 0){
								status = true;
							}
						}
						
						result.close();
						stmt.close();
						} catch(SQLException e){
							out.print(e.getMessage() + "fail 4");
						}
						if(status == true){
							ResultSet result2 = stmt4.executeQuery("SELECT beer FROM sells WHERE bar = '" + bar + "';");
							boolean status2 = false;
							while(result2.next()){
								if(result2.getString("beer").compareTo(beer) == 0){
									status2 = true;
								}
							}
							result2.close();
							stmt4.close();
							if(status2 == true){
								out.print("<center><h2>" + bar + " already sells " + beer +"</h2></center>");
							} else if(status2 == false){
								try{
									PreparedStatement stmt1 = con2.prepareStatement("INSERT INTO sells VALUES (?, ?, TRUNCATE(?, 2))");
									stmt1.setString(1, bar);
									stmt1.setString(2, beer);
									stmt1.setDouble(3, baseprice);
									stmt1.executeUpdate();
									out.print("<center><h2>You now sell " + beer + "</h2></center>");
									for(int i = 0; i < seasons.length; i++){
									PreparedStatement stmt5 = con3.prepareStatement("INSERT INTO seasonalprices VALUES (?, ?, ?, TRUNCATE((SELECT (? * modifer) FROM seasonalModifer WHERE bar = ? AND season = ?), 2)); ");
									stmt5.setString(1, bar);
									stmt5.setString(2, beer);
									stmt5.setString(3, seasons[i]);
									stmt5.setDouble(4, baseprice);
									stmt5.setString(5, bar);
									stmt5.setString(6, seasons[i]);
									stmt5.executeUpdate();
									stmt5.close();
									}
									stmt1.close();
									
								} catch(SQLException e){
									out.print(e.getMessage() + " fail 1");
								}								
							}	
						}else if(status == false){
							try{
								PreparedStatement stmt3 = con2.prepareStatement("INSERT INTO beers VALUES (?)");
								stmt3.setString(1, beer);
								stmt3.executeUpdate();
								
								PreparedStatement stmt2 = con2.prepareStatement("INSERT INTO sells VALUES (?, ?, TRUNCATE(?, 2))");
								stmt2.setString(1, bar);
								stmt2.setString(2, beer);
								stmt2.setDouble(3, baseprice);
								stmt2.executeUpdate();
								
								for(int i = 0; i < seasons.length; i++){
									PreparedStatement stmt6 = con3.prepareStatement("INSERT INTO seasonalprices VALUES (?, ?, ?, TRUNCATE((SELECT (? * modifer) FROM seasonalModifer WHERE bar = ? AND season = ?), 2)); ");
									stmt6.setString(1, bar);
									stmt6.setString(2, beer);
									stmt6.setString(3, seasons[i]);
									stmt6.setDouble(4, baseprice);
									stmt6.setString(5, bar);
									stmt6.setString(6, seasons[i]);
									stmt6.executeUpdate();
									stmt6.close();
									}
								
								out.print("<center><h2>" + beer + " is a new beer.<br></h2></center>");
								out.print("<center><h2>You now sell " + beer + "</h2></center>");
								
								stmt3.close();
								stmt2.close();
	
							}catch(SQLException e){
								out.print(e.getMessage()+ " fail 2");
							}
							
						}
						con.close();
						con2.close();
						con3.close();
						
					}catch(SQLException e){
						out.print(e.getMessage() + " fail 3");
					}
					
				}				
			}catch(Exception e){
				out.print("<center><h2>Price need to be a number.</h2></center>");
			}
				
		}
	
%>
</body>
</html>
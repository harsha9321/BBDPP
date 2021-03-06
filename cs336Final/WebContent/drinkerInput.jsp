<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Drinker Input status</title>
		
		<link href="CSS/drinkerInput.css" rel="stylesheet" type="text/css">
	</head>
	<body>
	
		<a id="home" href="main.jsp">HOME</a>
		<div id="wrapper"> 
			<%
				List<String> list = new ArrayList<String>();
				
				try {
		
					//Get the database connection
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();	
					
					//Create a SQL statement
					Statement stmt = con.createStatement();
					//Get the combobox from the index.jsp
					String fname = request.getParameter("firstname");
					String lname = request.getParameter("lastname");
					String ageinput = request.getParameter("age");
					String gender = request.getParameter("gender");
					//System.out.println(gender);
					if(fname.compareTo("") == 0 || lname.compareTo("")== 0){
						out.print("<center><p>First and or Last name were left blank</p></center>");
					}
					else {
					try{
						int age = Integer.parseInt(ageinput);
						//out.println("<p>ageInt:  " + age + "</p>" );
						if(age < 21){
							out.print("<center><p>It seems you are not 21, come back in a few years</p></center>");
						}
						else{
							boolean validName = true;
							String wholeName = fname.trim() + " " + lname.trim();
							String str = "SELECT * FROM drinkers";
							ResultSet result = stmt.executeQuery(str);
		
							while(result.next()){
								if(wholeName.compareTo(result.getString("name")) == 0){
									validName = false;
									break;
								}
							}
							result.close();
							if(validName == false){
								out.print("<center><p><a href='drinkerPage.jsp'>Drinker already Exists in the database Duplicate names are not allowed \n Try again</p></a></center>");
							}
							else{
								//insert into database
								PreparedStatement insertStament = con.prepareStatement("INSERT INTO drinkers VALUES(?, ?, ?)");
								insertStament.setString(1, wholeName);
								insertStament.setInt(2, age);
								insertStament.setString(3, gender);
								insertStament.execute();
								out.print("<center><p>Welcome Drinker, you have been entered to the database.</p><br></center>");
								Random rand = new Random();
								out.print("<center><p>Here is your coupon code: " + (rand.nextInt(1000000 + 1) + 100000) + "</p></center>");
								insertStament.close();
							}
						}
						
					} catch(Exception e) {
						System.out.println(e.getLocalizedMessage() + "\n" +e.getStackTrace() +"hello");
						//out.println(e.getMessage());
						out.print("<center><p><a href='drinkerPage.jsp'> Age is not a number, try again, I know it is hard to type when you are drunk</a></p></center>");
					}
					
					//close the connection.
					
					stmt.close();		
					con.close();
					}
				} catch (Exception e) {
					System.out.println(e.getStackTrace() + "hello2");
				}
				%>
		</div>
	</body>
</html>
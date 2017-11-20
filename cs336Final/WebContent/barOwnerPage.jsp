<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BarOwnerView</title>
</head>
<body>
	<center>
	<p>Hello Bar Owner, Select the bar you own:</p><br>
	
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp

			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM bars";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			out.print("<select name =\"bar\" size=1");
			 while(result.next()){
				 out.print("<option value=\"" + result.getString("name") + "\">" + result.getString("name") + "</option>");
				 
				
		}
		

			//close the connection.
			con.close();

		} catch (Exception e) {
			System.out.println(e.getStackTrace());
		}
		%>
	</center>

</body>
</html>
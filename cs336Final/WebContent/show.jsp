<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
	<%
			List<String> list = new ArrayList<String>();
	
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				
				//Create a SQL statement
				Statement stmt = con.createStatement();
				String str = "SELECT * FROM seasons";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				while(result.next()){
					list.add(result.getString("name"));
				}
				int i = 0;
				out.print("Season that I visited the bar: <select name =\"drinker\" size=1");
				 while(result.next()) {
					 out.print("<option value=\"" + list.get(i) + "\">" + list.get(i) + "</option>");
					 i++;
				}
				out.print("</select><sub><i>If you dont see the season that you visited, you are on the wrong planet.</i></sub><br>");
				//close the connection.
				con.close();
	
			} catch (SQLException e) {
				out.print("<center><p><a href='drinkerQueries.jsp'> There was an internal error with the data base try again</a></p></center>");
			}
			%>

</body>
</html>
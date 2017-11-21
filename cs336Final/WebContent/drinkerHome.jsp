<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">	
	function showQueries() {
    if (document.getElementById('q1button').checked) {
        document.getElementById('q1').style.display = 'block';
    }
    else document.getElementById('q1').style.display = 'none';
    
    if (document.getElementById('q2button').checked) {
        document.getElementById('something').style.display = 'block';
    }
    else document.getElementById('something').style.display = 'none';
    if(document.getElementByID('submit').checked) {
    	document.getElementByID('q2').style.display = 'block';
    }
    else document.getElementByID('q2').style.display = 'none';
}
</script>
</head>
<body>
	<center>
	<a onclick="showQueries()">Become a part of our database</a>
	<a href="drinkerQuery.jsp">Look up bars</a>
	</center>
</body>
</html>
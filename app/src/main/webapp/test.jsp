<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.Connection"%>
<%@ page import="hms.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Test Page</title>
</head>
<body>
<%! 
Connection conn = DBConn.createConn();
%>
<h1><%
String test = "No Database";
if (conn != null){
	test = "Database";
}
out.print(test);
%></h1>
</body>
</html>
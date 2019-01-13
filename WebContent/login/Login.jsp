<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,domain.*"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录-WOrkGether</title>
<script type="text/javascript" src="../cookie.js"></script>
</head>
<body>

<%  String type=request.getParameter("type");
	String account=request.getParameter("account");
	String password=request.getParameter("password");
	
	PrintWriter pw=response.getWriter();
	
	String result=Login.checkAccount(account, password);
	pw.print(result);
	pw.close();%>
	   


</body>
</html>
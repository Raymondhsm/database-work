<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,domain.*,java.text.DecimalFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="logged.css" />
<script type="text/javascript" src="../cookie.js"></script>
<script type="text/javascript" src="../iframe.js"></script>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
  
  <style type="text/css"> 
body,table{ 
font-size:12px; 
} 
table{ 
table-layout:fixed; 
empty-cells:show; 
border-collapse: collapse; 
margin:0 auto; 
} 
td{ 
height:30px; 
text-align:center;
} 
h1,h2,h3{ 
font-size:12px; 
margin:0; 
padding:0; 
} 
.table{ 
border:1px solid #cad9ea; 
color:#666; 
} 
.table th { 
background-repeat:repeat-x; 
height:30px; 
} 
.table td,.table th{ 
border:1px solid #cad9ea; 
padding:0 1em 0; 
} 
.table tr.alter{ 
background-color:#f5fafe; 
} 
</style> 
</head>

<%
String id=request.getParameter("id");
String sdate=request.getParameter("sdate");
String edate=request.getParameter("edate");

String a[];
int b[][];

if(id.equals("1")){
	a=Report.getStaffName();
	b=Report.getPersonReport(sdate, edate);
}else{
	a=Report.getDeptName();
	b=Report.getDeptReport(sdate, edate);
}

DecimalFormat df = new DecimalFormat("0.00");
%>


<body style="background:none">

<table border="1" style="width:90%" class="table">
<tr>
<th>名称</th>
<th>日志总数</th>
<th>参与任务总数</th>
<th>收到缺写提醒总数</th>
<th>日志缺写率</th>
</tr>
<%for(int i=0;i<a.length;i++){ %>
<tr class="<%=i%2==0?"":"alter"%>">
<td><%=a[i] %></td>
<td><%=b[0][i] %></td>
<td><%=b[1][i] %></td>
<td><%=b[2][i] %></td>
<td><%=df.format((b[3][i]!=0?(1-(double)b[0][i]/(double)b[3][i])*100:0))+"%" %>
</tr>
<%} %>
</table>
		
</body>

<script type="text/javascript">
</script>
</html>
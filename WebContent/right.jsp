<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,domain.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="setup/setup.css" />
<script type="text/javascript" src="cookie.js"></script>
<script type="text/javascript" src="iframe.js"></script>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
</head>
<body>

<%
	Cookie cookies[]=request.getCookies(); //读出用户硬盘上的Cookie，并将所有的Cookie放到一个cookie对象数组里面
	Cookie sCookie=null; 
	String skey="";
	for(int i=0;i<cookies.length;i++){    //用一个循环语句遍历刚才建立的Cookie对象数组
		sCookie=cookies[i];   //取出数组中的一个Cookie对象
		if(sCookie!=null){
  			if(("skey").equals(sCookie.getName())){      
	    		skey=sCookie.getValue();
    			break;
    		}
  		}
	
	}
	if(skey.equals("")){%><script>alert("weidenglu")</script><%
	}


if(Login.isLoggedCheck(skey)){%>
<div class="right" style="float:none;margin-top:15px;overflow:hidden;">
	<p style="background:#3399ff;margin:0 auto;text-align:center;'">今日缺写提醒</p>
<%String b[][]=logged.getNeedLogged(skey);
	for(int i=0;i<b.length;i++){%>
	<div class="logged" style="height:auto;overflow:hidden;margin-bottom:0;">
		<p class="taskName" style="width:100%;"><%=b[i][1] %></p><br><br>
		<%if(i!=0)i--;
		do{%>
		<div style="margin-bottom:10px;overflow:hidden;">
			<p style="float:left;width:70%;"><%=b[i][3] %></p>
			<%if(!logged.isNeedLogged(b[i][0],b[i][2])){ %><button class="btnWrite" id=<%="send"+b[i][0]+b[i][2]%> style="width:60px;" onclick="Send(<%=b[i][0]%>,<%=b[i][2]%>)">发送</button>
			<%}else{ %><button class="btnWrite" style="width:60px;")">已发送</button><%} %>
		</div>
		<%}while(i<b.length-1&&b[i][1].equals(b[++i][1]));System.out.println(i); %>
	</div>
<%} 
if(b.length==0){%>
		<p style="text-align:center;margin:15px auto;">今天各部门的任务都完成了哦~~</p>
<%} %>
</div>
<%} %>


<div class="right" style="float:none;margin-top:15px;border-top:8px solid #3399ff;">
	<p style="background:#3399ff;margin:0 auto;text-align:center;'">今日收到缺写提醒</p>
	<%String c[]=logged.getMyNeedLogged(skey);
	for(int i=0;i<c.length;i++){%>
	<div class="logged" >
		<div class="top">
			<p class="taskName"><%=c[i] %></p>
			<button class="btnWrite" onclick="toWrite()">填写</button>
		</div>
	</div>	
	<%} 
	if(c.length==0){%>
		<p style="text-align:center;margin:15px auto;">今天没有收到缺写提醒哦~~</p>
	<%} %>
</div>


<div class="right" style="float:none;margin-top:15px;border-top:8px solid #3399ff;">
	<p style="background:#3399ff;margin:0 auto;text-align:center;'">今日待写日志</p>
	<%String a[][]=logged.getLoggedforWrite(skey);
	for(int i=0;i<a.length;i++){%>
	<div class="logged" >
		<div class="top">
			<p class="taskName"><%=a[i][1] %></p>
			<button class="btnWrite" onclick="toWrite()">填写</button>
		</div>
	</div>	
	<%} 
	if(a.length==0){%>
		<p style="text-align:center;margin:15px auto;">今天任务完成了哦~~</p>
	<%} %>
</div>

<script type="text/javascript">
	function Send(taskID,deptID){
		$.ajax({
			type:"GET",
			url:"NeedLogged",
			data:{
				skey:getCookie("skey"),
				taskID:taskID,
				deptID:deptID
			},
			dataType:"text",
			
			success:function(){
				$("#send"+taskID+deptID).text("已发送");
			}
			
		})
	}
	
	function toWrite(){
		window.parent.location.href="logged/logged.jsp"
	}
</script>

</body>
</html>
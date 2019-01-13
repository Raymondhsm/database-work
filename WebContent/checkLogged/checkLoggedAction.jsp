<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,domain.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="checkLogged.css" />
<script type="text/javascript" src="../cookie.js"></script>
<script type="text/javascript" src="../iframe.js"></script>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
</head>
<title>Insert title here</title>
</head>
<body style="background:none">

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
	if(skey.equals("")){%><script>alert(weidenglu)</script><%
		}

	String[][] a;
	int id=Integer.valueOf(request.getParameter("id")); 

	if(!Login.isLoggedCheck(skey)){ %><p style="color:grey;font-size:15px;margin:20px auto;text-align:center;">你暂无权限进行该操作，如有疑问请联系系统管理员</p>
<%}else{
	if(id==1||id==2)a=logged.getLoggedforCheck(skey,id);
	else a=logged.getLoggedforCheck(skey, id, request.getParameter("key"));
%>


		<br>
		
		<div style="overflow: hidden;width:100%;">
		<%if(a.length==0&&id==1){ %><p style="color:grey;font-size:15px;margin:20px auto;text-align:center;">暂时没有日志待审核哦，去其他地方看看吧</p><%} %>
		<%if(a.length==0&&id==2){ %><p style="color:grey;font-size:15px;margin:20px auto;text-align:center;">暂时没有日志已审核哦，去其他地方看看吧</p><%} %>
		<%for(int i=0;i<a.length;i++){ %>
			<div class="logged-list">
			    <div class="row-header">
					<p class="row-header-info"><%=a[i][1] %></p>
				</div>
				<div class="row">
			    	<p class="row-title">作者姓名：</p>
					<p class="row-info"><%=a[i][2] %></p>
				</div>
				<div class="row">
			    	<p class="row-title">工作量：</p>
					<p class="row-info"><%=a[i][3] %></p>
				</div>
				<div class="row">
			    	<p class="row-title">工作进度：</p>
					<p class="row-info"><%=a[i][4]%></p>
				</div>
				<div class="row">
			    	<p class="row-title">应填时间：</p>
					<p class="row-info"><%=a[i][6] %></p>
				</div>
				<div class="row">
			    	<p class="row-title">填写时间：</p>
					<p class="row-info"><%=a[i][7] %></p>
				</div>
				<div class="row">
			    	<p class="row-title">备注：</p>
					<p class="row-info"><%=a[i][5] %></p>
				</div>
				<div class="row" style="margin-top: 15px;">
					<p class="row-title">审核评语：</p>
					<p class="row-info"><%=a[i][8] %></p>
				</div>
				
				<%if(id==1||id==3){ %>
				<div class="row" style="margin-bottom: 15px;">
					<button  class="heng-btn" style="margin-left:160px;" onclick="pass(2,<%=a[i][0]%>)">不通过</button>
					<button class="heng-btn" onclick="pass(1,<%=a[i][0]%>)">通过</button>
				</div>
				<%}else if(a[i][9].equals("1")){ %>
				<div class="row" style="margin-bottom: 15px;">
					<button class="heng-btn" style="margin-left:40%;color: black;" disabled="true">已通过</button>
					<p style="width: 80px;font-size: 10px;float: left;color: grey;margin: 23px 0 0 13px;cursor: pointer;" onclick="pass(2,<%=a[i][0]%>)">更改为不通过</p>
				</div>
				<%} else{%>
				<div class="row" style="margin-bottom: 15px;">
					<button class="heng-btn" style="margin-left:40%;color: black;" disabled="true">已不通过</button>
					<p style="width: 80px;font-size: 10px;float: left;color: grey;margin: 23px 0 0 13px;cursor: pointer;" onclick="pass(1,<%=a[i][0]%>)">更改为通过</p>
				</div>
				<%}%>

			</div><!--å¤§æ¡-->
			<%} %>
		</div><!--ä¸­é¨ä»»å¡æ¡-->
		
	<%} %>	
		<script type="text/javascript">
			function pass(i,loggedID){
				console.log("123");
				$.ajax({
					type:"GET",
					url:"../CheckLogged",
					data:{
						result:i,
						loggedID:loggedID
					},
					dataType:"text",
					
					success:function(data){
						console.log(data);
						window.location.reload();
					}

				});
				
			}
		</script>
</body>
</html>
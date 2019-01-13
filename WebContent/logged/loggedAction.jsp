<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,domain.*"%>
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
</head>


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

	String[][] a;
	int id=Integer.valueOf(request.getParameter("id")); 
	if(id==1)a=logged.getLoggedforWrite(skey);
	else if(id==2)a=logged.getLoggedWriten(skey);
	else if(id==3)a=logged.getLoggedforWrite(skey,request.getParameter("key"));
	else a=logged.getLoggedWriten(skey, request.getParameter("key"));
%>


<body style="background:none">
<%if(a.length==0&&(id==1||id==3)){ %><p style="color:grey;font-size:15px;margin:20px auto;text-align:center;">暂时没有日志待填写哦，去其他地方看看吧</p><%} %>
<%if(a.length==0&&(id==2||id==4)){ %><p style="color:grey;font-size:15px;margin:20px auto;text-align:center;">暂时没有日志已填写哦，去其他地方看看吧</p><%} %>
<%if(id==2||id==4){ 
	for(int i=0;i<a.length;i++){%>
	<div class="logged-row" id="<%="smallShow"+i%>">
		<p class="logged-name"><%=a[i][1]%></p>
		<p class="logged-level"><%=a[i][5] %></p>
		<p class="logged-source" style="float:left;min-width: 30px;margin:7px 10px 0 20px;"><%=(a[i][8].equals("0")?"待审核":(a[i][8].equals("1")?"已通过":"未通过")) %></p>
		<img src="../image/down.png" class="logo" onclick="down(<%=i%>)">
		<img src="../image/delete.png" onclick="Delete(<%=a[i][0] %>)" class="logo">
	</div><!--å¾åæ¡-->

	<div class="logged-list" id="<%="bigShow"+i%>">
			
		<div class="row-header">
			<p class="row-header-info"><%=a[i][1] %></p>
			<img src="../image/up.png" class="logo" onclick="up(<%=i%>)">
			<img src="../image/delete.png" onclick="Delete(<%=a[i][0] %>)" class="logo">
		</div>
		<div class="row">
    		<p class="row-title">工作量：</p>
			<p class="row-info"><%=a[i][2] %></p>
		</div>
		<div class="row">
	    	<p class="row-title">工作进度：</p>
			<p class="row-info"><%=a[i][3] %></p>
		</div>
		<div class="row">
		   	<p class="row-title">应填日期：</p>
			<p class="row-info"><%=a[i][4] %></p>
		</div>
		<div class="row">
		 	<p class="row-title">填写日期：</p>
			<p class="row-info"><%=a[i][5] %></p>
		</div>
		<div class="row">
		  	<p class="row-title">备注：</p>
			<p class="row-info"><%=a[i][6] %></p>
		</div>
		<div class="row">
		  	<p class="row-title">审核评语：</p>
			<p class="row-info"><%=a[i][7] %></p>
		</div>
		<div class="row">
		  	<p class="row-title">审核结果：</p>
			<p class="row-info"><%=(a[i][8].equals("0")?"待审核":(a[i][8].equals("1")?"已通过":"未通过")) %></p>
		</div>
	</div><!--å¤§æ¡-->
	
<%}
}else{ 
	for(int i=0;i<a.length;i++){%>
		<div class="logged-row">
			<p class="logged-name"><%=a[i][1] %></p>
			<img src="../image/pen.png" onclick="write()" class="logo">
		</div>

		<div class="create-logged" id="createlogged" style="margin-bottom:15px;">
			<div class="heng">
				<p class="heng-text">工作量：</p>
				<input type="text" id=<%="workload"+i%> class="heng-input">
			</div>
			<div class="heng">
				<p class="heng-text">工作进度：</p>
				<input type="text" id=<%="rate"+i%> class="heng-input">
			</div>
			<div class="heng" style="height: 70px;">
				<p class="heng-text">备注：</p>
				<textarea type="text" id=<%="remark"+i%> class="heng-input" style="height: 60px;"></textarea>
			</div>

			<div class="heng" style="margin-bottom:10px;">
				<button class="heng-btn" style="margin-left:160px;">取消</button>
				<button class="heng-btn" onclick="create(<%=i%>,<%=a[i][0]%>)">确定</button>
			</div>
		</div><!--åå»ºæ¡-->
<%}	} %>



		
</body>
<script type="text/javascript">
function create(i,taskID){
	$.ajax({
		type:"GET",
		url:"../CreateLogged",
		data:{
			taskID:taskID,
			workload:$("#workload"+i).val(),
			rateOfProcess:$("#rate"+i).val(),
			needTime:new Date().toLocaleDateString(),
			remark:$("#remark"+i).val(),
			skey:getCookie("skey")
		},
		dataType:"text",
		
		success:function(){
			console.log(12121212);
			window.location.reload();	
		}
	});
}
	
	function down(i){
		document.getElementById("bigShow"+i).style.display="";
		document.getElementById("smallShow"+i).style.display="none";
	}
	
	function up(j){
		document.getElementById("bigShow"+j).style.display="none";
		document.getElementById("smallShow"+j).style.display="";
	}
	
	function Delete(loggedID){
		$.ajax({
			type:"GET",
			url:"../DeleteLogged",
			data:{
				loggedID:loggedID
			},
			dateType:"json",
			
			success:function(data){
				console.log(data);
				window.location.reload();
			}
		});
	}
	
	window.onload=function(){
		
		<%if(id==2||id==4) 
			for(int i=0;i<a.length;i++){%>
				$("#bigShow"+<%=i%>).hide();
			<%}%>
	}
</script>
</html>
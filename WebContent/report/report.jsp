<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,domain.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WorkGether</title>
<link rel="stylesheet" type="text/css" href="report.css" />
<script type="text/javascript" src="../cookie.js"></script>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
</head>
<body>
<%
	Cookie cookies[]=request.getCookies(); //读出用户硬盘上的Cookie，并将所有的Cookie放到一个cookie对象数组里面
	Cookie sCookie=null; 
	String skey="";
	for(int i=0;i<cookies.length-1;i++){    //用一个循环语句遍历刚才建立的Cookie对象数组
		sCookie=cookies[i];   //取出数组中的一个Cookie对象
		if(sCookie!=null){
      		if(("skey").equals(sCookie.getName())){      
        		skey=sCookie.getValue();
        		break;
        	}
      	}
   	}
%>

<div class="header">
	<p style="margin-top:7px;;margin-left:75%; float:left;font-size:22px;color:#2299ff;"><%=Login.getStaffName(skey) %></p>
	<img src="../image/logout.png" class="logo" style="float:left;margin-left:7px;margin-top:9px;" onclick="logout()">
	<img src="../image/question.png" class="logo" style="float:left;margin-left:7px;margin-top:9px;">
</div>

<div class="body">
	<div class="left">
	<script type="text/javascript">
			function left(i){
				switch(i){
				case 1:
					window.location.href="../setup/setup.jsp";
					break;
				case 2:
					window.location.href="../task/task.jsp";
					break;
				case 3:
					window.location.href="../logged/logged.jsp";
					break;
				case 4:
					window.location.href="../checkLogged/checkLogged.jsp";
					break;
				case 5:
					break;
				}
			}
		</script>
	
		<div class="left-outer"><p class="left-inner" onclick="left(1)">基础设置</p></div>
		<div class="left-outer"><p class="left-inner" onclick="left(2)">任务管理</p></div>
		<div class="left-outer"><p class="left-inner" onclick="left(3)">日志填写</p></div>
		<div class="left-outer"><p class="left-inner" onclick="left(4)">日志审核</p></div>
		<div class="left-outer"><p class="left-inner" onclick="left(5)">报表生成</p></div>
		
	</div>

	<div class="middle" style="min-height:600px;height:auto;">
		<div class="list">
		</div><!--ä¸­é¨å¤´-->
		
		<div style="border:2px solid #3399ff;border-radius: 16px;overflow:hidden;">
			<select id="sel" style="width:15%;height:30px;float:left;margin:0 0 0 10%;border:none;border-right:1px solid #80808042;">
				<option value="1">个人报表</option>
				<option value="2">部门报表</option>
			</select>
			
			<div style="width:70%;float:left;">
			<p style="width:15%;margin:5px 0 0 5%;float:left;">FROM:</p>
			<input type="date" id="sdate" style="width:25%;height:26px;float:left;border:none;margin-top:2px">
			<p style="width:10%;margin:5px 0 0 0;float:left;">TO:</p>
			<input type="date" id="edate" style="width:25%;height:26px;float:left;border:none;margin-top:2px">
			<img src="../image/search.png" onclick="Rsearch()" class="logo" style="float:left;margin-top:3px;border-left:1px solid #80808042;">
			</div>
		</div>

		<br>
		<br>
		
		<div style="overflow: hidden;min-height:600px;height:auto;">
			<iframe name="tabframe" frameborder=0 scrolling=no HEIGHT=auto WIDTH=100% id="iframe"></iframe>
		</div><!--å·²åæ¡-->


			
	</div><!--ä¸­é¨-->

	<div class="right" style="border:none;width:256px;">
		<iframe src="../right.jsp" name="tabframe" frameborder=0 scrolling=no HEIGHT=auto WIDTH=100% id="iframe">
		</iframe><!-- tab -->
	</div><!--å³é¨-->
</div>

<div class="tail">
	<h6 class="tailtext">Copyright © 2018 XiaoMing All Rights Reserved.</h6>
</div>

<script type="text/javascript">
	window.onload=function(){
		if(getCookie("skey")==null)window.location.href="../login/login.html";
	}
	
	function logout(){
		clearCookie("skey");
		window.location.href="../login/login.html";
	}

	function Rsearch(){
		$("#iframe").attr('src',"reportAction.jsp?id="+$("#sel").val()+"&sdate="+$("#sdate").val()+"&edate="+$("#edate").val());
	}
</script>

</body>
</html>
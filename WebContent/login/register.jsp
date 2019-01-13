<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,domain.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WorkGether</title>
<link rel="stylesheet" type="text/css" href="../task/task.css" />
<script type="text/javascript" src="../cookie.js"></script>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
 <script type="text/javascript">
	function cancel(){
		window.location.href='login.html';
		}
</script>
</head>
<body>

	<div class="body">

	<div class="middle" style="width:60%;margin-left:20%;height:700px;">
		<div class="list">
			<p class="list-li" style="width:100%;text-align:center;cursor:default;margin:0 auto;">员工注册</p>
		</div><!--ä¸­é¨å¤´-->

		<br>
		
		<div style="overflow: hidden; height:600px;" id="showTask">
			<div class="create-task" id="createTask" style="width:80%;margin-left:10%;">
				<div class="heng">
					<p class="heng-text">账号名称：</p>
					<input type="text" id="account" class="heng-input">
				</div>
				
				<div class="heng">
					<p class="heng-text">账号密码：</p>
					<input type="passowrd" id="password" class="heng-input">
				</div>
				
				<div class="heng">
					<p class="heng-text">姓名：</p>
					<input type="text" id="name" class="heng-input">
				</div>
				
				<div class="heng">
					<p class="heng-text">入职部门：</p>
					<%String a[]=Setup.getDeptName(); %>
					<select class="heng-input" id="dept">
					<%for(int i=0;i<a.length;i++){ %>
						<option value=<%=a[i].split(" ")[0] %>><%=a[i].split(" ")[1] %></option>
					<%} %>
					</select>
				</div>
				
				<div class="heng">
					<p class="heng-text">性别：</p>
					<select class="heng-input" id="sex">
						<option value="0">男</option>
						<option value="1">女</option>
					</select>
				</div>
				
				<div class="heng">
					<p class="heng-text">出生日期：</p>
					<input type="date" id="born" class="heng-input">
				</div>
				
				<div class="heng">
					<p class="heng-text">入职时间：</p>
					<input type="date" id="hire" class="heng-input">
				</div>
				
				<div class="heng">
					<p class="heng-text">电话号码：</p>
					<input type="text" id="phone" class="heng-input">
				</div>
				
				<div class="heng">
					<p class="heng-text">联系地址：</p>
					<input type="text" id="address" class="heng-input">
				</div>
				
				<div class="heng">
					<p class="heng-text">电子邮件：</p>
					<input type="text" id="email" class="heng-input">
				</div>
				
				<div class="heng">
					<p class="heng-text">注册备注：</p>
					<input type="text" id="remark" class="heng-input">
				</div>
				
				<div class="heng" >
				<button class="heng-btn" style="margin-left:160px;" onclick="cancel()"}>取消</button>
				<button class="heng-btn" onclick="register()">提交</button>
			</div>
			</div>
		</div><!--任务框-->


		
	</div><!--中部¨-->
</div>

<div class="tail">
	<h6 class="tailtext">COPYRIGHT © 2018 XiaoMing All Rights Reserved.</h6>
</div>

<script type="text/javascript">
 function register(){
	 if($("#account").val()=="")alert("账号不能为空");
	 else if($("#password")=="")alert("密码不能为空");
	 else if($("#name")=="")alert("姓名不能为空");
	 else {
		 
		 $.ajax({
			 type:"POST",
			 url:"../CreateStaff",
			 data:{
				 account:$("#account").val(),
				 password:$("#password").val(),
				 name:$("#name").val(),
				 dept:$("#dept").val(),
				 sex:$("#sex").val()
			 },
			 dataType:"text",
			 
			 success:function(data){
				 console.log(data);
				 if(data=="false")alert("该账号已被注册");
				 else window.location.href="login.html";
			 }
		 })
		 
	 }
 }

</script>


<body>

</body>
</html>
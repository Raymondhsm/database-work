<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,domain.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="setup.css" />
<script type="text/javascript" src="../iframe.js"></script>
<script type="text/javascript" src="../cookie.js"></script>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
</head>
<body style="background:none;">



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
int id=Integer.valueOf(request.getParameter("id"));
if(!Login.isSetup(skey)){ %><p style="color:grey;font-size:15px;margin:20px auto;text-align:center;">你暂无权限进行该操作，如有疑问请联系系统管理员</p>
<%}else{ 
	

	
	String a[];
	String title;
	String title2="已录入任务级别：";
	String title3="已录入任务来源：";
	
	if(id==1){
		a=Setup.getDeptName();
		title="已录入部门信息：";
	}else if(id==2){
		a=Setup.getUserLevel();
		title="已录入权限：";
	}else if(id==3){
		a=Setup.getWorkday();
		title="已录入工作日信息：";
	}else{
		a=Setup.getTaskType();
		title="已录入任务类型";
	}
%>

		<div>
		<%for(int j=0;j<(id==4?3:1);j++){
			if(j==0){%>
				<p class="text-dept"><%=title%></p>
			<%}else if(j==1){ 
				a=Setup.getTaskLevel();%>
				<p class="text-dept"><%=title2%></p>
			<%}else{ 
				a=Setup.getTaskSource();%>
				<p class="text-dept"><%=title3%></p>
			<%} %>
			<div style="overflow: hidden;">
			<% if(a!=null) for(int i=0;i<a.length;i++){ %>
				<div class="dept-list">
					<p class="dept-name"><%=a[i].split(" ")[1] %></p>
					<img src="../image/delete.png" class="logo" style="cursor:pointer;" onclick="Delete(<%=id+j%>,<%=a[i].split(" ")[0]%>)">
				</div>
			<%} %>
				<div class="dept-list" style="align-items: center;" >
					<img src="../image/add.png" class="logo" onclick="add(<%=id+j %>)" style="float: none;margin:7px 112.5px;cursor:pointer;">
				</div>
			</div>
		</div>
		
		
<%if(id==1) {%>
		<div class="create-dept" id="add1">
			<div class="heng">
				<p class="heng-text">部门名称：</p>
				<input type="text" id="deptName" class="heng-input">
			</div>
			<div class="heng">
				<p class="heng-text">部门负责人：</p>
				<select id="manager" class="heng-input">
					<%!String[] b=Setup.getDeptManager();%>
					<%for(int i=0;i<b.length;i++){ %>
					<option value="<%=b[i].split(" ")[0] %>"><%=b[i].split(" ")[1] %></option>
					<%} %>
				</select>
			</div>
			<div class="heng">
				<p class="heng-text">部门工作日：</p>
				<select id="deptWD" class="heng-input">
					<%!String[] c=Setup.getWorkday();%>
					<%for(int i=0;i<c.length;i++){ %>
					<option value="<%=c[i].split(" ")[0] %>"><%=c[i].split(" ")[1] %></option>
					<%} %>
				</select>
			</div>
			<div class="heng" style="height: 70px;">
				<p class="heng-text">部门简介：</p>
				<textarea id="remark" class="heng-input" style="height: 60px;"></textarea>
			</div>

			<div class="heng" >
				<button class="heng-btn" style="margin-left:160px;" onclick="cancel(1)">取消</button>
				<button class="heng-btn" onclick="createT()">创建</button>
			</div>
		</div>
<%}
else if(id==2){%>
		<div class="create-dept" id="add2" style="height: 220px;" >
			<div class="heng">
				<p class="heng-text">级别代号：</p>
				<input type="text" id="deptName" class="heng-input">
			</div>
			<div class="heng" style="height: auto;">
				<p class="heng-text">级别权限：</p>
				<div class="heng-input">
				<p class="checkbox"><input type="checkbox" id="authority1" value="0">基础设计</p>
				<p class="checkbox"><input type="checkbox" id="authority2" value="1">人员管理</p>
				<p class="checkbox"><input type="checkbox" id="authority3" value="2">任务创建</p>
				<p class="checkbox"><input type="checkbox" id="authority4" value="3">任务跟踪</p>
				<p class="checkbox"><input type="checkbox" id="authority5" value="4">日志填写</p>
				<p class="checkbox"><input type="checkbox" id="authority6" value="5">日志审核</p>
				</div>
			</div>

			<div class="heng" style="margin-top: 20px;">
				<button class="heng-btn" style="margin-left:160px;" onclick="cancel(2)">取消</button>
				<button class="heng-btn" onclick="createlevel()">创建</button>
			</div>
		</div>
	
<%}
else if(id==3){ %>
			<div class="create-dept" id="add3" style="height: 130px;">
				<div class="heng">
					<p class="heng-text">工作日名称：</p>
					<input type="text" id="wdName" class="heng-input">
				</div>

				<div class="heng" style="margin-top: 20px;">
					<button class="heng-btn" onclick="cancel(3)" style="margin-left:160px;">取消</button>
					<button class="heng-btn" onclick="createWorkday()">创建</button>
				</div>
			</div>

<%}
else if(id+j==4){ %>
		<div class="create-dept" id="add4" style="height: 130px;" >
			<div class="heng">
				<p class="heng-text">任务类型：</p>
				<input type="text" id="ttName" class="heng-input">
			</div>
			<div class="heng" style="margin-top: 20px;">
				<button class="heng-btn" style="margin-left:160px;" onclick="cancel(4)">取消</button>
				<button class="heng-btn" onclick="creatett()">创建</button>
			</div>
		</div>
		
		
<%}
else if(id+j==5){ %>		
		<div class="create-dept" id="add5" style="height: 180px;" >
			<div class="heng">
				<p class="heng-text">名称：</p>
				<input type="text" id="tlName" class="heng-input">
			</div>
			<div class="heng">
				<p class="heng-text">任务级别：</p>
				<input type="text" id="tl" class="heng-input">
			</div>
			<div class="heng" style="margin-top: 20px;">
				<button class="heng-btn" style="margin-left:160px;" onclick="cancel(5)">取消</button>
				<button class="heng-btn" onclick="createtl()">创建</button>
			</div>
		</div>
		
<%}
else if(id+j==6){ %>
		<div class="create-dept" id="add6" style="height: 130px;" >
			<div class="heng">
				<p class="heng-text">任务来源：</p>
				<input type="text" id="tsName" class="heng-input">
			</div>
			<div class="heng" style="margin-top: 20px;">
				<button class="heng-btn" style="margin-left:160px;" onclick="cancel(6)">取消</button>
				<button class="heng-btn" onclick="createts()">创建</button>
			</div>
		</div>
<%}} }%>

<script type="text/javascript">

	window.onload=function(){
		<%if(id<=4){%>$("#add"+<%=id%>).hide();<%}%>
		<%if(id==4){%>
			$("#add5").hide();
			$("#add6").hide();
		<%}%>
	}

	function cancel(k){
		$("#add"+k).hide();
	}
	
	function add(i){
		document.getElementById('add'+i).style.display="";
	}
	
	function Delete(type,ID){
		$.ajax({
			type:"GET",
			url:"../DeleteSetup",
			data:{
				type:type,
				ID:ID
			},
			dataType:"text",
			
			success:function(){
				window.location.reload();
			}
		})
	}
	
	function createT(){
		$.ajax({
			type:"GET",
			url:"../CreateSetup",
			data:{
				type:1,
				name:$("#deptName").val(),
				manager:$("#manager").val(),
				workday:$("#deptWD").val(),
				remark:$("#remark").val()
			},
			dataType:"text",
			
			success:function(){
				window.location.reload();
			}
		})
	}
	
	function createlevel(){
		$.ajax({
			type:"GET",
			url:"../CreateSetup",
			data:{
				type:2,
				name:$("#deptName").val(),
				l1:$('#authority1').is(':checked')?1:0,
				l2:$('#authority2').is(':checked')?1:0,
				l3:$('#authority3').is(':checked')?1:0,
				l4:$('#authority4').is(':checked')?1:0,
				l5:$('#authority5').is(':checked')?1:0,
				l6:$('#authority6').is(':checked')?1:0
			},
			dataType:"text",
			
			success:function(){
				window.location.reload();
			}
		});
		
	}
	
	function createWorkday(){
		$.ajax({
			type:"GET",
			url:"../CreateSetup",
			data:{
				type:3,
				name:$("#wdName").val()
			},
			dataType:"text",
			
			success:function(){
				window.location.reload();
			}
		});	
	}
	
	function creatett(){
		$.ajax({
			type:"GET",
			url:"../CreateSetup",
			data:{
				type:4,
				name:$("#ttName").val()
			},
			dataType:"text",
			
			success:function(){
				window.location.reload();
			}
		});	
	}
	
	function createtl(){
		$.ajax({
			type:"GET",
			url:"../CreateSetup",
			data:{
				type:5,
				name:$("#tlName").val(),
				level:$("#tl").val()
			},
			dataType:"text",
			
			success:function(){
				window.location.reload();
			}
		});	
	}
	
	function createts(){
		$.ajax({
			type:"GET",
			url:"../CreateSetup",
			data:{
				type:6,
				name:$("#tsName").val()
			},
			dataType:"text",
			
			success:function(){
				window.location.reload();
			}
		});	
	}
</script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,domain.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="task.css" />
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
	for(int i=0;i<cookies.length-1;i++){    //用一个循环语句遍历刚才建立的Cookie对象数组
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
	
	if(id==5&&!Login.isCreateTask(skey)){ %><p style="color:grey;font-size:15px;margin:20px auto;text-align:center;">你暂无权限进行该操作，如有疑问请联系系统管理员</p>
	<%}else{
	
	if(id==1) a=task.getPartInTask(skey);
	else if(id==2)a=task.getLikeTask(skey);
	else if(id==3)a=task.getPublishTask(skey);
	else a=task.getSearchTask(request.getParameter("key"));
	
	String b[][]=task.getLikeTask(skey);
	
	int index=-1;
	
	if(id==1&&a.length==0){ %><p style="color:grey;font-size:15px;margin:20px auto;text-align:center;">你暂时没有正在参与的任务哦~~</p>
	<%}else if(id==2&&a.length==0) {%><p style="color:grey;font-size:15px;margin:20px auto;text-align:center;">你暂时没有收藏的任务哦~~</p>
	<%}else if(id==3&&a.length==0) {%><p style="color:grey;font-size:15px;margin:20px auto;text-align:center;">你暂时没有发布的任务哦~~</p>
	<%}else if(id==4&&a.length==0) {%><p style="color:grey;font-size:15px;margin:20px auto;text-align:center;">暂时没有找到你想要的任务哦~~</p>
	<%}%>
	
<div id="partintask">
<%if(id<5){ 	
for(int i=0;i<a.length;i++){ %>
			<div class="task-list" id=<%="bigShow"+i%> style="display:none;">
			    <div class="row-header">
					<p class="row-header-info"><%=a[i][1] %></p>
					<img src="../image/up.png" onclick="up(<%=i %>)" class="logo">
					<%if(id==3){ %><img src="../image/delete.png" onclick="Delete(<%=a[i][0] %>)" class="logo">
					<img src="../image/pen.png" onclick="update(<%=a[i][0]%>,<%="'"+a[i][1]+"'"%>,<%="'"+a[i][2].split(" ")[0]+"'"%>,<%="'"+a[i][5]+"'"%>,<%="'"+a[i][6]+"'"%>,<%="'"+a[i][7]+"'"%>,<%="'"+a[i][8]+"'"%>)" class="logo"><%} %>
					<%if(!task.isFollow(a[i][0], skey)){ %>
					<img src="../image/like.png" class="logo" onclick="like(<%=i%>,<%=a[i][0] %>)" id=<%="biglike"+i %> >
					<img src="../image/liked.png" class="logo" onclick="unlike(<%=i%>,<%=a[i][0] %>)" id=<%="bigliked"+i %> style="display:none"><%}
					else {%>
					<img src="../image/like.png" class="logo" onclick="like(<%=i%>,<%=a[i][0] %>)" id=<%="biglike"+i %> style="display:none">
					<img src="../image/liked.png" class="logo" onclick="unlike(<%=i%>,<%=a[i][0] %>)" id=<%="bigliked"+i %>><%} %>
				</div>
				<div class="row">
			    	<p class="row-title">开始时间:</p>
					<p class="row-info"><%=a[i][3].split(" ")[0] %></p>
				</div>
				<div class="row">
			    	<p class="row-title">结束时间:</p>
					<p class="row-info"><%=a[i][2].split(" ")[0] %></p>
				</div>
				<div class="row">
			    	<p class="row-title">任务状态:</p>
					<p class="row-info"><%=a[i][4] %></p>
				</div>
				<div class="row">
			    	<p class="row-title">任务来源:</p>
					<p class="row-info"><%=a[i][8] %></p>
				</div>
				<div class="row">
			    	<p class="row-title">任务类型:</p>
					<p class="row-info"><%=a[i][7] %></p>
				</div>
				<div class="row">
			    	<p class="row-title">任务等级:</p>
					<p class="row-info"><%=a[i][6] %></p>
				</div>
				<div class="row">
			    	<p class="row-title">备注:</p>
					<p class="row-info"><%=a[i][5] %></p>
				</div>
			</div><!--å¤§æ¡-->

			<div class="task-row" id=<%="smallShow"+i%>>
				<p class="task-name" style="width: 35%;"><%=a[i][1]%></p>
				<p class="task-level"><%=a[i][7]%></p>
				<p class="task-source">end:<%=a[i][3].split("[ -]")[1]%>-<%=a[i][3].split("[ -]")[2]%></p>
				<img src="../image/down.png" onclick="down(<%=i %>)" class="logo">
				<%if(id==3){ %><img src="../image/delete.png" onclick="Delete(<%=a[i][0] %>)" class="logo">
				<img src="../image/pen.png" onclick="update(<%=a[i][0]%>,<%="'"+a[i][1]+"'"%>,<%="'"+a[i][2].split(" ")[0]+"'"%>,<%="'"+a[i][5]+"'"%>,<%="'"+a[i][6]+"'"%>,<%="'"+a[i][7]+"'"%>,<%="'"+a[i][8]+"'"%>)" class="logo"><%} %>
				<%if(!task.isFollow(a[i][0], skey)){ %>
				<img src="../image/like.png" class="logo" onclick="like(<%=i%>,<%=a[i][0] %>)" id=<%="like"+i %> >
				<img src="../image/liked.png" class="logo" onclick="unlike(<%=i%>,<%=a[i][0] %>)" id=<%="liked"+i %> style="display:none"><%}
				else {%>
				<img src="../image/like.png" class="logo" onclick="like(<%=i%>,<%=a[i][0] %>)" id=<%="like"+i %> style="display:none">
				<img src="../image/liked.png" class="logo" onclick="unlike(<%=i%>,<%=a[i][0] %>)" id=<%="liked"+i %>><%} %>
			</div>
		<%} }
		if(id==3||id==5){%>
		
		<div class="create-task" id="createTask" style=<%="display:"+(id==3?"none":"")+";"%>>
			<div class="heng">
				<p class="heng-text">任务名称：</p>
				<input type="text" id="name" class="heng-input">
			</div>
			<div class="heng">
				<p class="heng-text">结束时间：</p>
				<input type="date" id="endTime" class="heng-input">
			</div>
			
			<%String[] dept=Setup.getDeptName();%>
			<div class="heng" style="height:auto;overflow:hidden;">
				<p class="heng-text">任务指派：</p>
				<div class="heng-input">
				<%for(int i=0;i<dept.length;i++){ %>
				<p style="width: 40%;float: left;margin: 5px 0 5px 20px;"><input type="checkbox" value=<%=dept[i].split(" ")[0] %> name="cbdept"><%=dept[i].split(" ")[1] %></p>
				<%} %>
				</div>
			</div>
			
			<div class="heng" style="overflow:hidden;">
				<p class="heng-text">任务来源：</p>
				<select id="source" class="heng-input" id="TSsel">
					<%String ts[]=Setup.getTaskSource();
					for(int i=0;i<ts.length;i++){ %>
						<option value=<%=ts[i].split(" ")[0] %> id=<%="ts"+ts[i].split(" ")[1] %>><%=ts[i].split(" ")[1] %></option>
					<%} %>
				</select>
			</div>
			<div class="heng" style="overflow:hidden;">
				<p class="heng-text">任务类型：</p>
				<select id="type" class="heng-input" id="TTsel">
					<%String tt[]=Setup.getTaskType();
					for(int i=0;i<tt.length;i++){ %>
						<option value=<%=tt[i].split(" ")[0] %> id=<%="tt"+tt[i].split(" ")[1] %>><%=tt[i].split(" ")[1] %></option>
					<%} %>
				</select>
			</div>
			<div class="heng" style="overflow:hidden;">
				<p class="heng-text">任务等级：</p>
				<select id="level" class="heng-input" id="TLsel">
					<%String tl[]=Setup.getTaskLevel();
					for(int i=0;i<tl.length;i++){ %>
						<option value=<%=tl[i].split(" ")[0] %> id=<%="tl"+tl[i].split(" ")[1] %>><%=tl[i].split(" ")[1] %></option>
					<%} %>
				</select>
			</div>
			<div class="heng" style="height: 70px;">
				<p class="heng-text">备注：</p>
				<textarea type="text" id="remark" class="heng-input" style="height: 60px;"></textarea>
			</div>

			<div class="heng" >
				<button class="heng-btn" style="margin-left:160px;" onclick="<%=id==3?"cancelUT()":""%>">取消</button>
				<button class="heng-btn" onclick=<%=id==3?"updateTask()":"createTasks()"%>><%=id==3?"修改":"创建" %></button>
			</div>
		</div><!--创建框-->
		<%} %>

</div>
<%} %>


<script type="text/javascript">
	
	function createTask(){
		document.getElementById("createTask").style.display="";
		document.getElementById("showTask").style.display="none";
	}
	
	function down(i){
		document.getElementById("bigShow"+i).style.display="";
		document.getElementById("smallShow"+i).style.display="none";
	}
	
	function up(j){
		document.getElementById("bigShow"+j).style.display="none";
		document.getElementById("smallShow"+j).style.display="";
	}
	
	function like(k,taskID){
		$.ajax({
			type:"GET",
			url:"../ChangeLike",
			data:{
				taskID:taskID,
				skey:getCookie("skey"),
				type:"like"
			},
			dateType:"json",
			
			success:function(data){
				console.log(data);
				$("#like"+k).hide();
				$("#biglike"+k).hide();
				$("#liked"+k).show();
				$("#bigliked"+k).show();
			}
		});
	}
	
	function unlike(k,taskID){
		$.ajax({
			type:"GET",
			url:"../ChangeLike",
			data:{
				taskID:taskID,
				skey:getCookie("skey"),
				type:"unlike"
			},
			dateType:"json",
			
			success:function(data){
				console.log(data);
				$("#like"+k).show();
				$("#biglike"+k).show();
				$("#liked"+k).hide();
				$("#bigliked"+k).hide();
			}
		});
	}
	
	function Delete(taskID){
		$.ajax({
			type:"GET",
			url:"../DeleteTask",
			data:{
				taskID:taskID,
				skey:getCookie("skey")
			},
			dateType:"json",
			
			success:function(data){
				console.log(data);
				window.location.reload();
			}
		});
	}
	
	var bigtaskID;
	function update(taskId,taskName,endtime,Remark,level,type,source){
		$("#createTask").show();
		$("#name").attr('value',taskName);
		$("#endTime").attr('value',endtime);
		$("#ts"+source).attr('selected','selected');
		$("#tl"+level).attr('selected','selected');
		$("#tt"+type).attr('selected','selected');
		$("#remark").val(Remark);
		bigtaskID=taskId;
	}
	
	function updateTask(){
		var deptAssign="";
		$('input[name="cbdept"]:checked').each(function(){
            deptAssign+=$(this).val()+",";
            });
		
		$.ajax({
			type:"GET",
			url:"../CreateTask",
			data:{
				id:"update",
				taskID:bigtaskID,
				name:$("#name").val(),
				endTime:$("#endTime").val(),
				type:$("#type").val(),
				source:$("#source").val(),
				level:$("#level").val(),
				remark:$("#remark").val(),
				skey:getCookie("skey"),
				
				assign:deptAssign
			},
			dateType:"text",
			
			success:function(data){
				console.log(data);
				$("#name").val("");
				$("#endTime").val("");
				$("#remark").val("");
				window.location.reload();
			}
		});
	}
	
	function cancelUT(){
		$("#createTask").hide();
	}
	
	function createTasks(){
		var deptAssign="";
		$('input[name="cbdept"]:checked').each(function(){
            deptAssign+=$(this).val()+",";
            });
		
		$.ajax({
			type:"GET",
			url:"../CreateTask",
			data:{
				id:"create",
				name:$("#name").val(),
				endTime:$("#endTime").val(),
				type:$("#type").val(),
				source:$("#source").val(),
				level:$("#level").val(),
				remark:$("#remark").val(),
				skey:getCookie("skey"),
				
				assign:deptAssign
			},
			dateType:"json",
			
			success:function(data){
				console.log(data);
				$("#name").val("");
				$("#endTime").val("");
				$("#remark").val("");
			}
		});
	}
	
</script>



</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,domain.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WorkGether</title>
<link rel="stylesheet" type="text/css" href="task.css" />
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

<script type="text/javascript">
	window.onload=function(){

		<%if(skey.equals("")){%>window.location.href="login/login.html";
		<%}else{%>window.location.href="task/task.jsp";<%}%>
	}
</script>

</body>
</html>
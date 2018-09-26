<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	   <base href="<%=basePath%>">

	    <title>编辑用户</title>

   <script type="text/javascript">
       function update(){
       var form = document.forms[0];
              form.action = "<%=basePath%>user/update";
              form.method="post";
             form.submit();
          }
    </script>

	  </head>

 <body>
    <h1>编辑用户</h1>
  <form action="" name="userForm">
	       <input type="hidden" name="id" value="${user.id }"/>
	        姓名：<input type="text" name="user_name" value="${user.user_name }"/>
	       手机号：<input type="text" name="user_telephone" value="${user.user_telephone }"/>
            身份证：<input type="text" name="user_IDcard" value="${user.user_IDcard}"/>
        <input type="button" value="编辑" onclick="update()"/>
    </form>
 </body>

</html>





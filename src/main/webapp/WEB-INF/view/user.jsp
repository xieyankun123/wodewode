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
    <script type="text/javascript" src="js/jquery-1.7.1.js"></script>
    <title>住户列表</title>

  </head>

  <body>
    <h6><a href="<%=basePath%>user/toadd">添加用户</a></h6>
    <table border="1">
          <tbody>
           <tr>
                  <th>姓名</th>
               <th>手机号</th>
               <th>身份证</th>
              <th>操作</th>
            </tr>
           <c:if test="${!empty userList }">
                 <c:forEach items="${userList}" var="user">
                   <tr>
                       <td>${user.user_name }</td>
                         <td>${user.user_telephone}</td>
                     <td>${user.user_IDcard}</td>
                         <td>
                            <a href="<%=basePath%>user/selectbytel?user_telephone=${user.user_telephone}">编辑</a>
                            <a href="<%=basePath%>user/del?id=${user.id}">删除</a>
                       </td>
                   </tr>
               </c:forEach>
             </c:if>
        </tbody>
   </table>
 </body>
</html>

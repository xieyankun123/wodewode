<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta name="viewport" content="maximum-scale=1.0,minimum-scale=1.0,user-scalable=0,width=device-width,initial-scale=1.0"/>
    <title>登录成功</title>
    <link rel="stylesheet" href="static/css/logincss.css"/>
    <script src="static/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="static/myjs/login.js"></script>

</head>
<body>
登录成功
</body>
</html>
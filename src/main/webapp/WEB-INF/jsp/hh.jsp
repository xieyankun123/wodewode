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
    <title>登陆页面</title>
    <link rel="stylesheet" href="static/css/logincss.css"/>
    <script src="static/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="static/myjs/login.js"></script>
    <script type="text/javascript">

        function tishia(x,n){
            x.html(n);
            x.css('display','block');
            setTimeout(function(){
                x.css('display','none');
            },1200);
        }
        var yonghuming_kong ="请输入用户名";
        var mima_kong="密码格式不对";
        var mima_cuo="请输入正确密码";
        function enter()
        {
            var username=document.getElementById("username").value;//获取form中的用户名
            var password=document.getElementById("password").value;
            var regex=/^[/s]+$/;//声明一个判断用户名前后是否有空格的正则表达式
            if(regex.test(username)||username.length==0)//判定用户名的是否前后有空格或者用户名是否为空
            {
                // alert("用户名格式不对");
                tishia( $('.tishikuang'),yonghuming_kong);
                return false;
            }
            if(regex.test(password)||password.length==0)//同上述内容
            {
                tishia( $('.tishikuang'),mima_kong);
                // alert("密码格式不对");
                return false;
            }
            return true;
        }

    </script>
</head>
<body>
<header>
    <div class="btn cancel"  ></div>
    <div class="title">登陆</div>
    <div class="btn"></div>
</header>
<div class="content">
    <form  action="we/enter" method="post" onsubmit="return enter()">
        <div class="form">
            <div class="input-wrap">
                <i class="user"></i>
                <input type="text" placeholder="用户名" class="txt" id="username" name="anager_telephone"/>

            </div>
            <div class="input-wrap">
                <i class="password"></i>
                <input type="password" placeholder="密码" class="txt" id="password" name="password" />


            </div>
        </div>
        <p class="find-pwd"><span>找回密码</span></p>

        <div class="button green" id="login" tapmode="" "><input  type="submit" value="登录">
        <div class="tishikuang"></div>
</div>
<%--<div class="button yellow margin-top-25" tapmode="" >注册新用户</div>--%>
</form>
</div>
</body>
</html>
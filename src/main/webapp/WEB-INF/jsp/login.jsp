<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- <html xmlns="http://www.w3.org/1999/xhtml"> -->
<%@ page language="java" pageEncoding="UTF-8"%><!--增加一行page指令即可-->
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<head>
	<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="static/assets/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/assets/css/font-awesome.min.css" />

		<link rel="stylesheet" href="static/assets/css/ace.min.css" />
		<link rel="stylesheet" href="static/assets/css/ace-rtl.min.css" />
		<link rel="stylesheet" href="static/assets/css/ace-skins.min.css" />

        <link rel="stylesheet" href="static/css/style.css"/>

		<script src="static/assets/js/ace-extra.min.js"></script>

		<script src="static/js/jquery-1.9.1.min.js"></script>
	<script src="static/js/jquery.tips.js"></script>

		<!-- 引入弹窗层js -->
        <script src="static/assets/layer/layer.js" type="text/javascript"></script>
        <style type="text/css">
        	.bao{width: 387px;padding-left: 100px;}
			.bigtitle{height: 75px;line-height: 75px;display: block;float: left;color: white;}
			.bigtubiao{width: 40px;display: block;float: left;margin-top:19px;text-align: center;}
			.zufang{width: 130px;}
			.yanzheng{position: absolute;
				display: block;}
			.passcode{display: block;position:relative;top:-26px;right:-136px;
				}
		</style>
<title>登录</title>
</head>

<body class="login-layout Reg_log_style">
	<div class="logintop">    
    	<span>欢迎来到插空后台管理界面平台</span>    
    	<ul>
    		<li><a href="#">返回首页</a></li>
    		<li><a href="#">帮助</a></li>
    		<li><a href="#">关于</a></li>
    	</ul>    
    </div>
    <div class="loginbody">
		<div class="login-container">
			<div class="center">
				<div class="bao">
					<img  class="bigtubiao" src="static/images/1chazuo.png" />
					<h2 class="bigtitle">插空后台控制平台</h2>
				</div>
			</div>
			<div class="space-6"></div>
			<div class="position-relative">
				<div id="login-box" class="login-box widget-box no-border visible">
						<div class="widget-body">
							<div class="widget-main">
								<h4 class="header blue lighter bigger">
									<i class="icon-coffee green"></i>
												管理员登录
								</h4>
								<div class="login_icon"><img  class="zufang" src="static/images/zufang.png" /></div>
								<form class="">
									<fieldset>
										<ul class="da">
   											<li class="frame_style form_error"><label class="user_icon"></label><input name="loginname" type="text"  id="loginname"/><i>用户名</i></li>
   											<li class="frame_style form_error"><label class="password_icon"></label><input name="password" type="password"   id="password"/><i>密码</i></li>
   											<li class="frame_style form_error yanzheng"><label class="Codes_icon"></label><input name="code" type="text"   id="code"/>
												<%--<i>验证码</i>--%>
												<img src="mg/checkCode" alt="" width="100px"  class="passcode" style="height:30px;cursor:pointer;z-index: 999" onclick="this.src=this.src+'?'">
											</li>
  										</ul>
										<div class="space"></div>
										<div class="clearfix">
												<label class="inline">
												<input type="checkbox" class="ace">
												<span class="lbl">保存密码</span>
												</label>
											<button type="button" class="width-35 pull-right btn btn-sm btn-primary" id="login_btn" onclick="severCheck();">
												<i class="icon-key"></i>
												登录
											</button>
										</div>

										<div class="space-4"></div>
									</fieldset>
								</form>
								<div class="social-or-login center">
									<span class="bigger-110">通知</span>
								</div>
								<div class="social-login center">
											本网站系统不再对IE8以下浏览器支持，请见谅。
								</div>
										</div><!-- /widget-main -->

					<div class="toolbar clearfix">	</div>
						</div><!-- /widget-body -->
				</div><!-- /login-box -->
			</div><!-- /position-relative -->
		</div>
    </div>
    <div class="loginbm">版权所有    <a href="">BUPT324</a> </div>
    <strong></strong>
</body>
</html>
<script>
// 登录时候是否输入账号密码的前台判断
$('#password').keydown(function(event){
    if(event.keyCode==13){
        severCheck();
    }
});

$('#code').keydown(function(event){
    if(event.keyCode==13){
        severCheck();
    }
});
function severCheck(){
    if(check()){

        var loginname = $("#loginname").val();
        var password = $("#password").val();
        var code = $("#code").val();
        $.ajax({
            type: "POST",
            url: 'mg/login',
            data: {manager_telephone:loginname,password:password,code:code},
            dataType:'json',
            cache: false,
            success: function(data){
                if("10005" == data.result){
                    window.location.href="mg/index";
                }else if("10002" == data.result){
                    $("#loginname").tips({
                        side : 1,
                        msg : "用户名或密码有误",
                        bg : '#FF5080',
                        time : 15
                    });
                    $("#loginname").focus();
                }else if("10000" == data.result){
                    $("#code").tips({
                        side : 1,
                        msg : "验证码输入有误",
                        bg : '#FF5080',
                        time : 15
                    });
                    $("#code").focus();
                }else{
                    $("#loginname").tips({
                        side : 1,
                        msg : "缺少参数",
                        bg : '#FF5080',
                        time : 15
                    });
                    $("#loginname").focus();
                }
            }
        });
    }
}

$(document).ready(function() {
    changeCode();
    $("#codeImg").bind("click", changeCode);
});

$(document).keyup(function(event) {
    if (event.keyCode == 13) {
        $("#to-recover").trigger("click");
    }
});

function genTimestamp() {
    var time = new Date();
    return time.getTime();
}

function changeCode() {
    $("#codeImg").attr("src", "code.do?t=" + genTimestamp());
}

//客户端校验
function check() {

    if ($("#loginname").val() == "") {

        $("#loginname").tips({
            side : 2,
            msg : '用户名不得为空',
            bg : '#AE81FF',
            time : 3
        });

        $("#loginname").focus();
        return false;
    } else {
        $("#loginname").val(jQuery.trim($('#loginname').val()));
    }

    if ($("#password").val() == "") {

        $("#password").tips({
            side : 2,
            msg : '密码不得为空',
            bg : '#AE81FF',
            time : 3
        });

        $("#password").focus();
        return false;
    }
    if ($("#code").val() == "") {

        $("#code").tips({
            side : 1,
            msg : '验证码不得为空',
            bg : '#AE81FF',
            time : 3
        });

        $("#code").focus();
        return false;
    }

    $("#loginbox").tips({
        side : 1,
        msg : '正在登录 , 请稍后 ...',
        bg : '#68B500',
        time : 10
    });

    return true;
}

// 设置输入框点击与失去焦点的样式
  $(document).ready(function(){
	 $("input[type='text'],input[type='password']").blur(function(){
        var $el = $(this);
        var $parent = $el.parent();
        $parent.attr('class','frame_style').removeClass(' form_error');
        if($el.val()==''){
            $parent.attr('class','frame_style').addClass(' form_error');
        }
    });
	$("input[type='text'],input[type='password']").focus(function(){		
		var $el = $(this);
        var $parent = $el.parent();
        $parent.attr('class','frame_style').removeClass(' form_errors');
        if($el.val()==''){
            $parent.attr('class','frame_style').addClass(' form_errors');
        } else{
			 $parent.attr('class','frame_style').removeClass(' form_errors');
		}
		});
	})

</script>
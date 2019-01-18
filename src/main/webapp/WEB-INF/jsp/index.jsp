<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8"%><!--增加一行page指令即可-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html lang="en">
	<head>

		<meta charset="utf-8" />
		<title>房屋管家后台控制</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<style type="text/css">
			.bigtitle{height: 75px;line-height: 75px;display: block;float: left;}
			.bigtubiao{width: 40px;display: block;float: left;margin-top:19px;}
		</style>
		<base href="<%=basePath%>">
		<link href="static/assets/css/bootstrap.min.css" rel="stylesheet" />
		<!-- 引入图标插件 -->
		<link rel="stylesheet" href="static/assets/css/font-awesome.min.css" />
		<link rel="stylesheet" href="static/assets/css/font-awesome-ie7.min.css" />
		<link rel="stylesheet" href="static/assets/css/ace.min.css" />
		<link rel="stylesheet" href="static/assets/css/ace-rtl.min.css" />
		<link rel="stylesheet" href="static/assets/css/ace-skins.min.css" />
        <link rel="stylesheet" href="static/css/style.css"/>
		  <link rel="stylesheet" href="static/assets/css/ace-ie.min.css" />
		<script src="static/assets/js/ace-extra.min.js"></script>
		<script src="static/assets/js/html5shiv.js"></script>
		<script src="static/assets/js/respond.min.js"></script>
		<script src="static/js/jquery-1.9.1.min.js"></script>
         <script type="text/javascript">window.jQuery || document.write("<script src='static/assets/js/jquery-1.10.2.min.js'>"+"<"+"script>");</script>

        <!-- 判断是否是移动设备中 -->
		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='static/assets/js/jquery.mobile.custom.min.js'>"+"<"+"script>");
		</script>
		<script src="static/assets/js/bootstrap.min.js"></script>
		<script src="static/assets/js/typeahead-bs2.min.js"></script>
		  <script src="static/assets/js/excanvas.min.js"></script>
		<script src="static/assets/js/ace-elements.min.js"></script>
		<script src="static/assets/js/ace.min.js"></script>
        <script src="static/assets/layer/layer.js" type="text/javascript"></script>
		<script src="static/assets/laydate/laydate.js" type="text/javascript"></script>
        <script src="static/js/jquery.nicescroll.js" type="text/javascript"></script>
        
<script type="text/javascript">	
 $(function(){ 
 	// 获取各个子菜单ul
 	var cid = $('#nav_list> li>.submenu');
	 cid.each(function(i){ 
     $(this).attr('id',"Sort_link_"+i);
     // 给每个ul赋不同的id
   
    })  
 })
 jQuery(document).ready(function(){ 	
    $.each($(".submenu"),function(){
	var $aobjs=$(this).children("li");
	var rowCount=$aobjs.size();    	// 记录子目录下有几个li
	var divHeigth=$(this).height();
    $aobjs.height(divHeigth/rowCount);	  	
    // alert($aobjs.height);

  }); 
    //初始化宽度、高度

    $("#main-container").height($(window).height()-76); 
	$("#iframe").height($(window).height()-140); 
	 
	$(".sidebar").height($(window).height()-99); 
    var thisHeight = $("#nav_list").height($(window).outerHeight()-173); 
	$(".submenu").height();
	$("#nav_list").children(".submenu").css("height",thisHeight);
	
    //当文档窗口发生改变时 触发  
    $(window).resize(function(){
	$("#main-container").height($(window).height()-76); 
	$("#iframe").height($(window).height()-140);
	$(".sidebar").height($(window).height()-99); 
	
	var thisHeight = $("#nav_list").height($(window).outerHeight()-173); 
	$(".submenu").height();
	$("#nav_list").children(".submenu").css("height",thisHeight);
  	});
    $(document).on('click','.iframeurl',function(){
                var cid = $(this).attr("name");  // 跳转的对应网址
				var cname = $(this).attr("title"); //子菜单名
                $("#iframe").attr("src",cid).ready();     //更改iframe的网址
				$("#Bcrumbs").attr("href",cid).ready();
				$(".Current_page a").attr('href',cid).ready();	
                $(".Current_page").attr('name',cid);
				$(".Current_page").html(cname).css({"color":"#333333","cursor":"default"}).ready();	 //设置选中页面时上边显示
				$("#parentIframe").html('<span class="parentIframe iframeurl"> </span>').css("display","none").ready();	
				$("#parentIfour").html(''). css("display","none").ready();		
      });
	 
    
		
});
 /******/
  $(document).on('click','.link_cz > li',function(){
	$('.link_cz > li').removeClass('active');
	$(this).addClass('active');
});

/*********************点击事件*********************/
$( document).ready(function(){
  $('#nav_list,.link_cz').find('li.home').on('click',function(){
	$('#nav_list,.link_cz').find('li.home').removeClass('active');      //大菜单
	$(this).addClass('active');
  });												
//时间设置
  function currentTime(){ 
    var d=new Date(),str=''; 
    str+=d.getFullYear()+'年'; 
    str+=d.getMonth() + 1+'月'; 
    str+=d.getDate()+'日'; 
    str+=d.getHours()+'时'; 
    str+=d.getMinutes()+'分'; 
    str+= d.getSeconds()+'秒'; 
    return str; 
} 

setInterval(function(){$('#time').html(currentTime)},1000); 




//退出登录
  $('#Exit_system').on('click', function(){
      layer.confirm('是否确定退出系统？', {
     btn: ['是','否'] ,//按钮
	 icon:2,
    },
	function(){
	  location.href="<%=basePath%>/mg/login_toLogin";
    });
	});
});


function link_operating(name,title){
                var cid = $(this).name;
				var cname = $(this).title;
                $("#iframe").attr("src",cid).ready();
				$("#Bcrumbs").attr("href",cid).ready();
				$(".Current_page a").attr('href',cid).ready();	
                $(".Current_page").attr('name',cid);
				$(".Current_page").html(cname).css({"color":"#333333","cursor":"default"}).ready();	
				$("#parentIframe").html('<span class="parentIframe iframeurl"> </span>').css("display","none").ready();	
				$("#parentIfour").html(''). css("display","none").ready();		
      
    
}
</script>	
	</head>
	<body>
<c:if test="${!empty mm }">
	<div items="${mm}" var="mm">
		<div class="navbar navbar-default" id="navbar">
        <script type="text/javascript">
				try{ace.settings.check('navbar' , 'fixed')}catch(e){}
		</script>
			<div class="navbar-container" id="navbar-container">
				<div class="navbar-header pull-left">
					<a href="#" class="navbar-brand">
						<small >
							<img class="bigtubiao" src="static/images/1chazuo.png">
							<!-- <img src="images/logo.png" width="470px"> -->
							<h2 class="bigtitle">房屋管家后台控制平台</h2>
						</small>
					</a><!-- /.brand -->
				</div><!-- /.navbar-header -->
				<div class="navbar-header operating pull-left">
				</div>
			   <div class="navbar-header pull-right" role="navigation">
               		<ul class="nav ace-nav">	
               			 <li class="light-blue">
							<a data-toggle="dropdown" href="#" class="dropdown-toggle">
				 				<span  class="time"><em id="time"></em></span>
				 				<span class="user-info"><small>欢迎光临,</small>${mm.role}</span>
				 				<i class="icon-caret-down"></i>
							</a>
							<ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">

				 				<li class="divider"></li>
						 		<li><a href="javascript:ovid(0)" id="Exit_system"><i class="icon-off"></i>退出</a></li>
							</ul>
			   			</li>

					</ul>

                </div>
			</div>
		</div>

		<div class="main-container" id="main-container">
        <script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
		</script>
			<div class="main-container-inner">
				<a class="menu-toggler" id="menu-toggler" href="#">
					<span class="menu-text"></span>
				</a>
				<div class="sidebar" id="sidebar">      <!-- 左边目录栏 -->
				<script type="text/javascript">
						try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
				</script>
					<div class="sidebar-shortcuts" id="sidebar-shortcuts"> <!-- 左边目录栏四个小图标 -->
						<div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
							<a class="btn btn-success" style="cursor: auto">
								<i class="icon-signal" style="cursor: auto"></i>
							</a>
							<a class="btn btn-info" style="cursor: auto">
								<i class="icon-pencil" style="cursor: auto"></i>
							</a>
							<a class="btn btn-warning" style="cursor: auto">
								<i class="icon-group" style="cursor: auto"></i>
							</a>
							<a class="btn btn-danger" style="cursor: auto">
								<i class="icon-cogs" style="cursor: auto"></i>
							</a>
						</div>
						<!-- 当菜单往左缩时候 -->
						<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
							<span class="btn btn-success"></span>

							<span class="btn btn-info"></span>

							<span class="btn btn-warning"></span>

							<span class="btn btn-danger"></span>
						</div>
					</div><!-- #sidebar-shortcuts --><!-- 左边目录栏四个小图标 -->

					<div id="menu_style" class="menu_style">    <!-- 左边目录栏下面的菜单 -->
						<ul class="nav nav-list" id="nav_list">
				     		<li class="home">
				     			<a href="javascript:void(0)" name="mg/home" class="iframeurl" title="">	<i class="icon-home"></i>
				     			<span class="menu-text"> 系统首页 </span>
				     			</a>
				    		 </li>
                  			<li>
								<a href="#" class="dropdown-toggle"><i class="icon-user"></i><span class="menu-text"> 租户管理 </span><b class="arrow icon-angle-down"></b></a>
                    			<ul class="submenu">
                    				<li class="home"><a href="javascript:void(0)" name="user/user_list" title="租户列表"  class="iframeurl"><i class="icon-double-angle-right"></i>租户列表</a></li>
								</ul>
				  			</li>

				  			<li><a href="#" class="dropdown-toggle"><i class="icon-laptop"></i><span class="menu-text"> 房源管理 </span><b class="arrow icon-angle-down"></b></a>
								<ul class="submenu">
									<li class="home">
										<a href="javascript:void(0)" name="apartment/apa_list" title="公寓列表" class="iframeurl"><i class="icon-double-angle-right"></i>公寓列表
										</a>
									</li>
									<li class="home">
										<a href="javascript:void(0)" name="room/house_list" title="房源列表" class="iframeurl"><i class="icon-double-angle-right"></i>房源列表
										</a>
									</li>
								</ul>

							</li>
							<c:choose>
								<c:when test="${mm.role=='超级管理员'}">
									<li>
										<a href="#" class="dropdown-toggle"><i class="icon-user"></i><span class="menu-text"> 公司管理 </span><b class="arrow icon-angle-down"></b></a>
										<ul class="submenu">
											<li class="home"><a href="javascript:void(0)" name="factory/com_list" title="公司列表"  class="iframeurl"><i class="icon-double-angle-right"></i>公司列表</a></li>
										</ul>
									</li>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>

							<li><a href="#" class="dropdown-toggle"><i class="icon-group"></i><span class="menu-text"> 系统管理 </span><b class="arrow icon-angle-down"></b></a>
								<ul class="submenu">
									<c:choose>
										<c:when test="${mm.role=='超级管理员'}">
											<li class="home"><a href="javascript:void(0)" name="mg/quanxian" title="权限管理"  class="iframeurl"><i class="icon-double-angle-right"></i>权限管理</a></li>
										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>
                                	<li class="home"><a href="javascript:void(0)" name="mg/guanliyuan?manager_telephone=${mm.manager_telephone}" title="管理员列表" class="iframeurl"><i class="icon-double-angle-right"></i>管理员列表</a></li>
								</ul>
							</li>

						</ul>

					</div>
					<script type="text/javascript">
           $("#menu_style").niceScroll({  
	        cursorcolor:"#888888",  
	        cursoropacitymax:1,  
         	touchbehavior:false,  
	        cursorwidth:"5px",  
	        cursorborder:"0",  
	        cursorborderradius:"5px"  
            }); 
          </script>
					<div class="sidebar-collapse" id="sidebar-collapse">
						<i class="icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
					</div>
                    <script type="text/javascript">
						try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
					</script>
				</div>

				<div class="main-content">
                <script type="text/javascript">
							try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
						</script>
						<!-- 面包屑页面 -->
					<div class="breadcrumbs" id="breadcrumbs"> 
						<ul class="breadcrumb">
							<li>
								<i class="icon-home home-icon"></i>
								<a href="mg/index">首页</a>
							</li>
							<li class="active"><span class="Current_page iframeurl"></span></li>
                            <li class="active" id="parentIframe"><span class="parentIframe iframeurl"></span></li>
							<li class="active" id="parentIfour"><span class="parentIfour iframeurl"></span></li>
						</ul>
					</div>
                 

                 <!-- 设置主页默认显示页面    -->
                 <iframe id="iframe" style="border:0; width:100%; background-color:#FFF;"name="iframe" frameborder="0" src="<%=basePath%>/mg/home">  </iframe>
				 
<!-- /.page-content -->
				</div><!-- /.main-content -->	
                
                  <div class="ace-settings-container" id="ace-settings-container">
                      <div class="btn btn-app btn-xs btn-warning ace-settings-btn" id="ace-settings-btn">
                          <i class="icon-cog bigger-150"></i>
                      </div>
                      <div class="ace-settings-box" id="ace-settings-box">
                          <div>
                              <div class="pull-left">
                                  <select id="skin-colorpicker" class="hide">
                                      <option data-skin="default" value="#438EB9">#438EB9</option>
                                      <option data-skin="skin-1" value="#222A2D">#222A2D</option>
                                      <!-- <option data-skin="skin-2" value="#C6487E">#C6487E</option> -->
                                      <option data-skin="skin-3" value="#D0D0D0">#D0D0D0</option>
                                  </select>
                              </div>
                              <span>&nbsp; 选择皮肤</span>
                          </div>
                          <div>
                              <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-sidebar" />
                              <label class="lbl" for="ace-settings-sidebar"> 固定滑动条</label>
                          </div>
  
                          <div>
                              <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-rtl" />
                              <label class="lbl" for="ace-settings-rtl">切换到左边</label>
                          </div>
  
                          <div>
                              <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-add-container" />
                              <label class="lbl" for="ace-settings-add-container">
                                  切换窄屏
                                  <b></b>
                              </label>
                          </div>
                      </div>
                  </div><!-- /#ace-settings-container -->		
	</div><!-- /.main-container-inner -->
			
		</div>
         <!--底部样式-->
       
         <div class="footer_style" id="footerstyle">  
		 <script type="text/javascript">try{ace.settings.check('footerstyle' , 'fixed')}catch(e){}</script>
          <p class="l_f">版权所有：BUPT324  </p>
          <p class="r_f">地址：北京市海淀区西土城路10号 北京邮电大学<a href="http://www.mycodes.net/" target="_blank"></a></p>
         </div>
         <!--修改密码样式-->
         <div class="change_Pass_style" id="change_Pass">
            <ul class="xg_style">
             <li><label class="label_name">原&nbsp;&nbsp;密&nbsp;码</label><input name="原密码" type="password" class="" id="password"></li>
             <li><label class="label_name">新&nbsp;&nbsp;密&nbsp;码</label><input name="新密码" type="password" class="" id="Nes_pas"></li>
             <li><label class="label_name">确认密码</label><input name="再次确认密码" type="password" class="" id="c_mew_pas"></li>              
            </ul>          
         </div>
        <!-- /.main-container -->
		<!-- basic scripts -->
		</c:if>
</body>
</html>


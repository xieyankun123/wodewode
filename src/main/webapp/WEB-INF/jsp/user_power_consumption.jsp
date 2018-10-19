<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Cache-Control" content="no-siteapp" />
 <link href="static/assets/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="static/css/style.css"/>
        <link href="static/assets/css/codemirror.css" rel="stylesheet">
        <link rel="stylesheet" href="static/assets/css/ace.min.css" />
        <link rel="stylesheet" href="static/font/css/font-awesome.min.css" />
        <!--[if lte IE 8]>
		  <link rel="stylesheet" href="assets/css/ace-ie.min.css" />
		<![endif]-->
		<script src="static/js/jquery-1.9.1.min.js"></script>
        <script src="static/js/jquery.SuperSlide.2.1.1.js"></script>
        <script src="static/assets/js/bootstrap.min.js"></script>
		<script src="static/assets/js/typeahead-bs2.min.js"></script>
		<script src="static/assets/js/jquery.dataTables.min.js"></script>
		<script src="static/assets/js/jquery.dataTables.bootstrap.js"></script>
        <script src="static/assets/layer/layer.js" type="text/javascript" ></script>
        <script src="static/assets/laydate/laydate.js" type="text/javascript"></script>
        <script src="static/js/lrtk.js" type="text/javascript" ></script>
        <style type="text/css">
            .baozhe{height: 30px;border-bottom: 1px solid #ddd;}
            .xinxi{
                display: block;
                width: 108px;
                height: 33px;
                background: #fff;
                border: 1px solid #ddd;
                border-bottom: 2px solid #fff;
                color: #333333;
                line-height: 33px;
                text-align: center;
                font-size: 14px;
            }
            th{    color: #307ecc;}
        </style>
<title>用电量实时统计</title>
</head>

<body>
<div class="margin clearfix">
    <div class="Account_style">
<!--账户基本信息-->
  <!-- <span class="title_name">租户基本信息</span> -->
    <div class="baozhe">
             <span class="xinxi">租户基本信息</span>
    </div>
 <div class="Manager_style clearfix">
        <table class="table table-striped table-bordered table-hover">
            <thead>
                <tr style="color: #307ecc;font-weight:normal">
                    <th width="80">租户ID</th>
                    <th width="100">姓名</th>
                    <th width="80">性别</th>
                    <th width="120">手机</th> 
                    <th width="150">身份证号</th>
                    <th width="300">地址</th>
                </tr>
            </thead>
            <tbody>
<c:if test="${!empty user }">
            <div items="${user}" var="user">
                <tr>
                    <td>1</td>
                    <td>${user.user_name}</td>
                    <td>${user.user_sex}</td>
                    <td>${user.user_telephone}</td>
                    <td>${user.user_IDcard}</td>
                    <td class="text-l">${user.user_address}</td>
                </tr>
                </c:if>
            </tbody>
        </table>
 
 </div>

     <div class="baozhe">
             <span class="xinxi">房源基本信息</span>
    </div>
 <div class="Manager_style clearfix">
        <table class="table table-striped table-bordered table-hover">
            <thead>
                <tr style="color: #307ecc;font-weight:normal">
                    <th width="80">房源编号</th>
                    <th width="180">房源地址</th>
                    <th width="80">房源结构</th>
                    <th width="80">房东</th>
                </tr>
            </thead>
            <tbody>
    <c:if test="${!empty room }">
            <div items="${room}" var="room">
                <tr>
                    <td>${room.room_id}</td>
                    <td class="text-l">${room.room_loc}</td>
                    <td>${room.room_str}</td>
                    <td>${room.own}</td>
                    <!-- <td>13000000000</td> -->
                    <!-- <td>35081102346786</td> -->
                    
                </tr>
    </c:if>
            </tbody>
        </table>
 
 </div>
 <!--记录-->
     <div class="baozhe">
             <span class="xinxi" style="width:150px">用电量实时统计</span>
    </div>
 <div class="recording_style">
    <div id="recording">
        <div class="hd" style="border-bottom:solid 0px;">
            <ul>
                <li style="border:solid 1px #ddd;">私有电器</li>
            </ul>
        </div>
        <div class="bd">
            <ul class="">
                <table class="table table-striped table-bordered table-hover" id="sample-table">
                   <thead>
		                  <tr>

                                <th width="">电器编号</th>
                               <th width="">电器描述</th>
                               <th width="">实时电量</th>                 
                         </tr>
                    </thead>
	               <tbody>
<c:if test="${!empty apparatus1 }">
    <c:forEach items="${apparatus1}" var="apparatus1">
		               <tr>

                          <td>${apparatus1.id}</td>
                          <td>${apparatus1.beizhu}</td>
                          <td><a href="javascript:;"   title="点击查看实时电量" onclick="kan()"><img style="width:30px" src="static/images/zhexian.png"></a></td>
                        </tr>
    </c:forEach>
</c:if>
                    </tbody>
                </table>
            </ul>
        </div>
    </div>
 </div>
 <script type="text/javascript">jQuery("#recording").slide({trigger:"click" });</script>


 <div class="recording_style">
    <div id="recording">
        <div class="hd" style="border-bottom:solid 0px;">
            <ul>
                <li style="border:solid 1px #ddd;">公共区域电器</li>
            </ul>
        </div>
        <div class="bd">
            <ul class="">
                <table class="table table-striped table-bordered table-hover" id="sconsumption-table">
                   <thead>
                      <tr>

                                <th width="">电器编号</th>
                               <th width="">电器描述</th>
                               <th width="">实时电量</th>                 
                         </tr>
                    </thead>
                 <tbody>
<c:if test="${!empty apparatus0 }">
    <c:forEach items="${apparatus0}" var="apparatus0">
                   <tr>

                          <td>${apparatus0.id}</td>
                          <td>${apparatus0.beizhu}</td>
                         <td><a href="javascript:;"   title="点击查看实时电量" onclick="kan()"><img style="width:30px" src="static/images/zhexian.png"></a></td>
                        </tr>
    </c:forEach>
</c:if>
                    </tbody>
                </table>
            </ul>
        </div>
    </div>
 </div>
</div>
</div>


</body>
</html>

<script type="text/javascript">

// 编写筛选函数
jQuery(function($) {
		var oTable1 = $('#sample-table').dataTable( {
            "ordering":false,
		"bStateSave": true,//状态保存
		"bAutoWidth":true,
		"bFilter":false,
            "paging":   false,  //分页功能
            "info":false,
		"aoColumnDefs": [
		  //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
		  {"orderable":false,"aTargets":[0,2,3]}// 制定列不参与排序
		] 
  } );

		var recording = $('#sconsumption-table').dataTable( {
            "ordering":false,
		"bStateSave": true,//状态保存
		"bAutoWidth":true,
		"bFilter":false,
            "paging":   false,  //分页功能
            "info":false,
		"aoColumnDefs": [
		  {"orderable":false,"aTargets":[0,2,3]}// 制定列不参与排序
		] } );
		
				$('table th input:checkbox').on('click' , function(){
					var that = this;
					$(this).closest('table').find('tr > td:first-child input:checkbox')
					.each(function(){
						this.checked = that.checked;
						$(this).closest('tr').toggleClass('selected');
					});
						
				});	
});
function kan(){
  layer.open({
  type: 2,
  title: '查看实时电量',  
  skin: 'layui-layer-rim', //加上边框
  area: ['600px', '480px'], //宽高
  content: 'apparatus/tp'
});
}
</script>
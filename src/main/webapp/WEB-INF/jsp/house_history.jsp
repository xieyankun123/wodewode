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
            a{color:black!important}
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
        </style>
<title>房源被租历史</title>
</head>

<body>
<div class="margin clearfix">
    <div class="Account_style">
<!--账户基本信息-->
  <!-- <span class="title_name">租户基本信息</span> -->
    <div class="baozhe">
             <span class="xinxi">房源基本信息</span>
    </div>
 <div class="Manager_style clearfix">
        <table class="table table-striped table-bordered table-hover">
            <thead>
                <tr style="color:#307ecc;">
                    <th width="80">房源编号ID</th>
                    <th width="100">地址</th>
                    <th width="100">房东</th>
                    <th width="80">房间结构</th>
                    <!-- <th width="120">手机</th>  -->
                    <!-- <th width="150">身份证号</th> -->
                    <!-- <th width="">地址</th> -->
                </tr>
            </thead>
            <tbody>
<c:if test="${!empty room }">
    <div items="${room}" var="room">
                <tr>
                    <td>${room.room_id}</td>
                    <td class="text-l">${room.room_loc}</td>
                    <td>${room.own}</td>
                    <td>${room.room_str}</td>
                    <!-- <td>男</td> -->
                    <!-- <td>13000000000</td> -->
                    <!-- <td>35081102346786</td> -->
                    
                </tr>
        </c:if>
            </tbody>
        </table>
 
 </div>
 <!--记录-->
 <div class="recording_style">
    <div id="recording">
        <div class="hd">
            <ul>
                <li>租房记录</li>
            </ul>
        </div>
        <div class="bd">
            <ul class="">
                <table class="table table-striped table-bordered table-hover" id="sample-table">
                   <thead>
		                  <tr>
                                
                                <th width="">租房编号</th>
                               <th width="">租户ID</th>
                                <th width="">租户姓名</th>
                               <th width="">入住时间</th>
                             <th width="">退租时间</th> 
                              <th width="">用电量实时统计</th> 
                             <th>水电气统计</th>                    
                         </tr>
                    </thead>
	               <tbody>
<c:if test="${!empty user_room }">
    <c:forEach items="${user_room}" var="user_room">
		               <tr>
                          <td>1</td>
                          <td><a href="#" title="点击查看租户租用历史" onclick=" tiao_zuhu('1')">1</a></td>
                          <td>${user_room.username}</td>
                          <td>${user_room.in_time}</td>
                          <td>${user_room.out_time}</td>
                          <td><a href="<%=basePath%>apparatus/yqinfoU?user_telephone=${user_room.user_telephone}&&room_id=${user_room.room_id}" title="点击查看"><img style="width:30px" src="static/images/tongji.png"></a></td>
                           <td><a href="<%=basePath%>meter/sdq?user_telephone=${user_room.user_telephone}&&room_id=${user_room.room_id}" title="点击查看"><img style="width:25px" src="static/images/water.png"></a></td>
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
</div>
</div>
</body>
</html>

<script type="text/javascript">

// 编写筛选函数
jQuery(function($) {
		var oTable1 = $('#sample-table').dataTable( {
		"aaSorting": [[ 1, "desc" ]],//默认第几个排序
		"bStateSave": true,//状态保存
		"bAutoWidth":true,
		"bFilter":false,
		"aoColumnDefs": [
		  //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
		  {"orderable":false,"aTargets":[1,2,3,4,5,6]}// 制定列不参与排序
		] } );
		var recording = $('#sconsumption-table').dataTable( {
		"aaSorting": [[ 1, "desc" ]],//默认第几个排序
		"bStateSave": true,//状态保存
		"bAutoWidth":true,
		"bFilter":false,
		"aoColumnDefs": [
		  {"orderable":false,"aTargets":[0,1,2,3,5,6,7,8]}// 制定列不参与排序
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

function house_power_consumption(id){
    window.location.href ="user_power_consumption.html?="+id;
};
function house_water_account(id){
    window.location.href ="user_water_account.html?="+id;
}
function tiao_zuhu(id){
  window.location.href ="user_history.html?="+id;
}

</script>
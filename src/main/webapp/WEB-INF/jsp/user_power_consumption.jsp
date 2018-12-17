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
        <%--日期插件--%>
        <script src="static/js/bootstrap-datetimepicker.min.js" type="text/javascript" ></script>
         <link rel="stylesheet" href="static/css/bootstrap-datetimepicker.min.css" />
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
                    <td id="tele_v">${user.user_telephone}</td>
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
                    <td id="room_id_v">${room.room_id}</td>
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
                                 <th width="">总用电量(度)(${intime}-${outtime})</th>
                               <th width="">实时电量</th>                 
                         </tr>
                    </thead>
	               <tbody>
<c:if test="${!empty apparatus1 }">
    <c:forEach items="${apparatus1}" var="apparatus1">
		               <tr>

                          <td>${apparatus1.id}</td>
                          <td>${apparatus1.beizhu}</td>
                           <td>${apparatus1.totel}</td>
                          <td><a href="javascript:;"   title="点击查看实时电量" onclick="kan('${apparatus1.id}','${user.user_telephone}')"><img style="width:30px" src="static/images/zhexian.png"></a></td>
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
                          <th width="">总用电量(度)(${intime}-${outtime})</th>
                               <th width="">实时电量</th>                 
                         </tr>
                    </thead>
                 <tbody>
<c:if test="${!empty apparatus0 }">
    <c:forEach items="${apparatus0}" var="apparatus0">
                   <tr>

                          <td>${apparatus0.id}</td>
                          <td>${apparatus0.beizhu}</td>
                       <td>${apparatus0.totel}</td>
                         <td><a href="javascript:;"   title="点击查看实时电量" onclick="kan('${apparatus0.id}','${user.user_telephone}')"><img style="width:30px" src="static/images/zhexian.png"></a></td>
                        </tr>
    </c:forEach>
</c:if>
                    </tbody>
                </table>
            </ul>
        </div>
    </div>

     <div id="recording">
         <div class="hd" style="border-bottom:solid 0px;">
             <ul>
                 <li style="border:solid 1px #ddd;">用电量统计</li>
             </ul>
         </div>

         <%--时间框--%>
         <div class="search_style">
         <ul class="search_content clearfix">
             <li>
                 <label class="label_name">起始时间：</label>
                 <span class="add_name">
                   <input size="16" type="text" value="" readonly id="date_s">
                  </span>
             </li>
             <li><label class="label_name">结束时间：</label>
                 <span class="add_name">
                   <input size="16" type="text" value="" readonly id="date_e">
                </span>
             </li>
             <li style="width:90px;"><button type="button" class="btn_search" id="ss"><i class="icon-search"></i>查询</button></li>
         </ul>
         <div class="search_style">
         <table class="table table-striped table-bordered table-hover" id="sconsumption-table" style="margin-top:30px">
             <thead>
             <tr>

                 <th width="">区域</th>
                 <th width="">用电量(度)</th>
             </tr>
             </thead>
             <tr>
                 <td>私有区域</td>
                 <td id="siyou">--</td>
             </tr>
             <tr>
                 <td>公有区域(个人用电)</td>
                 <td id="gong_ge">--</td>
             </tr>
             <tr>
                 <td>用户用电总计</td>
                 <td id="zong_ge">--</td>
             </tr>
             <tr>
                 <td>公有区域(房间总计)</td>
                 <td id="gong_fang">--</td>
             </tr>
             <tr>
                 <td>公寓总计</td>
                 <td id="zong">--</td>
             </tr>
             <tbody>
             </tbody>
         </table>
     </div>
 </div>
</div>
</div>


</body>
</html>

<script type="text/javascript">

// 编写筛选函数
jQuery(function($) {
    $.fn.datetimepicker.dates['zh'] = {
        days:       ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六","星期日"],
        daysShort:  ["日", "一", "二", "三", "四", "五", "六","日"],
        daysMin:    ["日", "一", "二", "三", "四", "五", "六","日"],
        months:     ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月","十二月"],
        monthsShort:  ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"],
        meridiem:    ["上午", "下午"],
        today:       "今天"
    };
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
        function GetDateStr(AddDayCount) { 
        var dd = new Date(); 
        dd.setDate(dd.getDate()+AddDayCount);//获取AddDayCount天后的日期 
        var y = dd.getFullYear(); 
        var m = dd.getMonth()+1;//获取当前月份的日期 
        var d = dd.getDate(); 
        return y+"-"+m+"-"+d; 
        } 
    // 设置弹出时间
    $('#date_s').datetimepicker({
            language:'zh',
            format: 'yyyy-mm-dd',
            minView: "month",//设置只显示到月份
            // todayHighlight:"false",    //今天日期高亮
            // todayBtn:"true",     //显示今天的按钮
            autoclose:true, //选择一个日期后自动关闭
            startDate:new Date("2018-12-10"),
            endDate:new Date(GetDateStr(-1)),
            initialDate:new Date("2018-12-10")   
    });
    $('#date_e').datetimepicker({
            language:'zh',
            format: 'yyyy-mm-dd',
            minView: "month",//设置只显示到月份
            // todayHighlight:"false",    //今天日期高亮
            // todayBtn:"true",     //显示今天的按钮
            autoclose:true, //选择一个日期后自动关闭
            startDate:new Date("2018-12-10"),
            endDate:new Date(GetDateStr(-1)),
            initialDate:new Date(GetDateStr(-1))  
    });

//查询电量函数
    function search_ele(){
        var date_start=$('#date_s').val(); //拿到选中项的文本
        var date_end=$('#date_e').val();
        var room_id=$('#room_id_v').html()
        var user_telephone=$('#tele_v').html()
        //  alert(date_start);
        // alert(date_end);
        // alert(room_id);
        // alert(user_telephone);
        var s =$('#date_s').val();
        var e =$('#date_e').val();
        if(s==""){alert("请选择起始时间！")}
        else if (e=="") {alert("请选择结束时间！")}
        else if(s>e){alert("结束时间不能小于起始时间，请重新选择！")}
        else{
                // alert(s+" "+e+"可以开始查询了")
            $.ajax({
                type: "POST",
                url: '<%=basePath%>/apparatus/Statistic',
                data: {date_start:date_start,date_end:date_end,room_id:room_id,
                    user_telephone:user_telephone},
                dataType:'json',
                cache: false,
                success: function(data){
                    console.log("success");
                    $('#siyou').html(data.sum1);
                    $('#gong_ge').html(data.sum2);
                    $('#zong_ge').html(data.sum3);
                    $('#gong_fang').html(data.sum4);
                    $('#zong').html(data.sum5);
                }
            });
        }


        // $('#date_s').val("0000-00-00");
        // $('#date_e').val("0000-00-00");
        // $('#siyou').html("1");
        // $('#gong_ge').html("2");
        // $('#zong_ge').html("3");
        // $('#gong_fang').html("4");
        // $('#zong').html("5");

    };
    $('#ss').click(function(){
        search_ele();
    });
});
function kan(a,b){
    var aa=a;
    var bb=b
  layer.open({
  type: 2,
  title: '查看实时电量',
  skin: 'layui-layer-rim', //加上边框
  area: ['620px', '500px'], //宽高
  content:"apparatus/tp?apparatus_id="+aa+"&user_telephone="+bb+""
});
}
</script>
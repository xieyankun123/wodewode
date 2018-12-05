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
    <link rel="stylesheet" href="static/assets/css/font-awesome.min.css" />
    <!--[if IE 7]>
    <link rel="stylesheet" href="static/assets/css/font-awesome-ie7.min.css" />
    <![endif]-->
    <!--[if lte IE 8]>
    <link rel="stylesheet" href="static/assets/css/ace-ie.min.css" />
    <![endif]-->
      <link rel="stylesheet" href="static/assets/css/ace-ie.min.css" />
    <link rel="stylesheet" href="static/css/bootstrap-datetimepicker.min.css" />
    <script src="static/js/jquery-1.9.1.min.js"></script>
    <script src="static/js/jquery.SuperSlide.2.1.1.js"></script>
    <script src="static/assets/js/bootstrap.min.js"></script>
    <script src="static/assets/js/typeahead-bs2.min.js"></script>
    <script src="static/assets/js/jquery.dataTables.min.js"></script>
    <script src="static/assets/js/jquery.dataTables.bootstrap.js"></script>
    <script src="static/assets/layer/layer.js" type="text/javascript" ></script>
    <script src="static/assets/laydate/laydate.js" type="text/javascript"></script>
    <script src="static/js/lrtk.js" type="text/javascript" ></script>
    <script src="static/js/bootstrap-datetimepicker.min.js" type="text/javascript" ></script>
    <script src="static/myjs/user_history.js" type="text/javascript" ></script>
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
    </style>
<title>租户租房历史</title>
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
                    <th width="80">ID</th>
                    <th width="100">姓名</th>
                    <th width="80">性别</th>
                    <th width="120">手机</th> 
                    <th width="150">身份证号</th>
                    <th width="200">地址</th>
                </tr>
            </thead>
            <tbody>
    <c:if test="${!empty user }">
        <div items="${user}" var="user">
                <tr>
                    <td>1</td>
                    <td id="xingming">${user.user_name}</td>
                    <td>${user.user_sex}</td>
                    <td id="shoujihao">${user.user_telephone}</td>
                    <td>${user.user_IDcard}</td>
                    <td class="text-l">${user.user_address}</td>
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
		                  <tr style="color: #307ecc;">

                                <th width="">租房序号</th>
                               <th width="">房源编号</th>
                               <th width="">入住时间</th>
                             <th width="">退租时间</th> 
                              <th width="">用电量实时统计</th> 
                             <th>水电气统计</th>
                              <th width="">操作</th>
                         </tr>
                    </thead>
	               <tbody>
        <c:if test="${!empty user_room }">
                <c:forEach items="${user_room}" var="user_room" varStatus="status">
                    <div items="${user}" var="user">
		               <tr>
                           <td>${status.index+1}</td>
                          <td>${user_room.room_id}</td>
                          <td>${user_room.in_time}</td>
                          <td>${user_room.out_time}</td>
                          <td><a href="<%=basePath%>apparatus/yqinfoU?user_telephone=${user.user_telephone}&&room_id=${user_room.room_id}" title="点击查看" ><img style="width:30px" src="static/images/tongji.png"></a></td>
                           <td><a href="<%=basePath%>meter/sdq?user_telephone=${user.user_telephone}&&room_id=${user_room.room_id}" title="点击查看" ><img style="width:25px" src="static/images/water.png"></a></td>
                           <td class="td-manage">
                               <a title="编辑" onclick="jilv_edit(this,'${user_room.id}','${user_room.user_number}')" href="javascript:;"  class="btn btn-xs btn-info" ><i class="icon-edit bigger-120""></i></a>
                           </td>
                        </tr>
                </c:forEach>
        </c:if>
                    </tbody>
                </table>

                <%--添加记录的按钮--%>
                <div class="border clearfix" style="border:0px">
                     <span class="l_f">
                            <a href="javascript:ovid()" id="member_add" class="btn btn-warning"><i class="icon-plus"></i>添加记录</a>
                     </span>
                </div>
            </ul>
        </div>
    </div>

 </div>
 <script type="text/javascript">jQuery("#recording").slide({trigger:"click" });</script>
</div>
</div>


<!--添加记录-->
<div class="add_menber" id="add_menber_style" style="display:none">

    <ul class=" page-content">
        <li><label class="label_name">租户手机：</label>
            <span class="add_name">
                <input value="" name="租户手机" type="text" data-shu="zuhushouji" readonly="readonly" class="text_add"/>
            </span><div class="prompt r_f"></div>
        </li>
        <li><label class="label_name">租户姓名：</label>
            <span class="add_name">
                <input value="" name="房源编号" type="text" data-shu="xingming"  readonly="readonly" class="text_add"/>
            </span><div class="prompt r_f"></div>
        </li>
        <li><label class="label_name">房源编号：</label>
            <span class="add_name">
                <input value="" name="房源编号" type="text" data-shu="fangyuanbianhao" class="text_add"/>
            </span><div class="prompt r_f"></div>
        </li>
        <li><label class="label_name">入住时间：</label>
            <span class="add_name">
                <input value="" name="入住时间"  type="text" data-shu="ruzhutime" class="text_add" readonly id="add_ru"/>
            </span><div class="prompt r_f"></div>
        </li>
        <li><label class="label_name">退租时间：</label>
            <span class="add_name">
                <input value="" name="退租时间" type="text" data-shu="tuizutime" class="text_add" readonly id="add_tui"/ >
            </span><div class="prompt r_f"></div>
        </li>
        <li><label class="label_name">住户人数：</label>
            <span class="add_name">
                <input value="" name="住户人数" type="text" data-shu="zurenshu" class="text_add"/>
            </span><div class="prompt r_f"></div>
        </li>
    </ul>
</div>


<!--修改记录-->
<div class="add_menber" id="add_menber_style2" style="display:none">

    <ul class=" page-content">
        <li><label class="label_name">租户手机：</label>
            <span class="add_name">
                <input value="" name="租户手机" type="text" data-shu="zuhushouji" readonly="readonly" class="text_add"/>
            </span><div class="prompt r_f"></div>
        </li>
        <li><label class="label_name">租户姓名：</label>
            <span class="add_name">
                <input value="" name="房源编号" type="text" data-shu="xingming"  readonly="readonly" class="text_add"/>
            </span><div class="prompt r_f"></div>
        </li>
        <li><label class="label_name">房源编号：</label>
            <span class="add_name">
                <input value="" name="房源编号" type="text" data-shu="fangyuanbianhao" class="text_add"/>
            </span><div class="prompt r_f"></div>
        </li>
        <li><label class="label_name">入住时间：</label>
            <span class="add_name">
                <input value="" name="入住时间"  type="text" data-shu="ruzhutime" class="text_add" readonly id="edit_ru" />
            </span><div class="prompt r_f"></div>
        </li>
        <li><label class="label_name">退租时间：</label>
            <span class="add_name">
                <input value="" name="退租时间" type="text" data-shu="tuizutime" class="text_add" readonly id="edit_tui"/>
            </span><div class="prompt r_f"></div>
        </li>
        <li><label class="label_name">住户人数：</label>
            <span class="add_name">
                <input value="" name="住户人数" type="text" data-shu="zurenshu" class="text_add"/>
            </span><div class="prompt r_f"></div>
        </li>
    </ul>
</div>

</body>
</html>

<script type="text/javascript">

// 编写筛选函数
jQuery(function($) {

         var oTable1 = $('#sample-table').dataTable({
        "aaSorting": [[ 0, "asc" ]],//默认第几个排序
        "paging": true,  //分页功能
        "filter":false,   //搜索功能
        "aoColumnDefs": [
        {"orderable":false,"aTargets":[1,2,3,4,5,6]}// 制定列不参与排序
        ] 
      });
				$('table th input:checkbox').on('click' , function(){
					var that = this;
					$(this).closest('table').find('tr > td:first-child input:checkbox')
					.each(function(){
						this.checked = that.checked;
						$(this).closest('tr').toggleClass('selected');
					});
						
				});	
});


function user_power_consumption(id){
    window.location.href ="user_power_consumption.html?="+id;
};
function user_water_account(id){
    window.location.href ="user_water_account.html?="+id;
}
// 添加和编辑函数
window.onload=function () {



    // 添加函数
    $('#member_add').on('click', function(){
        var xingming=$("#xingming").html();
        var shoujihao=$("#shoujihao").html();
        $("#add_menber_style input[data-shu='xingming']").val(xingming);
        $("#add_menber_style input[data-shu='zuhushouji']").val(shoujihao);
        layer.open({
            type: 1,
            title: '添加记录',
            maxmin: true,
            shadeClose: true, //点击遮罩关闭层
            area : ['800px' , ''],
            content:$('#add_menber_style'),
            success:function(layero,index){
                $('#add_ru').datetimepicker({
                    language:'zh',
                    format: 'yyyy-mm-dd',
                    minView: "month",//设置只显示到月份
                    todayBtn:"true"
                });
                $('#add_tui').datetimepicker({
                    language:'zh',
                    format: 'yyyy-mm-dd',
                    minView: "month",//设置只显示到月份
                    todayBtn:"true"
                });
            },
            btn:['提交','取消'],
            yes:function(index,layero){
                var num=0;
                var str="";
                $("#add_menber_style input[type$='text']").each(function(n){
                    if($(this).val()=="")
                    {

                        layer.alert(str+=""+$(this).attr("name")+"不能为空！\r\n",{
                            title: '提示框',
                            icon:0,
                        });
                        num++;
                        return false;
                    }
                });
                if(num>0){  return false;}
                else{

                    layer.alert('添加成功！',{
                        title: '提示框',
                        icon:1,
                        yes: function(index){
                            window.location="<%=basePath%>/u_r/historyU?user_telephone="+shoujihao+"";
                            layer.close(index);
                        }

                    });

                    layer.close(index);
                    addjilv(shoujihao);
                }
            }
        });

    });

// 添加记录到后台
    function addjilv(tele){
        var tele1=tele;
        var fangyuanbianhao1=$("#add_menber_style input[data-shu='fangyuanbianhao']").val();
        var ruzhutime= $("#add_menber_style input[data-shu='ruzhutime']").val();
        var tuizutime=$("#add_menber_style input[data-shu='tuizutime']").val();
        var zuhurenshu=$("#add_menber_style input[data-shu='zurenshu']").val();
        $.ajax({
            type: "POST",
            url: 'u_r/add',
            data: {user_telephone:tele1,room_id:fangyuanbianhao1,
                in_time:ruzhutime,out_time:tuizutime,user_number:zuhurenshu},
            dataType:'json',
            cache: false,
            success: function(data){
                console.log("success");
            }
        });

    }
    $.fn.datetimepicker.dates['zh'] = {
        days:       ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六","星期日"],
        daysShort:  ["日", "一", "二", "三", "四", "五", "六","日"],
        daysMin:    ["日", "一", "二", "三", "四", "五", "六","日"],
        months:     ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月","十二月"],
        monthsShort:  ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"],
        meridiem:    ["上午", "下午"],
        today:       "今天"
    };



}

// 编辑函数
function jilv_edit(obj,id,renshu) {
    // alert(id);
    // // alert(zufangbianhao);
    // // 获取该条记录的信息
    var xingming2=$("#xingming").html();
    var shoujihao2=$("#shoujihao").html();
    var fangyuanbianhao2=$(obj).parent().parent().find("td").eq(1).html();
    var ruzhutime2=$(obj).parent().parent().find("td").eq(2).html();
    var tuizutime2=$(obj).parent().parent().find("td").eq(3).html();
    // alert(fangyuanbianhao2);
    // alert(ruzhutime2);
    // alert(tuizutime2);
    //
    // 信息赋值到编辑框中
    $("#add_menber_style2 input[data-shu='xingming']").val(xingming2);
    $("#add_menber_style2 input[data-shu='zuhushouji']").val(shoujihao2);
    $("#add_menber_style2 input[data-shu='fangyuanbianhao']").val(fangyuanbianhao2);
    $("#add_menber_style2 input[data-shu='ruzhutime']").val(ruzhutime2);
    $("#add_menber_style2 input[data-shu='tuizutime']").val(tuizutime2);
    $("#add_menber_style2 input[data-shu='zurenshu']").val(renshu);


    layer.open({
        type: 1,
        title: '修改租户信息',
        maxmin: true,
        shadeClose:false, //点击遮罩关闭层
        area : ['800px' , ''],
        content:$('#add_menber_style2'),
        success:function(layero,index){
            $('#edit_ru').datetimepicker({
                language:'zh',
                format: 'yyyy-mm-dd',
                minView: "month",//设置只显示到月份
                todayBtn:"true"
            });
            $('#edit_tui').datetimepicker({
                language:'zh',
                format: 'yyyy-mm-dd',
                minView: "month",//设置只显示到月份
                todayBtn:"true"
            });
        },
        btn:['提交','取消'],
        yes:function(index,layero){
            var num=0;
            var str="";
            $("#add_menber_style2 input[type$='text']").each(function(n){
                if($(this).val()=="")
                {

                    layer.alert(str+=""+$(this).attr("name")+"不能为空！\r\n",{
                        title: '提示框',
                        icon:0,

                    });
                    num++;
                    return false;
                }
            });
            if(num>0){  return false;}
            else{
                layer.alert('修改成功！',{
                    title: '提示框',
                    icon:1,
                    yes: function(index){
                         window.location="<%=basePath%>/u_r/historyU?user_telephone="+shoujihao2+"";
                        console.log(1);

                        layer.close(index);
                    }
                });

                layer.close(index);
                upjilv(id,shoujihao2);
            }
        }
    });
}

function upjilv(id,tele){

    var fangyuanbianhao2=$("#add_menber_style2 input[data-shu='fangyuanbianhao']").val();
    var ruzhutime2=$("#add_menber_style2 input[data-shu='ruzhutime']").val();
    var tuizutime2= $("#add_menber_style2 input[data-shu='tuizutime']").val();
    var renshu2 =$("#add_menber_style2 input[data-shu='zurenshu']").val();
    console.log("提取获取了更新的数据");

    $.ajax({
        type: "POST",
        url: 'u_r/update',
        data: {id:id,user_telephone:tele,room_id:fangyuanbianhao2,
            in_time:ruzhutime2,out_time:tuizutime2,user_number:renshu2},
        dataType:'json',
        cache: false,
        success: function(data){
            console.log("success");
        }
    });

}

$.fn.datetimepicker.dates['zh'] = {
    days:       ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六","星期日"],
    daysShort:  ["日", "一", "二", "三", "四", "五", "六","日"],
    daysMin:    ["日", "一", "二", "三", "四", "五", "六","日"],
    months:     ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月","十二月"],
    monthsShort:  ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"],
    meridiem:    ["上午", "下午"],
    today:       "今天"
};
</script>
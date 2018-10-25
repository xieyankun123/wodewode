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
    <script >

    </script>
        <style type="text/css">
            th{color: #547ea8;}
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
            .paizhao{width: 30px;}
            .edit_xie li {
    margin: 10px 0px;
    height: 40px;
    line-height: 40px;
    float: left;
    width: 100%;
}
.kuang {
    background: #fff;
    margin: 0;
    padding: 0px 15px;
}
.tishi_wenzi{font-size: 14px;font-weight: bold; color: #307ecc;margin-bottom: 5px}
        </style>
<title>水电气实时统计</title>
</head>

<body>
<div class="margin clearfix">
    <div class="Account_style">
<!--账户基本信息-->
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
  <!--    <div class="baozhe">
             <span class="xinxi">用户用电量实时统计</span>
    </div> -->
        <div class="recording_style">
            <div id="recording">
                <div class="hd" >
                    <ul>
                        <li >水电气表的结算</li>
                    </ul>
                </div>

                <div class="bd">
                    <ul>
                        <div class="biaoming"><span>水表</span></div>
                        <table class="table table-striped table-bordered table-hover" id="sample-table">
                            <thead>
                            <tr>

                                <th width="">拍照时间</th>
                                <th width="" >拍照图片</th>
                                <th width="">填写数据</th>
                            </tr>

                            </thead>
                            <tbody>
<c:if test="${!empty water }">
    <c:forEach items="${water}" var="water" varStatus="status">
                            <tr>
                                <td>${water.time}</td>
                                <td><a href="javascript:;" class="shui"  data-tupian="${water.picture}"><img class="paizhao" src="static/images/paizhao.png" ></a></td>
                                <%--<td><a href="javascript:;" onclick="tianshuju('5')"><img class="paizhao" src="static/images/xie.png"></a></td>--%>
                                <c:choose>
                                    <c:when test="${water.value==Null}">
                                        <td><a href="javascript:;" onclick="tianshuju(this,${water.id},'updateW','${user.user_telephone}','${room.room_id}')" data-tupian="${water.picture}"><img class="paizhao" src="static/images/xie.png" ></a></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>${water.value}</td>
                                    </c:otherwise>
                                </c:choose>
                            </tr>
    </c:forEach>
</c:if>
                            </tbody>
                        </table>
                    </ul>
                </div> <!-- bd -->
                <div class="bd">
                    <ul>
                        <div class="biaoming"><span>电表</span></div>
                        <table class="table table-striped table-bordered table-hover" id="sample-table">
                            <thead>
                            <tr>

                                <th width="">拍照时间</th>
                                <th width="" >拍照图片</th>
                                <th width="">填写数据</th>
                            </tr>

                            </thead>
                            <tbody>
                            <c:if test="${!empty dian }">
                                <c:forEach items="${dian}" var="dian" varStatus="status">
                                    <tr>
                                        <td>${dian.time}</td>
                                        <td><a href="javascript:;" class="shui"  data-tupian="${dian.picture}"><img class="paizhao" src="static/images/paizhao.png" ></a></td>
                                            <%--<td><a href="javascript:;" onclick="tianshuju('5')"><img class="paizhao" src="static/images/xie.png"></a></td>--%>
                                        <c:choose>
                                            <c:when test="${dian.value==Null}">
                                                <td><a href="javascript:;" onclick="tianshuju(this,${dian.id},'updateA','${user.user_telephone}','${room.room_id}')"  data-tupian="${dian.picture}"><img class="paizhao" src="static/images/xie.png" ></a></td>

                                            </c:when>
                                            <c:otherwise>
                                                <td>${dian.value}</td>
                                            </c:otherwise>
                                        </c:choose>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            </tbody>
                        </table>
                    </ul>
                </div> <!-- bd -->
                <div class="bd">
                    <ul>
                        <div class="biaoming"><span>气表</span></div>
                        <table class="table table-striped table-bordered table-hover" id="sample-table">
                            <thead>
                            <tr>

                                <th width="">拍照时间</th>
                                <th width="" >拍照图片</th>
                                <th width="">填写数据</th>
                            </tr>

                            </thead>
                            <tbody>
                            <c:if test="${!empty gas }">
                                <c:forEach items="${gas}" var="gas" varStatus="status">
                                    <tr>
                                        <td>${gas.time}</td>
                                        <td><a href="javascript:;" class="shui"  data-tupian="${gas.picture}"><img class="paizhao" src="static/images/paizhao.png" ></a></td>
                                            <%--<td><a href="javascript:;" onclick="tianshuju('5')"><img class="paizhao" src="static/images/xie.png"></a></td>--%>
                                        <c:choose>
                                            <c:when test="${gas.value==Null}">
                                                <td><a href="javascript:;" onclick="tianshuju(this,${gas.id},'updateG','${user.user_telephone}','${room.room_id}')"  data-tupian="${gas.picture}"><img class="paizhao" src="static/images/xie.png" ></a></td>

                                            </c:when>
                                            <c:otherwise>
                                                <td>${gas.value}</td>
                                            </c:otherwise>
                                        </c:choose>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            </tbody>
                        </table>
                    </ul>
                </div> <!-- bd -->
            </div>
        </div>
 <script type="text/javascript">jQuery("#recording").slide({trigger:"click" });</script>



</div>
</div>

<!-- 弹出拍照图片 -->
<div id="paizhaotupiao" style="display:none">
    <div class="kuang">
        <div class="tu" style="width:300px">
            <div class="tishi_wenzi">租户拍摄照片如下</div>
            <img style="width:100%" src="../images/dianbiao.png">
        </div>
    </div>
</div>

<div id="tianxie" style="width:500px;display:none" >
    <div class="kuang">
        <div class="tu" style="width:300px">
            <div class="tishi_wenzi">用户拍摄照片如下，请填入数据</div>
            <img style="width:100%" src="static/images/dianbiao.png">
        </div>
        <div class="tian">
            <ul class="edit_xie">
                <%--<li><label class="label_name">拍照时间：</label><span class="add_name"><input value="2018年9月25日" name="拍照时间" type="text"  class="text_add"/></span></li>--%>
                <%--<li><label class="label_name">拍&nbsp;&nbsp;照&nbsp;&nbsp;人：</label><span class="add_name"><input value="张三" name="拍照人" type="text"  class="text_add"/></span></li>--%>
                <li><label class="label_name">填写数据：</label><span class="add_name"><input value="" name="数据" type="text" id="biaoshu" class="text_add"/></span></li>
            </ul>

        </div>
    </div>

</div>

</body>
</html>

<script type="text/javascript">

// 编写筛选函数
jQuery(function($) {
		var oTable1 = $('#sample-table').dataTable( {
		// "aaSorting": [[ 1, "asc" ]],//默认第几个排序
    "ordering": false,
		"bStateSave": true,//状态保存
		"bAutoWidth":true,
    "info": false,
    "paging":false,  //分页功能
		"bFilter":false,
		"aoColumnDefs": [
		  //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
		  {"orderable":false,"aTargets":[0,1,2,3,4,5,6]}// 制定列不参与排序
		] } );


    // 设置成全选
				$('table th input:checkbox').on('click' , function(){
					var that = this;
					$(this).closest('table').find('tr > td:first-child input:checkbox')
					.each(function(){
						this.checked = that.checked;
						$(this).closest('tr').toggleClass('selected');
					});
						
				});	
});


window.onload = function () {
    $('.shui').on('click', function(){

        var lv=$(this).attr("data-tupian");
        // alert(lv);
        $('#paizhaotupiao img').attr('src',lv);
        layer.open({
            type: 1,
            title: "查看租户拍摄的照片",
            content: $('#paizhaotupiao'),
            area: ['500px']
        });
    })

}





// 编写函数让管理员填写水电气表的数据
function tianshuju(obj,id,path,userte,roomid){
    // alert($(obj))
    $("#biaoshu").val("");
    var lv=$(obj).attr("data-tupian");
    $('#tianxie img').attr('src',lv);
    // alert(id);
    // alert(path);
    // alert(1);
    // alert(lv);
    layer.open({
        type: 1,
        title: "填写数据",
        content: $('#tianxie'),
        btn:['保存','取消'],
        area: ['500px', '500px'],
        yes:function(index,layero){
            var num=0;
            var str="";
            $("#tianxie input[type$='text']").each(function(n){
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
            if(num>0){ return false;}
            else{
                layer.alert('保存成功！',{
                    title: '提示框',
                    icon:1,
                    yes: function(index){
                        window.location="<%=basePath%>/meter/sdq?user_telephone="+userte+"&room_id="+roomid+"";
                        console.log(1);
                        layer.close(index);
                    }
                });
                gochuanshu(id,path);
                layer.close(index);
            }
        }
    });
}
function gochuanshu(biaoid,lvjing){

    var zhi= $("#biaoshu").val();
    // alert(zhi);
    $.ajax({
        type: "POST",
        url: 'meter/'+lvjing,
        data: {id:biaoid,value:zhi},
        dataType:'json',
        cache: false,
        success: function(data){
            console.log("success");
        }
    });
}

</script>
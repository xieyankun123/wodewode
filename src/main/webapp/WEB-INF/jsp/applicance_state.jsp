<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
        #kongxian{background-color:#82af6f!important;}
        .zhuangtai{

            border-radius: 0;
            text-shadow: none;
            font-weight: normal;
            display: inline-block;
            font-size: 12px;
            line-height: 1.15;
            height: 20px;
            padding: .2em .6em .3em;
            color: #fff;
            text-align: center;
            white-space: nowrap;
            vertical-align: baseline;
        }
        #duankai{background-color:  #abbac3!important;}
        #shiyongzhong{background-color: lightsalmon!important;}
        #qiguai{border:0!important;}
    </style>
    <title></title>
</head>

<body>
<div class="margin clearfix">
    <div class="Account_style">
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
            <span class="xinxi" style="width:150px">该房间下电器状态</span>
        </div>
        <div class="recording_style">
            <div id="recording">
                <div class="hd" style="border-bottom:solid 0px;">
                    <ul>
                        <li style="border:solid 1px #ddd;">私有电器</li>
                        <li  id="qiguai" style="padding-left:5px"><a onclick="shishi()" href="javascript:ovid()" class="btn btn-warning" style="font-size:15px">+</a></li>
                    </ul>
                </div>
                <div class="bd">
                    <ul class="">
                        <table class="table table-striped table-bordered table-hover" id="sample-table">
                            <thead>
                            <tr>
                                <th width="">电器编号</th>
                                <th width="">电器描述</th>
                                <th width="">电器状态</th>
                                <th width="">实时用电量</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${!empty apparatus1 }">
                                <c:forEach items="${apparatus1}" var="apparatus1">
                                    <tr>
                                        <td>${apparatus1.id}</td>
                                        <td>${apparatus1.beizhu}</td>
                                        <%--<c:if test="${apparatus1.useable=='0'}">--%>
                                           <%----%>
                                        <%--</c:if>--%>
                                        <c:choose>
                                            <c:when test="${apparatus1.useable=='0'}">
                                                <td><span class="zhuangtai" id="kongxian">空闲中</span></td>
                                            </c:when>
                                            <c:when test="${apparatus1.useable=='1'}">
                                                <td><span class="zhuangtai" id="duankai">断开中</span></td>
                                            </c:when>
                                            <c:otherwise>
                                                <td><span class="zhuangtai" id="shiyongzhong">使用中</span></td>
                                            </c:otherwise>
                                        </c:choose>
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
                        <li style="padding-left:5px"><a  onclick="shishi()"  class="btn btn-warning" style="font-size:15px">+</a></li>
                    </ul>
                </div>
                <div class="bd">
                    <ul class="">
                        <table class="table table-striped table-bordered table-hover" id="sconsumption-table">
                            <thead>
                            <tr>
                                <th width="">电器编号</th>
                                <th width="">电器描述</th>
                                <th width="">电器状态</th>
                                <th width="">实时用电量</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${!empty apparatus0 }">
                                <c:forEach items="${apparatus0}" var="apparatus0">
                                    <tr>
                                        <td>${apparatus0.id}</td>
                                        <td>${apparatus0.beizhu}</td>
                                        <c:choose>
                                            <c:when test="${apparatus0.useable=='0'}">
                                                <td><span class="zhuangtai" id="kongxian">空闲中</span></td>
                                            </c:when>
                                            <c:when test="${apparatus0.useable=='1'}">
                                                <td><span class="zhuangtai" id="duankai">断开中</span></td>
                                            </c:when>
                                            <c:otherwise>
                                                <td><span class="zhuangtai" id="shiyongzhong">使用中</span></td>
                                            </c:otherwise>
                                        </c:choose>
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

<!--添加设备图层-->
<div class="add_menber" id="add_menber_style" style="display:none">

    <ul class=" page-content">
        <li><label class="label_name">插空&nbsp;&nbsp;&nbsp;&nbsp;ID：</label><span class="add_name"><input value="" name="插空ID" type="text"  class="text_add"/></span><div class="prompt r_f"></div></li>
        <!-- <li><label class="label_name">真实姓名：</label><span class="add_name"><input name="真实姓名" type="text"  class="text_add"/></span><div class="prompt r_f"></div></li> -->
        <li><label class="label_name">插&nbsp;&nbsp;空&nbsp;&nbsp;号：</label><span class="add_name"><input name="插空号" type="text"  class="text_add"/></span><div class="prompt r_f"></div></li>
        <li><label class="label_name">电器编号：</label><span class="add_name"><input name="电器编号" type="text"  class="text_add"/></span><div class="prompt r_f"></div></li>
        <li><label class="label_name">电器描述：</label><span class="add_name"><input name="电器描述" type="text"  class="text_add"/></span><div class="prompt r_f"></div></li>

        <!-- 改改改 -->


    </ul>
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
                {"orderable":false,"aTargets":[1,2,3]}// 制定列不参与排序
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
                {"orderable":false,"aTargets":[1,2,3]}// 制定列不参与排序
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
    function shishi(){
        // alert(1);
        layer.open({
            type: 1,
            title: '添加电器',
            maxmin: true,
            shadeClose: true, //点击遮罩关闭层
            area : ['800px' , ''],
            content:$('#add_menber_style'),
            btn:['提交','取消'],
            yes:function(index,layero){
                var num=0;
                var str="";
                $(".add_menber input[type$='text']").each(function(n){
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
                    });
                    layer.close(index);
                }
            }
        });
    }
</script>
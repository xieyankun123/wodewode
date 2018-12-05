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
        .xiala{
            border: 1px solid #d5d5d5;
            padding: 5px 4px;
            margin-left: 10px;
            line-height: 1.2;
            font-size: 14px;
            overflow: hidden;
        }
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
                        <li  id="qiguai" style="padding-left:5px"><a onclick="shishi('${room.room_id}')" href="javascript:ovid()" class="btn btn-warning" style="font-size:15px">+</a></li>
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
                        <li style="padding-left:5px"><a  onclick="shishi('${room.apartment_id}_0')"  class="btn btn-warning" style="font-size:15px">+</a></li>
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
        <li>
            <label class="label_name">dev&nbsp;&nbsp;&nbsp;ID&nbsp;&nbsp;：</label>
            <%--<span class="add_name"><input value="" name="插空ID" data-shu='chakongid' type="text"  class="text_add"/></span>--%>
            <%--<div class="prompt r_f"></div>--%>

            <select name="myselect" id="myselect" class="xiala">
                <option style='display: none'></option>
            </select>
        </li>
        <!-- <li><label class="label_name">真实姓名：</label><span class="add_name"><input name="真实姓名" type="text"  class="text_add"/></span><div class="prompt r_f"></div></li> -->
        <li><label class="label_name">插空&nbsp;&nbsp;&nbsp;&nbsp;ID：</label><span class="add_name"><input name="devid" data-shu='chakongid' type="text"  class="text_add"/></span><div class="prompt r_f"></div></li>
        <li><label class="label_name">apparatus_id：</label><span class="add_name"><input name="apparatus_id" data-shu='apparatus_id' type="text"  class="text_add"/></span><div class="prompt r_f"></div></li>
        <li><label class="label_name">电器描述：</label><span class="add_name">
            <input name="电器描述" type="text" data-shu='miaosu' class="text_add"/></span><div class="prompt r_f"></div></li>
        <li><label class="label_name">房&nbsp;&nbsp;间&nbsp;&nbsp;号：</label><span class="add_name">
            <input name="房间号" type="text" readonly data-shu='fangjianhao' class="text_add"/></span><div class="prompt r_f"></div></li>
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
    function kan(a){
        var aa=a
        layer.open({
            type: 2,
            title: '查看实时电量',
            skin: 'layui-layer-rim', //加上边框
            area: ['600px', '480px'], //宽高
            content:"apparatus/tp?apparatus_id="+aa+""
        });
    }
    function shishi(fhao){
        $("#myselect").html("<option style='display: none'></option>");
        $("#add_menber_style input[data-shu='fangjianhao']").val(fhao);
        $.ajax({	//使用JQuery内置的Ajax方法
            type : "POST",		//post请求方式
            async : true,		//异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
            url :'<%=basePath%>anu/dev',
            dataType : 'json',		//返回数据形式为json
            success : function(data) {
                //请求成功时执行该函数内容，获取服务器返回的json对象
                if (data.newAdd != null && data.newAdd.length > 0) {
                    console.info(data.newAdd);         //控制台输出

                    for(var i=0;i<data.newAdd.length;i++){

                        $("#myselect").append("<option>"+data.newAdd[i].devID+"</option>")
                    }

                    $("#myselect").change(function(){
                        // 	var opt=$("#myselect").html();
                        // alert(opt);
                        var options=$("#myselect option:selected"); //获取选中的项
                        var dangqiandevid=options.text() //拿到选中项的文本
                        for(var i=0;i<data.newAdd.length;i++){
                            if(data.newAdd[i].devID == dangqiandevid)
                            {
                                $("#add_menber_style input[data-shu='apparatus_id']").val(data.newAdd[i].apparatus_id);
                            }
                        }
                    });
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

                                    // 设置添加后刷新
                                    <%--yes: function(index){--%>
                                    <%--window.location="<%=basePath%>apparatus/yqinfoR?room_id=${room.room_id}";--%>
                                    <%--layer.close(index);--%>
                                    <%--}--%>
                                });
                                layer.close(index);
                                addchakong();
                            }
                        }
                    });

                }
                else {
                    alert("没有查询到有新插空！");
                }
            },
            error : function(errorMsg) {
                alert("请求服务器数据失败，请联系管理员");
            }
        })


    }

    function addchakong() {
            var devid=$("#myselect option:selected").text() //拿到选中项的文本
            var chakongid=$("#add_menber_style input[data-shu='chakongid']").val();
            var apparatus_id=$("#add_menber_style input[data-shu='apparatus_id']").val();
            var beizu=$("#add_menber_style input[data-shu='miaosu']").val();
            var fangjianhao= $("#add_menber_style input[data-shu='fangjianhao']").val();
            var sessionID2="ce4904e06ee1cb2b63d66dd695be94d0feebcfb02018084e93a8172b90cd9ca1c492ab2c6ae9324c2ce45e";
            var zhuangtai="0";
            // alert("获取成功");
            //  alert(devid);
            // alert(chakongid);
            // alert(apparatus_id);
            // alert(beizu);
            // alert(fangjianhao);
            $.ajax({
                type: "POST",
                url: 'anu/adm',
                data: {id:chakongid,sessionID:sessionID2,devID:devid,
                    apparatus_id:apparatus_id,beizhu:beizu,useable:zhuangtai,room_id:fangjianhao},
                dataType:'json',
                cache: false,
                success: function(data){
                    console.log("success");
                }
            });

    }
</script>
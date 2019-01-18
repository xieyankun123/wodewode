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
        <link href="static/assets/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="static/css/style.css"/>
        <link href="static/assets/css/codemirror.css" rel="stylesheet">
        <link rel="stylesheet" href="static/assets/css/ace.min.css" />
        <link rel="stylesheet" href="static/assets/css/font-awesome.min.css" />
      <script src="static/assets/js/jquery.min.js"></script>
    <script src="static/myjs/apajs.js"></script>
    <script type="text/javascript">
      window.jQuery || document.write("<script src='static/assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
    </script>
    <script type="text/javascript">
      if("ontouchend" in document) document.write("<script src='static/assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
    </script>
    <script src="static/assets/js/bootstrap.min.js"></script>
    <script src="static/assets/js/typeahead-bs2.min.js"></script>
    <!-- page specific plugin scripts -->
    <script src="static/assets/js/jquery.dataTables.min.js"></script>
    <script src="static/assets/js/jquery.dataTables.bootstrap.js"></script>
        <script type="text/javascript" src="static/js/H-ui.js"></script>
        <script type="text/javascript" src="static/js/H-ui.admin.js"></script>
        <script src="static/assets/layer/layer.js" type="text/javascript" ></script>
        <script src="static/assets/laydate/laydate.js" type="text/javascript"></script>
    <style type="text/css">

        #kongxian{background-color:#abbac3!important;}
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
    </style>
<title>公寓列表</title>
</head>

<body>
<div class="page-content clearfix">

    <div id="Member_Ratings">
      <div class="d_Confirm_Order_style">
          <%--1搜索--%>
        <div class="search_style">
     
        <ul class="search_content clearfix">
             <li><label class="l_f"></label><input name="" type="text"  class="text_add" id="sousuo" placeholder="输入公寓地址"  style=" width:250px"/></li>
             <li style="width:90px;"><button type="button" class="btn_search" id="ss"><i class="icon-search"></i>查询</button></li>
        </ul>
        </div>
       <%--2搜索--%>

     <div class="table_menu_list">
       <table class="table table-striped table-bordered table-hover" id="sample-table">
        <thead>
         <tr>
            <th width="80">公寓编号</th>
            <th width="180">房源地址</th>
             <th width="80">房东</th>
            <th width="70">状态</th>
             <th width="70">公司</th>
            <th width="100">操作</th>
         </tr>
         </thead>
        <tbody>
<c:if test="${!empty apalist }">
    <c:forEach items="${apalist}" var="apa">
            <tr>
                  <td>${apa.apartment_id}</td>
                  <td>${apa.location}</td>
                    <td>${apa.owner}</td>
                    <c:choose>
                    <c:when test="${apa.useable=='0'}">
                    <td><span class="zhuangtai" id="kongxian">已停用</span></td>
                    </c:when>
                    <c:when test="${apa.useable=='1'}">
                    <td class="td-status"><span class="label label-success radius">已启用</span></td>
                    </c:when>
                    </c:choose>
                    <td >${apa.factory}</td>
                  <td class="td-manage">
                  <a title="编辑" onclick="apa_edit(this,'${apa.useable}','${apa.id}')"  href="javascript:;"  class="btn btn-xs btn-info" ><i class="icon-edit bigger-120"></i></a>
                  </td>
            </tr>
    </c:forEach>
</c:if>
        </tbody>
    </table>
   </div>

 <%--1添加公寓--%>
     <div class="border clearfix" style="border:0px">
       <span class="l_f">
        <a href="javascript:ovid()" id="member_add" class="btn btn-warning"><i class="icon-plus"></i>添加房源</a>
       </span>
     </div>
 <%--2添加公寓--%>
  </div>
 </div>


    <%--1添加公寓图层--%>
    <div class="add_menber" id="add_menber_style" style="display:none">
        <ul class=" page-content">

            <li><label class="label_name">公寓编号：</label><span class="add_name">
                <input value="" name="公寓编号" type="text" data-shu='bianhao' class="text_add"/></span><div class="prompt r_f"></div>
            </li>
            <li><label class="label_name">公寓地址：</label><span class="add_name">
                <input value="" name="公寓地址" type="text" data-shu='dizhi' class="text_add"/></span><div class="prompt r_f"></div>
            </li>
            <li><label class="label_name">房东：</label><span class="add_name">
                <input value="" name="房东" type="text" data-shu='fangdong' class="text_add"/></span><div class="prompt r_f"></div>
            </li>
            <li><label class="label_name">状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态：</label><span class="add_name">
                <label><input name="form-field-radio1" type="radio" checked="checked" class="ace" value="1"><span class="lbl">开启</span></label>&nbsp;&nbsp;&nbsp;
                <label><input name="form-field-radio1" type="radio" class="ace" value="0"><span class="lbl">关闭</span></label></span><div class="prompt r_f"></div>
            </li>
        </ul>
    </div>
    <%--2添加公寓图层--%>

    <!--编辑房源图层-->
    <div class="add_menber" id="add_menber_style2" style="display:none">
        <ul class=" page-content">

            <li><label class="label_name">公寓编号：</label><span class="add_name">
                <input value="" name="公寓编号" type="text" data-shu='bianhao2' class="text_add"/></span><div class="prompt r_f"></div>
            </li>
            <li><label class="label_name">公寓地址：</label><span class="add_name">
                <input value="" name="公寓地址" type="text" data-shu='dizhi2' class="text_add"/></span><div class="prompt r_f"></div>
            </li>
            <li><label class="label_name">房东：</label><span class="add_name">
                <input value="" name="房东" type="text" data-shu='fangdong2' class="text_add"/></span><div class="prompt r_f"></div>
            </li>
            <li><label class="label_name">状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态：</label><span class="add_name">
                <label><input name="form-field-radio2" type="radio" checked="checked" class="ace" value="1"><span class="lbl">开启</span></label>&nbsp;&nbsp;&nbsp;
                <label><input name="form-field-radio2" type="radio" class="ace" value="0"><span class="lbl">关闭</span></label></span><div class="prompt r_f"></div>
            </li>
        </ul>
    </div>
    <%--编辑公寓图层--%>
</div>



</body>
</html>
<script>
    //------编辑公寓
    function apa_edit(obj,zhuangtai,id){
        var zhuangtai1=zhuangtai;
        var bianhao=$(obj).parent().parent().find("td").eq(0).html();
        var dizhi=$(obj).parent().parent().find("td").eq(1).html();
        var fangdong=$(obj).parent().parent().find("td").eq(2).html();
        var gongsi=$(obj).parent().parent().find("td").eq(4).html();
        $("#add_menber_style2 input[data-shu='bianhao2']").val(bianhao);
        $("#add_menber_style2 input[data-shu='dizhi2']").val(dizhi);
        $("#add_menber_style2 input[data-shu='fangdong2']").val(fangdong);
        // $("#add_menber_style2 input[data-shu='gongsi2']").val(gongsi);
        if(zhuangtai1=="1"){
            // alert("状态为1启用");
            $("input[name='form-field-radio2']:eq(0)").attr("checked",'checked');
        }else if(zhuangtai1==0)
        {$("input[name='form-field-radio2']:eq(1)").attr("checked",'checked');}
        layer.open({
            type: 1,
            title: '修改房源信息',
            maxmin: true,
            shadeClose:false, //点击遮罩关闭层
            area : ['800px' , ''],
            content:$('#add_menber_style2'),
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
                            window.location="<%=basePath%>/apartment/apa_list";
                            console.log("跳转");
                            layer.close(index);
                        }
                    });
                    layer.close(index);
                    upapa(gongsi,id);
                }
            }
        });
    }


    function upapa(factory,id){
        var bianhao2= $("#add_menber_style2 input[data-shu='bianhao2']").val();
        var dizhi2=$("#add_menber_style2 input[data-shu='dizhi2']").val();
        var fangdong2=$("#add_menber_style2 input[data-shu='fangdong2']").val();
        var zhuangtai2=$("#add_menber_style2 input[name='form-field-radio2']:checked").val();
        // alert(bianhao2);
        // alert(dizhi2);
        // alert(fangdong2);
        // alert(zhuangtai2);
        console.log("提取获取了更新的数据");

        $.ajax({
            type: "POST",
            url: 'apartment/update',
            data: {apartment_id:bianhao2,location:dizhi2,owner:fangdong2,useable:zhuangtai2,factory:factory,id:id},
            dataType:'json',
            cache: false,
            success: function(data){
                console.log("success");
            }
        });

    }
    // 编辑公寓------

</script>
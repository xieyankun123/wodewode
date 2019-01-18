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
             <li><label class="l_f"></label><input name="" type="text"  class="text_add" id="sousuo" placeholder="输入公司名"  style=" width:250px"/></li>
             <li style="width:90px;"><button type="button" class="btn_search" id="ss"><i class="icon-search"></i>查询</button></li>
        </ul>
        </div>
       <%--2搜索--%>

     <div class="table_menu_list">
       <table class="table table-striped table-bordered table-hover" id="sample-table">
        <thead>
         <tr>
            <th width="50px">序号</th>
             <th width="70">公司名</th>
            <%--<th width="100">操作</th>--%>
         </tr>
         </thead>
        <tbody>
<c:if test="${!empty comlist }">
    <c:forEach items="${comlist}" var="com">
            <tr>
                  <td>${com.id}</td>
                  <td>${com.facotry}</td>

                  <%--<td class="td-manage">--%>
                  <%--<a title="编辑" onclick="apa_edit(this,'${apa.useable}')"  href="javascript:;"  class="btn btn-xs btn-info" ><i class="icon-edit bigger-120"></i></a>--%>
                  <%--</td>--%>
            </tr>
    </c:forEach>
</c:if>
        </tbody>
    </table>
   </div>

 <%--1添加公寓--%>
     <div class="border clearfix" style="border:0px">
       <span class="l_f">
        <a href="javascript:ovid()" id="member_add" class="btn btn-warning"><i class="icon-plus"></i>添加公司</a>
       </span>
     </div>
 <%--2添加公寓--%>
  </div>
 </div>


    <%--1添加公司图层--%>
    <div class="add_menber" id="add_menber_style" style="display:none">
        <ul class=" page-content">

            <li><label class="label_name">公司名称：</label><span class="add_name">
                <input value="" name="公司名称" type="text" data-shu='gongsi' class="text_add"/></span><div class="prompt r_f"></div>
            </li>

        </ul>
    </div>
    <%--2添加公寓图层--%>


</div>



</body>
</html>
<script>
    jQuery(function($) {

        // ----------搜索函数
        function sousuo(){
            $('#sample-table tbody tr').hide();
            $('#sample-table tbody tr').filter(":contains('" + ($('#sousuo').val()) + "')")
                .show();
            // window.location="/we/apa_list";
        };
        $('#ss').click(function(){
            sousuo();

        });
        $('#sousuo').keydown(function(event){
            if(event.keyCode==13){
                sousuo();
            }
        });
// 搜索函数----------

//添加公寓-----
        $('#member_add').on('click', function(){
            layer.open({
                type: 1,
                title: '添加公司',
                maxmin: true,
                shadeClose: true, //点击遮罩关闭层
                area : ['800px' , ''],
                content:$('#add_menber_style'),
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
                                // window.location="/factory/add";
                                console.log(1);
                                layer.close(index);
                            }
                        });
                        layer.close(index);
                        addcom();
                    }
                }
            });
        });

        // 添加公寓函数
        function addcom(){
            var gongsi= $("#add_menber_style input[data-shu='gongsi']").val();

            $.ajax({
                type: "POST",
                url: 'factory/add',
                data: {facotry:gongsi},
                dataType:'json',
                cache: false,
                success: function(data){
                    console.log("success");
                }
            });

        }

//添加公司-----------





    })

</script>
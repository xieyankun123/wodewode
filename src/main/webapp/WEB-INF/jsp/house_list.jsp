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
<title>房源列表</title>
</head>

<body>
<div class="page-content clearfix">
    <div id="Member_Ratings">
      <div class="d_Confirm_Order_style">
    <div class="search_style">
     
      <ul class="search_content clearfix">
       <li><label class="l_f"></label><input name="" type="text"  class="text_add" id="sousuo" placeholder="输入房源地址"  style=" width:250px"/></li>
       
       <li style="width:90px;"><button type="button" class="btn_search" id="ss"><i class="icon-search"></i>查询</button></li>
      </ul>
    </div>

     <div class="table_menu_list">
       <table class="table table-striped table-bordered table-hover" id="sample-table">
    <thead>
     <tr>
        <th width="25"><label><input type="checkbox" class="ace"><span class="lbl"></span></label></th>
        <th width="80">房屋编号</th>
        <th width="180">房源地址</th>
        <th width="80">房源结构</th>
         <th width="80">房东</th>
        <th width="80">现租客</th>
        <th width="100">租用记录</th>
        <th width="100">电器使用状态</th>
        <th width="70">状态</th>                
        <th width="100">操作</th>
      </tr>
    </thead>
  <tbody>
<c:if test="${!empty house }">
    <c:forEach items="${house}" var="house">
    <tr>
          <td><label><input type="checkbox" class="ace"><span class="lbl"></span></label></td>
          <td>${house.room_id}</td>
          <td>${house.room_loc}</td>
          <!-- <td>男</td> -->
          <!-- <td>13000000000</td> -->
          <!-- <td>admin@mail.com</td> -->

          <td class="text-l">${house.room_str}</td>
          <td>${house.own}</td>
           <td>${house.xianzuke}</td>
          <!-- <td>2014-6-11 11:11:42</td> -->
          <td><a href="<%=basePath%>u_r/historyR?room_id=${house.room_id}" title="点击查看" ><img style="width:25px" src="static/images/zufangjilv.png"></a></td>
             <td><a href="<%=basePath%>apparatus/yqinfoR?room_id=${house.room_id}" title="点击查看"><img style="width:25px" src="static/images/elestate.png"></a></a></td>

        <c:choose>
            <c:when test="${house.useable=='0'}">
                <td><span class="zhuangtai" id="kongxian">已停用</span></td>
            </c:when>
            <c:when test="${house.useable=='1'}">
                <td class="td-status"><span class="label label-success radius">已启用</span></td>
            </c:when>
        </c:choose>
          <td class="td-manage">
          <a title="编辑" onclick="member_edit(this,'${house.apartment_id}','${house.useable}')"  href="javascript:;"  class="btn btn-xs btn-info" ><i class="icon-edit bigger-120"></i></a>
          </td>
    </tr>
    </c:forEach>
</c:if>
      </tbody>
  </table>
   </div>

        <!---->
     <div class="border clearfix" style="border:0px">
       <span class="l_f">
        <a href="javascript:ovid()" id="member_add" class="btn btn-warning"><i class="icon-plus"></i>添加房源</a>
       </span>
     </div>
     <!---->
  </div>
 </div>
</div>
<!--添加房源图层-->
<div class="add_menber" id="add_menber_style" style="display:none">
    <ul class=" page-content">
    <li><label class="label_name">房源编号：</label><span class="add_name">
        <input value="" name="房源编号" type="text" data-shu='fangyuanbianhao' class="text_add"/></span><div class="prompt r_f"></div></li>
    <li><label class="label_name">公寓编号：</label><span class="add_name">
        <input value="" name="公寓编号" type="text" data-shu='fangdong' class="text_add"/></span><div class="prompt r_f"></div></li>
     <li><label class="label_name">房源地址：</label><span class="add_name">
        <input value="" name="房源地址" type="text" data-shu='fangyuandizhi' class="text_add"/></span><div class="prompt r_f"></div></li>
     <li><label class="label_name">房源结构：</label><span class="add_name">
         <input value="" name="房源结构" type="text" data-shu='fangyuanjiegou' class="text_add"/></span><div class="prompt r_f"></div></li>
     <%--<li><label class="label_name">现&nbsp;租&nbsp;客：</label><span class="add_name">--%>
         <%--<input name="现租客" type="text" data-shu='xianzuke' class="text_add"/></span><div class="prompt r_f"></div></li>--%>
     <li><label class="label_name">状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态：</label><span class="add_name">
     <label><input name="form-field-radio1" type="radio" checked="checked" class="ace" value="1"><span class="lbl">开启</span></label>&nbsp;&nbsp;&nbsp;
     <label><input name="form-field-radio1"type="radio" class="ace" value="0"><span class="lbl">关闭</span></label></span><div class="prompt r_f"></div></li>
    </ul>
 </div>

<!--编辑房源图层-->
<div class="add_menber" id="add_menber_style2" style="display:none" >

    <ul class=" page-content">
        <li><label class="label_name">房源编号：</label><span class="add_name"><input value="" name="房源编号" type="text" data-shu='bianhao' class="text_add"/></span><div class="prompt r_f"></div></li>
        <%--<li><label class="label_name">房东：</label><span class="add_name"><input value="" name="房东" type="text" data-shu='fangdong' class="text_add"/></span><div class="prompt r_f"></div></li>--%>
        <li><label class="label_name">公寓编号：</label><span class="add_name">
        <input value="" name="公寓编号" type="text" data-shu='fangdong' class="text_add"/></span><div class="prompt r_f"></div></li>
        <li><label class="label_name">房源地址：</label><span class="add_name">
        <input value="" name="公寓编号" type="text" data-shu='dizhi' class="text_add"/></span><div class="prompt r_f"></div></li>
        <li><label class="label_name">房源结构：</label><span class="add_name"><input value="" name="房源结构" type="text" data-shu='jiegou' class="text_add"/></span><div class="prompt r_f"></div></li>
        <%--<li><label class="label_name">现租客：</label><span class="add_name"><input name="现租客" type="text" data-shu='xianzuke' class="text_add"/></span><div class="prompt r_f"></div></li>--%>
        <li><label class="label_name">状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态：</label><span class="add_name">
     <label><input name="form-field-radio6" type="radio" checked="checked" class="ace" value="1"><span class="lbl">开启</span></label>&nbsp;&nbsp;&nbsp;
     <label><input name="form-field-radio6"type="radio" class="ace" value="0"><span class="lbl">关闭</span></label></span><div class="prompt r_f"></div></li>
    </ul>
</div>
</body>
</html>
<script>
jQuery(function($) {
          var oTable1 = $('#sample-table').dataTable({
        "aaSorting": [[ 1, "asc" ]],//默认第几个排序
      //   "bStateSave": true,//状态保存
        "paging":   true,  //分页功能
        "filter":false,   //搜索功能
        // "columnDefs":[{"targets":[0], "searchable":false}],
    // "dom": '<"top"i>rt<"bottom"flp><"clear">',
        "aoColumnDefs": [
      //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
        {"orderable":false,"aTargets":[0,2,3,4,5,6,7,8,9]}// 制定列不参与排序
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
      
      
        $('[data-rel="tooltip"]').tooltip({placement: tooltip_placement});
        function tooltip_placement(context, source) {
          var $source = $(source);
          var $parent = $source.closest('table')
          var off1 = $parent.offset();
          var w1 = $parent.width();
      
          var off2 = $source.offset();
          var w2 = $source.width();
      
          if( parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2) ) return 'right';
          return 'left';
        }
      })
/*用户-添加*/
 $('#member_add').on('click', function(){
    layer.open({
        type: 1,
        title: '添加房源',
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
                window.location="<%=basePath%>/room/house_list";
                console.log(1);
                layer.close(index);
            }
        });
         layer.close(index);
          addroom();
      }                     
    }
    });
});
/*添加房间*/

function addroom(){
    // alert(1);
    var fangyuanbianhao= $("#add_menber_style input[data-shu='fangyuanbianhao']").val();
    // var gongyuhao=$("#add_menber_style input[data-shu='gongyuhao').val();
    var gongyuhao=$("#add_menber_style input[data-shu='fangdong']").val();
    var fangyuanjiegou=$("#add_menber_style input[data-shu='fangyuanjiegou']").val();
    // var xianzuke= $("#add_menber_style input[data-shu='xianzuke']").val();
    var dizhi=$("#add_menber_style input[data-shu='fangyuandizhi']").val();
    var zhuangtai=$("#add_menber_style input[name='form-field-radio1']:checked").val();
    alert("获取成功");
    // alert(fangyuanbianhao)
    // alert(gongyuhao)
    // alert(dizhi);
    // alert(fangyuanjiegou);
    // alert(zhuangtai);
    $.ajax({
        type: "POST",
        url: 'room/add',
        data: {room_id:fangyuanbianhao,useable:zhuangtai,apartment_id:gongyuhao,room_loc:dizhi,room_str:fangyuanjiegou},
        dataType:'json',
        cache: false,
        success: function(data){
            console.log("success");
        }
    });

}
/*用户-停用*/
function member_stop(obj,id){
  layer.confirm('确认要停用吗？',function(index){
    $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" class="btn btn-xs " onClick="member_start(this,id)" href="javascript:;" title="启用"><i class="icon-ok bigger-120"></i></a>');
    $(obj).parents("tr").find(".td-status").html('<span class="label label-defaunt radius">已停用</span>');
    $(obj).remove();
    layer.msg('已停用!',{icon: 5,time:1000});
  });
}

/*用户-启用*/
function member_start(obj,id){
  layer.confirm('确认要启用吗？',function(index){
    $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" class="btn btn-xs btn-success" onClick="member_stop(this,id)" href="javascript:;" title="停用"><i class="icon-ok bigger-120"></i></a>');
    $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已启用</span>');
    $(obj).remove();
    layer.msg('已启用!',{icon: 6,time:1000});
  });
}


// 编辑
function member_edit(obj,apa_id,zhuangtai){
    // alert(1);
        var apa_id1=apa_id;
        // alert(apa_id1)
    var zhuangtai1=zhuangtai;
    var bianhao=$(obj).parent().parent().find("td").eq(1).html();
    var dizhi=$(obj).parent().parent().find("td").eq(2).html();
    var jiegou=$(obj).parent().parent().find("td").eq(3).html();
    // var fangdong=$(obj).parent().parent().find("td").eq(4).html();
    // var xianzuke=$(obj).parent().parent().find("td").eq(5).html();
    $("#add_menber_style2 input[data-shu='bianhao']").val(bianhao);
    $("#add_menber_style2 input[data-shu='dizhi']").val(dizhi);
    $("#add_menber_style2 input[data-shu='jiegou']").val(jiegou);
    $("#add_menber_style2 input[data-shu='fangdong']").val(apa_id1);
    // $("#add_menber_style2 input[data-shu='xianzuke']").val(xianzuke);
    if(zhuangtai1=="1"){
        // alert("状态为1启用");
        $("input[name='form-field-radio6']:eq(0)").attr("checked",'checked');
    }else if(zhuangtai1==0)
    {$("input[name='form-field-radio6']:eq(1)").attr("checked",'checked');}
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
                        window.location="<%=basePath%>/room/house_list";
                        console.log(1);
                        layer.close(index);
                    }
                });
                layer.close(index);
                uproom();
            }
        }
    });
}

function uproom(){
    var fangyuanbianhao= $("#add_menber_style2 input[data-shu='bianhao']").val();
    var gongyuhao=$("#add_menber_style2 input[data-shu='fangdong']").val();
    var fangyuanjiegou=$("#add_menber_style2 input[data-shu='jiegou']").val();
    var dizhi=$("#add_menber_style2 input[data-shu='dizhi']").val();
    var zhuangtai=$("#add_menber_style2 input[name='form-field-radio6']:checked").val();


    // var zhuangtai2=$("#add_menber_style2 input[name='form-field-radio4']:checked").val();
    // var youxiang2=$("#add_menber_style2 input[data-shu='youxiang']").val();
    console.log("提取获取了更新的数据");
    // alert("获取成功");
    // alert(gongyuhao);
    // alert(fangyuanbianhao);
    // alert(fangyuanjiegou);
    // alert(dizhi);
    // // alert(shengfenzheng2);alert(dizhi2);
    // alert(zhuangtai);
    // alert(youxiang2);
    $.ajax({
        type: "POST",
        url: 'room/update',
        data: {room_id:fangyuanbianhao,useable:zhuangtai,apartment_id:gongyuhao,room_loc:dizhi,room_str:fangyuanjiegou},
        dataType:'json',
        cache: false,
        success: function(data){
            console.log("success");
        }
    });

}
/*用户-删除*/
function member_del(obj,id){
  layer.confirm('确认要删除吗？',function(index){
    $(obj).parents("tr").remove();
    layer.msg('已删除!',{icon:1,time:1000});
  });
}
function sousuo(){
 $('#sample-table tbody tr').hide();
   $('#sample-table tbody tr').filter(":contains('" + ($('#sousuo').val()) + "')")
             .show();
};
$('#ss').click(function(){
  sousuo();
  // alert(1);
});
$('#sousuo').keydown(function(event){ 
            if(event.keyCode==13){ 
                sousuo();
            }
        });

laydate({
    elem: '#start',
    event: 'focus' 
});
function house_history(id){
    window.location.href ="house_history.html?="+id;
};

function applicance_state(id){
    window.location.href ="applicance_state.html?="+id;
};
</script>
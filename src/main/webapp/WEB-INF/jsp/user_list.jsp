<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8"%><!--增加一行page指令即可-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html >
<head>
    <base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
			<script src="static/assets/js/jquery.min.js"></script>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<![endif]-->

		<!--[if !IE]> -->

		<script type="text/javascript">
			window.jQuery || document.write("<script src='static/assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
		</script>

		<!-- <![endif]-->

		<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='static/assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
</script>
<![endif]-->

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
<title>用户列表</title>
</head>

<body>
<div class="page-content clearfix">
    <div id="Member_Ratings">
      <div class="d_Confirm_Order_style">
    <div class="search_style">
     
      <ul class="search_content clearfix">
       <li><label class="l_f"></label><input name="" type="text"  id="sousuo" class="text_add"  placeholder="输入租户名称、手机"  style=" width:200px"/></li>
       <!-- <li><label class="l_f">添加时间</label><input class="inline laydate-icon" id="start" style=" margin-left:10px;"></li> -->
       <li style="width:90px;"><button type="button" class="btn_search" id="ss"><i class="icon-search"></i>查询</button></li>
      </ul>
    </div>
     <!---->

     <!---->
     <div class="table_menu_list">
       <table class="table table-striped table-bordered table-hover" id="sample-table">
		<thead>
		 <tr>

				<th width="80">序号</th>
				<th width="100">姓名</th>
				<th width="80">性别</th>
				<th width="120">手机</th>
        <th width="150">身份证号</th>
				<!-- <th width="150">邮箱</th> -->
				<th width="200">地址</th>
				<!-- <th width="180">加入时间</th> -->
        <th width="100">租房情况</th>
				<th width="70">状态</th>                
				<th width="100">操作</th>
			</tr>
		</thead>
	<tbody>
    <c:if test="${!empty userList }">
        <c:forEach items="${userList}" var="user" varStatus="status">
		<tr>
          <td>${status.index+1}</td>
          <td>${user.user_name}</td>
          <td>${user.user_sex}</td>
          <td>${user.user_telephone}</td>
          <td>${user.user_IDcard}</td>
          <!-- <td>admin@mail.com</td> -->
          <td class="text-l">${user.user_address }</td>
          <td><a href="<%=basePath%>u_r/historyU?user_telephone=${user.user_telephone}" title="点击查看租房情况" ><img style="width:25px" src="static/images/history.png"></a></td>
            <c:choose>
                <c:when test="${user.user_state=='0'}">
                    <td><span class="zhuangtai" id="kongxian">已停用</span></td>
                </c:when>
                <c:when test="${user.user_state=='1'}">
                    <td class="td-status"><span class="label label-success radius">已启用</span></td>
                </c:when>
            </c:choose>
          <td class="td-manage">
          <!-- <a onClick="member_stop(this,'10001')"  href="javascript:;" title="停用"  class="btn btn-xs btn-success"><i class="icon-ok bigger-120"></i></a>  -->
          <a title="编辑" onclick="member_edit(this,'${user.user_hobby}','${user.user_email}','${user.user_state}')" href="javascript:;"  class="btn btn-xs btn-info" ><i class="icon-edit bigger-120"></i></a>
         <!--  <a title="删除" href="javascript:;"  onclick="member_del(this,'1')" class="btn btn-xs btn-warning" ><i class="icon-trash  bigger-120"></i></a> -->
          </td>
		</tr>
        </c:forEach>
    </c:if>
      </tbody>
	</table>
   </div>
     <div class="border clearfix" style="border:0px">
       <span class="l_f">
        <a href="javascript:ovid()" id="member_add" class="btn btn-warning"><i class="icon-plus"></i>添加租户</a>
       </span>
     </div>

  </div>
 </div>
</div>
<!--添加用户图层-->

<!--修改用户图层-->
<!--添加用户图层-->
<div class="add_menber" id="add_menber_style" style="display:none">

    <ul class=" page-content">
        <li><label class="label_name">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</label><span class="add_name"><input value="" name="姓名" type="text" data-shu="xingming" class="text_add"/></span><div class="prompt r_f"></div></li>
        <li><label class="label_name">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</label><span class="add_name">
     <label><input name="form-field-radio0" type="radio" checked="checked" class="ace" value="男"><span class="lbl">男</span></label>&nbsp;&nbsp;&nbsp;
     <label><input name="form-field-radio0" type="radio" class="ace" value="女"><span class="lbl">女</span></label>&nbsp;&nbsp;&nbsp;

     </span>
            <div class="prompt r_f"></div>
        </li>
        <li><label class="label_name">手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机：</label><span class="add_name"><input name="手机" type="text" data-shu='phone' class="text_add"/></span><div class="prompt r_f"></div></li>
        <li><label class="label_name">爱&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;好：</label><span class="add_name"><input name="爱好" type="text" data-shu='aihao' class="text_add"/></span><div class="prompt r_f"></div></li>
        <li>
            <label class="label_name">身份证号：</label>
            <span class="add_name"><input name="身份证号" type="text" data-shu="shengfenzheng" class="text_add"/></span>
            <div class="prompt r_f"></div>
        </li>
        <li>
            <label class="label_name">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱：</label>
            <span class="add_name"><input name="邮箱" type="text" data-shu="youxiang" class="text_add"/></span>
            <div class="prompt r_f"></div>
        </li>
        <li class="adderss"><label class="label_name">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址：</label><span class="add_name"><input name="家庭住址" type="text"  class="text_add" data-shu='dizhi' style=" width:350px"/></span><div class="prompt r_f"></div></li>
        <li><label class="label_name">状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态：</label><span class="add_name">
     <label><input name="form-field-radio2" type="radio" checked="checked" class="ace" value="1"><span class="lbl">开启</span></label>&nbsp;&nbsp;&nbsp;
     <label><input name="form-field-radio2"type="radio" class="ace" value="0"><span class="lbl">关闭</span></label></span><div class="prompt r_f"></div></li>
    </ul>
</div>

<!--修改用户图层-->
<div class="add_menber" id="add_menber_style2" style="display:none">

    <ul class=" page-content">
        <li><label class="label_name">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</label><span class="add_name"><input value="111" name="姓名" type="text" data-shu="xingming" class="text_add"/></span><div class="prompt r_f"></div></li>
        <!-- <li><label class="label_name">真实姓名：</label><span class="add_name"><input name="真实姓名" type="text"  class="text_add"/></span><div class="prompt r_f"></div></li> -->
        <li><label class="label_name">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</label><span class="add_name">
     <label><input name="form-field-radio" data-shu="xingbie" type="radio" checked="checked" value="男" class="ace"><span class="lbl">男</span></label>&nbsp;&nbsp;&nbsp;
     <label><input name="form-field-radio"  data-shu="xingbie" type="radio" class="ace" value="女"><span class="lbl">女</span></label>&nbsp;&nbsp;&nbsp;
            <!--  <label><input name="form-field-radio" type="radio" class="ace"><span class="lbl">保密</span></label> -->
     </span>
            <div class="prompt r_f"></div>
        </li>
        <li><label class="label_name">手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机：</label><span class="add_name"><input name="固定电话" type="text" data-shu="phone" class="text_add"/></span><div class="prompt r_f"></div></li>
        <li><label class="label_name">爱&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;好：</label><span class="add_name"><input name="爱好" type="text" data-shu="aihao" class="text_add"/></span><div class="prompt r_f"></div></li>
        <li>
            <label class="label_name">身份证号：</label>
            <span class="add_name"><input name="身份证号" type="text" data-shu="shengfenzheng" class="text_add"/></span>
            <div class="prompt r_f"></div>
        </li>
        <li>
            <label class="label_name">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱：</label>
            <span class="add_name"><input name="邮箱" type="text" data-shu="youxiang" class="text_add"/></span>
            <div class="prompt r_f"></div>
        </li>
        <li class="adderss"><label class="label_name">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址：</label><span class="add_name"><input name="家庭住址" data-shu="dizhi" type="text"  class="text_add" style=" width:350px"/></span><div class="prompt r_f"></div></li>
        <li><label class="label_name">状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态：</label><span class="add_name">
     <label><input name="form-field-radio4" type="radio" checked="checked" class="ace" value="1"><span class="lbl">开启</span></label>&nbsp;&nbsp;&nbsp;
     <label><input name="form-field-radio4"type="radio" class="ace" value="0"><span class="lbl" >关闭</span></label></span><div class="prompt r_f"></div></li>
    </ul>
</div>
</body>
</html>
<script>
jQuery(function($) {

  // dataTable表格插件控制表格排序
				var oTable1 = $('#sample-table').dataTable({
				"aaSorting": [[ 0, "asc" ]],//默认第几个排序
		  //   "bStateSave": true,//状态保存
        "paging":   true,  //分页功能
        "filter":false,   //搜索功能
        // "columnDefs":[{"targets":[0], "searchable":false}],
    // "dom": '<"top"i>rt<"bottom"flp><"clear">',
		    "aoColumnDefs": [
		  //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
		    {"orderable":false,"aTargets":[1,2,3,4,5,6,7,8]}// 制定列不参与排序
		    ] 
      });
				
	// 前面的小勾
				$('table th input:checkbox').on('click' , function(){
					 var that = this;
					 $(this).closest('table').find('tr > td:first-child input:checkbox').each(function(){
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
        title: '添加租户',
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
                      window.location="<%=basePath%>/user/user_list";
                      layer.close(index);
                  }

			  });

			   layer.close(index);
              adduser();
		  }		  		     				
		}
    });

});

function adduser(){
    var xingming1= $("#add_menber_style input[data-shu='xingming']").val();
    var xingbie1=$("#add_menber_style input[name='form-field-radio0']:checked").val();
    var phone1=$("#add_menber_style input[data-shu='phone']").val();
    var aihao1=$("#add_menber_style input[data-shu='aihao']").val();
    var shengfenzheng1= $("#add_menber_style input[data-shu='shengfenzheng']").val();
    var dizhi1=$("#add_menber_style input[data-shu='dizhi']").val();
    var zhuangtai1=$("#add_menber_style input[name='form-field-radio2']:checked").val();
    var youxiang1=$("#add_menber_style input[data-shu='youxiang']").val();

    // alert("获取成功");
    // alert(xingming1);
    // alert(xingbie1);
    // alert(phone1);alert(aihao1);
    // alert(shengfenzheng1);alert(dizhi1);
    // alert(zhuangtai1);
    // alert(youxiang1);
    $.ajax({
        type: "POST",
        url: 'user/add',
        data: {user_name:xingming1,user_telephone:phone1,user_IDcard:shengfenzheng1,
            user_address:dizhi1,user_sex:xingbie1,user_hobby:aihao1,user_state:zhuangtai1,user_email:youxiang1},
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
/*用户-编辑*/
function member_edit(obj,aihao,youxiang,zhuangtai){
    // $.ajax({
    //     type: "POST",
    //     url: 'user/selectTel',        //提交到路径需要返回一个用户
    //     data: {user_telephone:telephone},
    //     dataType:'json',
    //     cache: false,
    //     success: function(data){
    //         console.log("提交手机号成功");
    //     }
    // });


    //然后需要返回的一个用户，我能获取到它信息

    var xingming=$(obj).parent().parent().find("td").eq(1).html();
    var xingbie=$(obj).parent().parent().find("td").eq(2).html();
    var phone=$(obj).parent().parent().find("td").eq(3).html();
    var shengfenzheng=$(obj).parent().parent().find("td").eq(4).html();
    var dizhi=$(obj).parent().parent().find("td").eq(5).html();
    var aihao3=aihao;
    var youxiang3=youxiang;
    var zhuangtai3=zhuangtai;
    $("#add_menber_style2 input[data-shu='xingming']").val(xingming);
    $("#add_menber_style2 input[data-shu='phone']").val(phone);
    $("#add_menber_style2 input[data-shu='shengfenzheng']").val(shengfenzheng);
    $("#add_menber_style2 input[data-shu='dizhi']").val(dizhi);
    $("#add_menber_style2 input[data-shu='aihao']").val(aihao3);
    $("#add_menber_style2 input[data-shu='youxiang']").val(youxiang3);
    if(zhuangtai3=="1"){
        // alert("状态为1启用");
        $("input[name='form-field-radio4']:eq(0)").attr("checked",'checked');
    }else if(zhuangtai3==0)
    {$("input[name='form-field-radio4']:eq(1)").attr("checked",'checked');}

    if(xingbie=="男")
    {$("input[name='form-field-radio']:eq(0)").attr("checked",'checked');}
    else if(xingbie="女"){
        $("input[name='form-field-radio']:eq(1)").attr("checked",'checked');
    }
    layer.open({
        type: 1,
        title: '修改租户信息',
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
                        window.location="<%=basePath%>/user/user_list";
                        console.log(1);
                        layer.close(index);
                    }
                });

                layer.close(index);
                upuser();
            }
        }
    });
}
function upuser(){
    var xingming2= $("#add_menber_style2 input[data-shu='xingming']").val();
    var xingbie2=$("#add_menber_style2 input[name='form-field-radio']:checked").val();
    var phone2=$("#add_menber_style2 input[data-shu='phone']").val();
    var aihao2=$("#add_menber_style2 input[data-shu='aihao']").val();
    var shengfenzheng2= $("#add_menber_style2 input[data-shu='shengfenzheng']").val();
    var dizhi2=$("#add_menber_style2 input[data-shu='dizhi']").val();
    var zhuangtai2=$("#add_menber_style2 input[name='form-field-radio4']:checked").val();
    var youxiang2=$("#add_menber_style2 input[data-shu='youxiang']").val();
    console.log("提取获取了更新的数据");
    // alert("获取成功");
    // alert(xingming2);
    // alert(xingbie2);
    // alert(phone2);alert(aihao2);
    // alert(shengfenzheng2);alert(dizhi2);
    // alert(zhuangtai2);
    // alert(youxiang2);
    $.ajax({
        type: "POST",
        url: 'user/update',
        data: {user_name:xingming2,user_telephone:phone2,user_IDcard:shengfenzheng2,
            user_address:dizhi2,user_sex:xingbie2,user_hobby:aihao2,user_state:zhuangtai2,user_email:youxiang2},
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
    //删除父类
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
function user_history(id){
    window.location.href ="user_history.jsp?="+id;
};


</script>
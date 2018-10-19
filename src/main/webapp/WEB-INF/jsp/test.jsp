<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="css/style.css"/>       
        <link href="assets/css/codemirror.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/ace.min.css" />
        <link rel="stylesheet" href="assets/css/font-awesome.min.css" />
		<!--[if IE 7]>
		  <link rel="stylesheet" href="assets/css/font-awesome-ie7.min.css" />
		<![endif]-->
        <!--[if lte IE 8]>
		  <link rel="stylesheet" href="assets/css/ace-ie.min.css" />
		<![endif]-->
			<script src="assets/js/jquery.min.js"></script>

		<!-- <![endif]-->

		<!--[if IE]>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<![endif]-->

		<!--[if !IE]> -->

		<script type="text/javascript">
			window.jQuery || document.write("<script src='assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
		</script>

		<!-- <![endif]-->

		<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
</script>
<![endif]-->

		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
		</script>
		<script src="assets/js/bootstrap.min.js"></script>
		<script src="assets/js/typeahead-bs2.min.js"></script>
		<!-- page specific plugin scripts -->
		<script src="assets/js/jquery.dataTables.min.js"></script>
		<script src="assets/js/jquery.dataTables.bootstrap.js"></script>

        <script type="text/javascript" src="js/H-ui.js"></script> 
        <script type="text/javascript" src="js/H-ui.admin.js"></script> 
        <script src="assets/layer/layer.js" type="text/javascript" ></script>
        <script src="assets/laydate/laydate.js" type="text/javascript"></script>
<title>用户列表</title>
</head>

<body>
<div class="page-content clearfix">
    <div id="Member_Ratings">
      <div class="d_Confirm_Order_style">
    <div class="search_style">
     
      <ul class="search_content clearfix">
       <li><label class="l_f">租户姓名</label><input name="" type="text"  class="text_add" placeholder="输入租户名称、手机"  style=" width:400px"/></li>
       <li><label class="l_f">添加时间</label><input class="inline laydate-icon" id="start" style=" margin-left:10px;"></li>
       <li style="width:90px;"><button type="button" class="btn_search"><i class="icon-search"></i>查询</button></li>
      </ul>
    </div>
     <!---->
     <div class="border clearfix">
       <span class="l_f">
        <a href="javascript:ovid()" id="member_add" class="btn btn-warning"><i class="icon-plus"></i>添加租户</a>
        <a href="javascript:ovid()" class="btn btn-danger"><i class="icon-trash"></i>批量删除</a>
       </span>
       <span class="r_f">共：<b>19</b>条</span>
     </div>
     <!---->
     <div class="table_menu_list">
       <table class="table table-striped table-bordered table-hover" id="sample-table">
		<thead>
		 <tr>
				<th width="25"><label><input type="checkbox" class="ace"><span class="lbl"></span></label></th>
				<th width="80">ID</th>
				<th width="100">姓名</th>
				<th width="80">性别</th>
				<th width="120">手机</th>
				<th width="">地址</th>
				<th width="70">状态</th>                
				<th width="250">操作</th>
			</tr>
		</thead>
	<tbody>
		<tr>
          <td><label><input type="checkbox" class="ace"><span class="lbl"></span></label></td>
          <td>1</td>
          <td><u style="cursor:pointer" class="text-primary" onclick="member_show('张三','member-show.html','10001','500','400')" title="点击查看用户详情">谢一</u></td>
          <td>男</td>
          <td>13000000000</td>
          <td class="text-l">北京市 海淀区西土城路10号</td>
          <td class="td-status"><span class="label label-success radius">已启用</span></td>
          <td class="td-manage">
          
          </td>
		</tr>
        <tr>
          <td><label><input type="checkbox" class="ace"><span class="lbl"></span></label></td>
          <td>2</td>
          <td><u style="cursor:pointer" class="text-primary" onclick="member_show('张小泉','member-show.html','1031','500','400')">张二</u></td>
          <td>男</td>
          <td>13000000000</td>
          <!-- <td>admin@mail.com</td> -->
          <td class="text-l">北京市 海淀区西土城10号</td>
          <!-- <td>2014-6-11 11:11:42</td> -->
          <td class="td-status"><span class="label label-success radius">已启用</span></td>
          <td class="td-manage">
         
          </td>
		</tr>
         <tr>
          <td><label><input type="checkbox" class="ace"><span class="lbl"></span></label></td>
          <td>3</td>
          <td><u style="cursor:pointer" class="text-primary" onclick="member_show('张小泉','member-show.html','10301','500','400')">李三</u></td>
          <td>男</td>
          <td>13000000000</td>
          <td class="text-l">北京市 海淀区</td>
          <td class="td-status"><span class="label label-success radius">已启用</span></td>
          <td class="td-manage">
          
          </td>
		</tr>
         <tr>
          <td><label><input type="checkbox" class="ace"><span class="lbl"></span></label></td>
          <td>4</td>
          <td><u style="cursor:pointer" class="text-primary" onclick="member_show('张小泉','member-show.html','10001','500','400')">王四</u></td>
          <td>男</td>
          <td>13000000000</td>
          <!-- <td>admin@mail.com</td> -->
          <td class="text-l">北京市 海淀区</td>
          <!-- <td>2014-6-11 11:11:42</td> -->
          <td class="td-status"><span class="label label-success radius">已启用</span></td>
          <td class="td-manage">
         
          </td>
		</tr>
         <tr>
          <td><label><input type="checkbox" class="ace"><span class="lbl"></span></label></td>
          <td>5</td>
          <td><u style="cursor:pointer" class="text-primary" onclick="member_show('张小泉','member-show.html','10001','500','400')">张小泉</u></td>
          <td>男</td>
          <td>13000000000</td>
          <!-- <td>admin@mail.com</td> -->
          <td class="text-l">北京市 海淀区</td>
          <!-- <td>2014-6-14 11:11:42</td> -->
          <td class="td-status"><span class="label label-success radius">已启用</span></td>
          <td class="td-manage">
        
          </td>
		</tr>
      </tbody>
	</table>
   </div>
  </div>
 </div>
</div>

</body>
</html>
<script>
jQuery(function($) {
  // dataTable表格插件控制表格排序
				var oTable1 = $('#sample-table').dataTable( 
				/*{
        "aaSorting": [[ 1, "desc" ]],//默认第几个排序
		    "bStateSave": true,//状态保存
        "paging": true,  //分页功能
        "filter":true,   //搜索功能
      
		    "aoColumnDefs": [
		  //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
		    {"orderable":false,"aTargets":[0,2,3,4,5,6,7,8,9]}// 制定列不参与排序
		    ] }  
         */
        );
				
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



function user_history(id){
    window.location.href ="user_history.html?="+id;
};
</script>
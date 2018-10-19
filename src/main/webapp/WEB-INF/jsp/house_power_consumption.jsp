<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Cache-Control" content="no-siteapp" />
 <link href="../assets/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="../css/style.css"/>       
        <link href="../assets/css/codemirror.css" rel="stylesheet">
        <link rel="stylesheet" href="../assets/css/ace.min.css" />
        <link rel="stylesheet" href="../font/css/font-awesome.min.css" />
        <!--[if lte IE 8]>
		  <link rel="stylesheet" href="assets/css/ace-ie.min.css" />
		<![endif]-->
		<script src="../js/jquery-1.9.1.min.js"></script>
        <script src="../js/jquery.SuperSlide.2.1.1.js"></script>
        <script src="../assets/js/bootstrap.min.js"></script>
		<script src="../assets/js/typeahead-bs2.min.js"></script>           	
		<script src="../assets/js/jquery.dataTables.min.js"></script>
		<script src="../assets/js/jquery.dataTables.bootstrap.js"></script> 
        <script src="../assets/layer/layer.js" type="text/javascript" ></script>          
        <script src="../assets/laydate/laydate.js" type="text/javascript"></script>     
        <script src="../js/lrtk.js" type="text/javascript" ></script>
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
<title>用电量实时统计（房源）</title>
</head>

<body>
<div class="margin clearfix">
    <div class="Account_style">
<!--账户基本信息-->
  <!-- <span class="title_name">租户基本信息</span> -->
    <div class="baozhe">
             <span class="xinxi">房源基本信息</span>
    </div>
 <div class="Manager_style clearfix">
        <table class="table table-striped table-bordered table-hover">
            <thead>
                <tr>
                    <th width="80">房源编号</th>
                    <th width="100">地址</th>
                    <th width="80">房源结构</th>
                    <!-- <th width="120">手机</th> 
                    <th width="150">身份证号</th>
                    <th width="">地址</th> -->
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>北京市 海淀区西土城路10号</td>
                    <!-- <td>男</td> -->
                    <td>三室一厅</td>
                <!--     <td>35081102346786</td> -->
                    <!-- <td class="text-l">北京市 海淀区西土城路10号</td> -->
                </tr>
            </tbody>
        </table>
 
 </div>

 <div class="recording_style">
    <div id="recording">
        <div class="hd" >
            <ul>
                <li ">该房间下电器</li>
            </ul>
        </div>
        <div class="bd">
            <ul class="">
                <table class="table table-striped table-bordered table-hover" id="sample-table">
                   <thead>
		                  <tr>
                                <th width=""><label><input type="checkbox" class="ace"><span class="lbl"></span></label></th>
                                <th width="">电器编号</th>
                               <th width="">电器描述</th>
                               <th width="">实时电量（曲线图）</th>                 
                         </tr>


                    </thead>
	               <tbody>
		               <tr>
                          <td><label><input type="checkbox" class="ace"><span class="lbl"></span></label></td>
                          <td>01a</td>
                          <td>空调</td>
                          <td></td>
                        </tr>
                     <tr>
                          <td><label><input type="checkbox" class="ace"><span class="lbl"></span></label></td>
                          <td>01b</td>
                          <td>热水器</td>
                          <td></td>
                        </tr>
                    </tbody>
                </table>
            </ul>
        </div>
    </div>
 </div>
 <script type="text/javascript">jQuery("#recording").slide({trigger:"click" });</script>



</div>
</div>


</body>
</html>

<script type="text/javascript">

// 编写筛选函数
jQuery(function($) {
		var oTable1 = $('#sample-table').dataTable( {
		"aaSorting": [[ 1, "desc" ]],//默认第几个排序
		"bStateSave": true,//状态保存
		"bAutoWidth":true,
		"bFilter":false,
		"aoColumnDefs": [
		  //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
		  {"orderable":false,"aTargets":[0,1,2,3,5,6]}// 制定列不参与排序
		] } );
		var recording = $('#sconsumption-table').dataTable( {
		"aaSorting": [[ 1, "desc" ]],//默认第几个排序
		"bStateSave": true,//状态保存
		"bAutoWidth":true,
		"bFilter":false,
		"aoColumnDefs": [
		  {"orderable":false,"aTargets":[0,1,2,3,5,6,7,8]}// 制定列不参与排序
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

</script>
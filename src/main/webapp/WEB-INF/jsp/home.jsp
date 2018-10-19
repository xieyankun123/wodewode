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
        	<link rel="stylesheet" href="static/assets/css/ace.min.css" />
        <link rel="stylesheet" href="static/assets/css/font-awesome.min.css" />
        <link href="static/assets/css/codemirror.css" rel="stylesheet">
		<!--[if IE 7]>
		  <link rel="stylesheet" href="static/assets/css/font-awesome-ie7.min.css" />
		<![endif]-->
        <!--[if lte IE 8]>
		  <link rel="stylesheet" href="static/assets/css/ace-ie.min.css" />
		<![endif]-->
		<script src="static/assets/js/ace-extra.min.js"></script>
		<!--[if lt IE 9]>
		<script src="static/assets/js/html5shiv.js"></script>
		<script src="static/assets/js/respond.min.js"></script>
		<![endif]-->
        		<!--[if !IE]> -->
		<script src="static/assets/js/jquery.min.js"></script>
		<!-- <![endif]-->
           	<script src="static/assets/dist/echarts.js"></script>
        <script src="static/assets/js/bootstrap.min.js"></script>
                <script src="static/Highcharts-6.1.1\code/highcharts.js"></script>
        <script src="static/Highcharts-6.1.1\code\modules/series-label.js"></script>
        <script src="static/Highcharts-6.1.1\code\modules/oldie.js"></script>
        <script src="static\highcharts-zh_CN-master/highcharts-zh_CN.js"></script>
        <style type="text/css">
             .highcharts-credits{display: none;}
        </style>
        <script>
        window.onload = function(){
 var chart = Highcharts.chart('container', {
        title: {
                text: '房源增长率与租房增长率'
        },
        subtitle: {
                text: '单位：%'
        },
        yAxis: {
                title: {
                        text: '增长率'
                }
        },
        legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle'
        },
        xAxis: {
                categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月']
            },
     colors: ['orange', 'lightblue'],// 改改改
        // plotOptions: {
        //         series: {
        //                 label: {
        //                         connectorAllowed: false
        //                 },
        //                 pointStart: 10
        //         }
        // },
        series: [{
                name: '房源增长率',
                data: [5.2, 5.5, 6, 6.2, 6.3, 5, 6.1, 5.5,6.3,7.3,6.1]
        },{
                name: '租房增长率',
                data: [5.3, 4.6, 6.1, 6.4, 7.1, 5.4, 5.2, 6.1,5.3,6.2,7.1]
        } 
        ],
        responsive: {
                rules: [{
                        condition: {
                                maxWidth: 500
                        },
                        chartOptions: {
                                legend: {
                                        layout: 'horizontal',
                                        align: 'center',
                                        verticalAlign: 'bottom'
                                }
                        }
                }]
        }
});

Highcharts.chart('container2', {
    chart: {
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false,
        type: 'pie'
    },
    title: {
        text: '房源租用占比'
    },
    tooltip: {
        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
    },
    plotOptions: {
        pie: {
            allowPointSelect: true,
            cursor: 'pointer',
            dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                style: {
                    color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                }
            }
        }
    },
    colors: ['#009999', '#CC3399'],
    series: [{
        name: '比例',
        colorByPoint: true,
        data: [{
            name: '房屋被租用',
            y: 73.3,
            sliced: true,
            selected: true
        }, {
            name: '房屋空闲',
            y: 26.7
        }]
    }]
});

}
        </script>         
       <title></title>
       </head>		
<body>
<div class="page-content clearfix">
 <div class="alert alert-block alert-success">
  <button type="button" class="close" data-dismiss="alert"><i class="icon-remove"></i></button>
  <i class="icon-ok green"></i>欢迎使用<strong class="green">房屋管家后台管理系统<small>(v1.0)</small></strong>
 </div>
 <div class="state-overview clearfix">
                  <div class="col-lg-4 col-sm-6">
                      <section class="panel">
                      <%--<a href="#" title="租户">--%>
                          <div class="symbol terques">
                             <i class="icon-user"></i>
                          </div>
                          <div class="value">
                              <h1>250</h1>
                              <p>租户人数</p>
                          </div>
                          </a>
                      </section>
                  </div>
                  <div class="col-lg-4 col-sm-6">
                      <section class="panel">
                          <div class="symbol red">
                              <i class="icon-tags"></i>
                          </div>
                          <div class="value">
                              <h1>140</h1>
                              <p>租房记录</p>
                          </div>
                      </section>
                  </div>
                <!--   <div class="col-lg-6 col-sm-12">
                      <section class="panel">
                          <div class="symbol blue">
                              <i class="icon-bar-chart"></i>
                          </div>
                          <div class="value">
                              <h1>￥34,500</h1>
                              <p>交易记录</p>
                          </div>
                      </section>
                  </div> -->
              </div>
               <div class="state-overview clearfix">
                  <div  class="col-lg-4 col-sm-6" id="container" ></div>
                    <div  class="col-lg-4 col-sm-6" id="container2" ></div>
               </div>

</body>
</html>
<script type="text/javascript">
//面包屑返回值
var index = parent.layer.getFrameIndex(window.name);
parent.layer.iframeAuto(index);
$('.no-radius').on('click', function(){
	var cname = $(this).attr("title");
	var chref = $(this).attr("href");
	var cnames = parent.$('.Current_page').html();
	var herf = parent.$("#iframe").attr("src");
    parent.$('#parentIframe').html(cname);
    parent.$('#iframe').attr("src",chref).ready();;
	parent.$('#parentIframe').css("display","inline-block");
	parent.$('.Current_page').attr({"name":herf,"href":"javascript:void(0)"}).css({"color":"#4c8fbd","cursor":"pointer"});
	//parent.$('.Current_page').html("<a href='javascript:void(0)' name="+herf+" class='iframeurl'>" + cnames + "</a>");
    parent.layer.close(index);
	
});
     $(document).ready(function(){
		 
		  $(".t_Record").width($(window).width()-640);
		  //当文档窗口发生改变时 触发  
    $(window).resize(function(){
		 $(".t_Record").width($(window).width()-640);
		});
 });
	 
	 
 </script>   
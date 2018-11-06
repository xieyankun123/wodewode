<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
    <head>
        <base href="<%=basePath%>">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="static/assets/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="static/assets/css/font-awesome.min.css" />

        <link rel="stylesheet" href="static/assets/css/ace.min.css" />
        <link rel="stylesheet" href="static/assets/css/ace-rtl.min.css" />
        <link rel="stylesheet" href="static/assets/css/ace-skins.min.css" />

        <link rel="stylesheet" href="static/css/style.css"/>
        <script src="static/js/jquery-1.9.1.min.js"></script>
        <script src="static/js/jquery.tips.js"></script>
        <script src="static/assets/js/ace-extra.min.js"></script>
        <script src="static/assets/layer/layer.js" type="text/javascript"></script>
        <style>
           .active{
               background:yellow;}
           .tukuang{overflow:hidden;} /*只显示一个图超过大小则隐藏*/
           .tukuang div:first-Child{display: block;}
        </style>
        <script src="static/Highcharts.1.1\code/highcharts.js"></script>
        <script src="static/Highcharts--66.1.1\code\modules/series-label.js"></script>
        <script src="static/Highcharts-6.1.1\code\modules/oldie.js"></script>
        <script src="static/highcharts-zh_CN-master/highcharts-zh_CN.js"></script>
        <script src="static/js/echarts.js"></script>
        <script>
            function bianse1() {
                $('button').attr('class','');
                $('#button1').addClass('active');
                $(".tu").css('display','none');
                $("#echarts_3").css('display','block');
            }
            function bianse2() {
                $('button').attr('class','');
                $('#button2').addClass('active');
                $(".tu").css('display','none');
                $("#echarts_4").css('display','block');
            }
            function load(a) {

                var aa=a;

                // 绘制以天为横坐标的图-------------------------------
                var myChart = echarts.init(document.getElementById('echarts_3'));
                // 指定图表的配置项和数据
                var option = {
                    title: {	//图表标题
                        text: '设备用电量（天数）'

                    },
                    tooltip: {
                        trigger: 'axis', //坐标轴触发提示框，多用于柱状、折线图中

                    },
                    dataZoom: [
                        {
                            type: 'slider',	//支持鼠标滚轮缩放
                            start: 0,			//默认数据初始缩放范围为10%到90%
                            end: 100
                        },
                        {
                            type: 'inside',	//支持单独的滑动条缩放
                            start: 0,			//默认数据初始缩放范围为10%到90%
                            end: 100
                        }
                    ],
                    legend: {	//图表上方的类别显示
                        orient: 'horizontal',
                        left: 'center',
                        top: '30',
                        show:true,
                        data:['电量']
                    },
                    // color:[
                    //     'red'	//总任务单数曲线颜色
                    // ],
                    toolbox: {
                        feature: {
                            dataView: {show: true, readOnly: false},
                            magicType: {show: true, type: ['line', 'bar']},
                            restore: {show: true},
                            saveAsImage: {show: true}
                        }
                    },
                    xAxis:  {	//X轴
                        type : 'category',
                        data : []	//先设置数据值为空，后面用Ajax获取动态数据填入
                    },
                    yAxis : [	//Y轴（这里我设置了两个Y轴，左右各一个）
                        {
                            //第一个（左边）Y轴，yAxisIndex为0
                            type : 'value',
                            name : '电量(°)',
                            axisLabel : {
                                formatter: '{value} '	//控制输出格式
                            }
                        }
                    ],
                    series : [	//系列（内容）列表
                        {
                            name:'电量',
                            type:'line',	//折线图表示（生成温度曲线）
                            symbol:'emptycircle',	//设置折线图中表示每个坐标点的符号；emptycircle：空心圆；emptyrect：空心矩形；circle：实心圆；emptydiamond：菱形
                            data:[]		//数据值通过Ajax动态获取
                        }
                    ]
                };
                myChart.showLoading();     //加载动画
                var sum2=[];
                var dates2=[];
                $.ajax({	//使用JQuery内置的Ajax方法
                        type : "POST",		//post请求方式
                        async : true,		//异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
                        url :'<%=basePath%>echarts/ele',	//请求发送到ShowInfoIndexServlet处
                        data : {apparatus_id:aa},		//请求内包含一个key为yiqihao，value为shebeihao的参数；
                        dataType : 'json',		//返回数据形式为json
                        success : function(data) {
                            //请求成功时执行该函数内容，result即为服务器返回的json对象
                            if (data.result != null && data.result.length > 0) {
                                 console.info(data.result);
                                for(var i=0;i<data.result.length;i++){
                                    sum2.push(data.result[i].value);
                                    dates2.push(data.result[i].day);
                                }
                                myChart.hideLoading();	//隐藏加载动画
                                myChart.setOption({		//载入数据
                                    xAxis: {
                                        data: dates2	//填入X轴数据
                                    },
                                    series: [	//填入系列（内容）数据
                                        {
                                            // 根据名字对应到相应的系列
                                            name: '电量',
                                            data: sum2
                                        }
                                    ]
                                });
                            }
                            else {
                                //返回的数据为空时显示提示信息
                                alert("图表请求数据为空，可能服务器暂未录入观测数据，您可以稍后再试！");
                                myChart.hideLoading();
                            }
                        },
                        error : function(errorMsg) {
                            //请求失败时执行该函数
                            alert("图表请求数据失败，可能是服务器开小差了");
                            myChart.hideLoading();
                        }
                    })
                myChart.setOption(option);	//载入图表


                // 绘制第二个图以分钟为横坐标--------------------------------------
                document.getElementById("echarts_4").style.display = "block";
                var myChart2 = echarts.init(document.getElementById('echarts_4'));
                // 指定图表的配置项和数据
                var option2 = {
                    title: {	//图表标题
                        text: '设备用电量(分钟)'

                    },
                    tooltip: {
                        trigger: 'axis', //坐标轴触发提示框，多用于柱状、折线图中

                    },
                    dataZoom: [
                        {
                            type: 'slider',	//支持鼠标滚轮缩放
                            start: 0,			//默认数据初始缩放范围为10%到90%
                            end: 100
                        },
                        {
                            type: 'inside',	//支持单独的滑动条缩放
                            start: 0,			//默认数据初始缩放范围为10%到90%
                            end: 100
                        }
                    ],
                    legend: {	//图表上方的类别显示
                        orient: 'horizontal',
                        left: 'center',
                        top: '30',
                        show:true,
                        data:['电量']
                    },
                    color:[
                        'orange'	//总任务单数曲线颜色
                    ],
                    toolbox: {
                        feature: {
                            dataView: {show: true, readOnly: false},
                            magicType: {show: true, type: ['line', 'bar']},
                            restore: {show: true},
                            saveAsImage: {show: true}
                        }
                    },
                    xAxis:  {	//X轴
                        type : 'category',
                        data : []	//先设置数据值为空，后面用Ajax获取动态数据填入
                    },
                    yAxis : [	//Y轴（这里我设置了两个Y轴，左右各一个）
                        {
                            //第一个（左边）Y轴，yAxisIndex为0
                            type : 'value',
                            name : '电量(°)',
                            /* max: 120,
                             min: -40, */
                            axisLabel : {
                                formatter: '{value} '	//控制输出格式
                            }
                        }
                    ],
                    series : [	//系列（内容）列表
                        {
                            name:'电量',
                            type:'line',	//折线图表示（生成温度曲线）
                            symbol:'emptycircle',	//设置折线图中表示每个坐标点的符号；emptycircle：空心圆；emptyrect：空心矩形；circle：实心圆；emptydiamond：菱形
                            data:[]		//数据值通过Ajax动态获取
                        }
                    ]
                };
                myChart.showLoading();     //加载动画
                var sum3=[];
                var dates3=[];
                $.ajax({	//使用JQuery内置的Ajax方法
                    type : "POST",		//post请求方式
                    async : true,		//异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
                    url :'<%=basePath%>echarts/power',	//请求发送到ShowInfoIndexServlet处
                    data : {apparatus_id:aa},		//请求内包含一个key为yiqihao，value为shebeihao的参数；
                    dataType : 'json',		//返回数据形式为json
                    success : function(data) {
                        //请求成功时执行该函数内容，result即为服务器返回的json对象
                        if (data.result != null && data.result.length > 0) {
                            console.info(data.result);
                            for(var i=0;i<data.result.length;i++){
                                sum3.push(data.result[i].value);
                                dates3.push(data.result[i].day);
                            }
                            myChart2.hideLoading();	//隐藏加载动画
                            myChart2.setOption({		//载入数据
                                xAxis: {
                                    data: dates3	//填入X轴数据
                                },
                                series: [	//填入系列（内容）数据
                                    {
                                        // 根据名字对应到相应的系列
                                        name: '电量',
                                        data: sum3
                                    }
                                ]
                            });
                        }
                        else {
                            //返回的数据为空时显示提示信息
                            alert("图表请求数据为空，可能服务器暂未录入观测数据，您可以稍后再试！");
                            myChart2.hideLoading();
                        }
                    },
                    error : function(errorMsg) {
                        //请求失败时执行该函数
                        alert("图表请求数据失败，可能是服务器开小差了");
                        myChart2.hideLoading();
                    }
                })
                myChart2.setOption(option2);	//载入图表
            }
        </script>
    </head>
    <div items="${apparatus_id}" var="apparatus_id">
    <body onload="load('${apparatus_id}')">
        <div class="top-nav">
            <button class="active" id="button1" onclick="bianse1()">天数视图</button>
            <button id="button2" onclick="bianse2()">分钟视图</button>
        </div>
        <div class="tukuang" style="width:600px;height:400px">
            <div id="echarts_3" class="tu" style="width:600px;height:400px"></div>
            <div id="echarts_4" class="tu" style="width:600px;height:400px" ></div>
        </div>

    </body>
</html>
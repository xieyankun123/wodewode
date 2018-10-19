<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
</head>
<body>
<div id="container" style="max-width:600px;height:400px"></div>
<!-- <script src="https://img.hcharts.cn/jquery/jquery-1.8.3.min.js"></script>
<script src="https://img.hcharts.cn/highcharts/highcharts.js"></script>
<script src="https://img.hcharts.cn/highcharts/modules/exporting.js"></script>
<script src="https://img.hcharts.cn/highcharts-plugins/highcharts-zh_CN.js"></script> -->
<!-- <script src="https://img.hcharts.cn/jquery/jquery-1.8.3.min.js"></script> -->
	<script src="../assets/js/jquery.min.js"></script>
<script src="../Highcharts-6.1.1\code/highcharts.js"></script>
<script src="../Highcharts-6.1.1\code\modules/exporting.js"></script>
<script src="..\highcharts-zh_CN-master/highcharts-zh_CN.js"></script>
<script>
    $(function () {
        Highcharts.setOptions({
            credits:{
                enabled:false
            }
        });
        $('#container').highcharts({
            chart: {
                type: 'line'
            },
            title: {
                text: '实时用电量'
            },
            subtitle: {
                text: '单位（度）'
            },
            xAxis: {
                categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
            },
            yAxis: {
                title: {
                    text: ''
                }

            },

            plotOptions: {

                line: {

                    dataLabels: {

                        enabled: true          // 开启数据标签

                    },

                    enableMouseTracking: false // 关闭鼠标跟踪，对应的提示框、点击事件会失效

                }

            },

            series: [
                // {
                //     name: '东京',
                //     data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25,26.5, 23.3, 18.3, 13.9, 9.6]
                // }, 
                {
                    name: '伦敦',

                    data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
                }
            ]
        });

    });
</script>


</body>
</html>
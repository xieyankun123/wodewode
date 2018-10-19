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
        <style>
           .highcharts-credits{display: none;}
        </style>
        <script src="static/Highcharts-6.1.1\code/highcharts.js"></script>
        <script src="static/Highcharts-6.1.1\code\modules/series-label.js"></script>
        <script src="static/Highcharts-6.1.1\code\modules/oldie.js"></script>
        <script src="static/highcharts-zh_CN-master/highcharts-zh_CN.js"></script>
        <script>
        window.onload = function(){
 var chart = Highcharts.chart('container', {
        title: {
                text: '实时电量'
        },
        subtitle: {
                text: '单位：度'
        },
        yAxis: {
                title: {
                        text: '电量'
                }
        },
        legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle'
        },
        // xAxis: {
        //         categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月']
        //     },
        plotOptions: {
                series: {
                        label: {
                                connectorAllowed: false
                        },
                        pointStart: 10
                }
        },
        series: [{
                name: '电量',
                data: [5, 7, 8, 6.2, 6, 8, 7, 5.5,6.3,7.3,6.1]
        } ],
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

}
        </script>
    </head>
    <body>
        <div id="container" style="max-width:600px;height:400px"></div>
        <script>
           
        </script>
    </body>
</html>
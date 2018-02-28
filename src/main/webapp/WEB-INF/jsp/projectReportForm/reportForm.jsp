<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>项目管理</title>

<%
   pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<link rel="stylesheet" href="${APP_PATH}/static/css/font-awesome.css">
<script src="${APP_PATH}/static/js/echarts.js"></script>
<script type="text/javascript">
function callbackFn(myChart,name,jsonURL){ 
	
	
	myChart.showLoading();
	
	$.ajax({
		url :jsonURL,
		data :'',
		type : "GET",
		success : function(result) {
			console.log(result.extend.roleName)
			myChart.hideLoading();
			myChart.setOption({
			    series: [{  
			        name: name,
			        
			        data: result.extend.roleProportion
			    }],
			    
			    legend: {
			        data:result.extend.roleName 
			    }

			});  
		}
	})
}

function initReport(myChart,text,subText){
	myChart.setOption({
		title:{
			text:text,
			subtext:subText,
			x:'center'
		},
		tooltip:{
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		 },
		 legend: {
		        orient: 'vertical',
		        left: 'left',
		    },
		    series : [
		        {
		            type: 'pie',
		            radius : '55%',
		            center: ['50%', '60%'],
		            itemStyle: {
		                emphasis: {
		                    shadowBlur: 10,
		                    shadowOffsetX: 0,
		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
		                }
		            }
		        }
		    ]
	});
}
</script>

<script type="text/javascript">
	$(function(){
		
		var chartTeam = echarts.init(document.getElementById('chartTeam'));
    	//执行初始化方法initReport
    	initReport(chartTeam,'项目团队人员','职称比例');
    	//执行数据填充方法callbackFn，series里面的name参数的值应和初始化方法中subText参数值一样
    	callbackFn(chartTeam,'职称比例',"${APP_PATH}/admin/reportForms/report");
    	
    	var chartNeedsAccept = echarts.init(document.getElementById('chartNeedsAccept'));
    	var chartNeedsUser = echarts.init(document.getElementById('chartNeedsUser'));
    	var chartNeedsSource = echarts.init(document.getElementById('chartNeedsSource'));
    	var chartTasksAccept = echarts.init(document.getElementById('chartTasksAccept'));
    	var chartTasksUser = echarts.init(document.getElementById('chartTasksUser'));
    	var chartTasksComplete = echarts.init(document.getElementById('chartTasksComplete'));
    	var chartTasksSource = echarts.init(document.getElementById('chartTasksSource'));
    	var chartTestsAccept = echarts.init(document.getElementById('chartTestsAccept'));
    	var chartTestsUser = echarts.init(document.getElementById('chartTestsUser'));
    	var chartTestsComplete = echarts.init(document.getElementById('chartTestsComplete'));
	})
</script>
</head>
    <body class="bg-common stickey-menu">

        <section>

            <!-- 页面模版，每页左侧区域固定不变 -->
             <jsp:include page="iniLeftMenu.jsp"></jsp:include>


            <div class="main-content">

                <!-- 页面模版，每页主体部分头部按需更改 -->
                <div class="content-head content-head-section">

                    <a href="" class="toggle-btn">
                        <span class="glyphicon glyphicon-th-list"></span>
                    </a>

                    <form action="${APP_PATH}/admin/demand/list" class="serach-form" method="get">

                        
						<select name="state" class="form-control">
				          <option value="需求状态">需求状态</option>
				          <option value="草稿">草稿</option>
				          <option value="激活">激活</option>
				          <option value="已变更">已变更</option>
				          <option value="待关闭">待关闭</option>
				          <option value="已关闭">已关闭</option>
       					</select>
                        <input type="text" placeholder="输入项目名称" value="${demandName == '需求名称'?null:demandName}" class="form-control" name="demandName">

                        <button type="submit" class="btn btn-primary">搜索</button>


                        <div class="clearfix"></div>
                    </form>


                     <jsp:include page="iniUserInfo.jsp"></jsp:include>

                    <div class="clearfix"></div>

                </div>

                <!-- 页面模版，按需更改 -->
                <div class="wrapper">

                    <div class="om-header">
						<div class="om-header-left">
							<h3>
								<span class="om-title">项目管理</span>
								<jsp:include page="projectLeftManagement.jsp"></jsp:include>
							</h3>
						</div>
                         
                      


                        <div class="clearfix"></div>
                    </div>

                    
                        <div class="row">
                        
                        	<!-- 1.项目成员职称比例  -->
                            <div class="col-sm-6">
                                <section class="panel">
                                	<header class="panel-heading">项目成员职称比例</header>
                                	<div class="panel-body">
                                		<div id="chartTeam" class="pie-chart"></div>
                                	</div>
                                </section>
                            </div>
                            
                            <!-- 2.项目需求接受人比例  -->
                            <div class="col-sm-6">
                                <section class="panel">
                                	<header class="panel-heading">项目需求接受人比例</header>
                                	<div class="panel-body">
                                		<div id="chartNeedsAccept" class="pie-chart"></div>
                                	</div>
                                </section>
                            </div>

							<!-- 3.项目需求创建人比例  -->
							<div class="col-sm-6">
                                <section class="panel">
                                	<header class="panel-heading">项目需求创建人比例</header>
                                	<div class="panel-body">
                                		<div id="chartNeedsUser" class="pie-chart"></div>
                                	</div>
                                </section>
                            </div>
							
							<!-- 4.项目需求来源比例  -->
							<div class="col-sm-6">
                                <section class="panel">
                                	<header class="panel-heading">项目需求来源比例</header>
                                	<div class="panel-body">
                                		<div id="chartNeedsSource" class="pie-chart"></div>
                                	</div>
                                </section>
                            </div>
							
							<!-- 5.项目任务接受人比例  -->
							<div class="col-sm-6">
                                <section class="panel">
                                	<header class="panel-heading">项目任务接收人比例</header>
                                	<div class="panel-body">
                                		<div id="chartTasksAccept" class="pie-chart"></div>
                                	</div>
                                </section>
                            </div>
							
							<!-- 6.项目任务创建人比例  -->
							<div class="col-sm-6">
                                <section class="panel">
                                	<header class="panel-heading">项目任务创建人比例</header>
                                	<div class="panel-body">
                                		<div id="chartTasksUser" class="pie-chart"></div>
                                	</div>
                                </section>
                            </div>
							
							<!-- 7.项目任务完成人比例  -->
							<div class="col-sm-6">
                                <section class="panel">
                                	<header class="panel-heading">项目任务完成人比例</header>
                                	<div class="panel-body">
                                		<div id="chartTasksComplete" class="pie-chart"></div>
                                	</div>
                                </section>
                            </div>
							
							<!-- 8.项目任务类型比例  -->
							<div class="col-sm-6">
                                <section class="panel">
                                	<header class="panel-heading">项目任务完成人比例</header>
                                	<div class="panel-body">
                                		<div id="chartTasksSource" class="pie-chart"></div>
                                	</div>
                                </section>
                            </div>
							
							<!-- 9.项目Bug接受人比例   -->
							<div class="col-sm-6">
                                <section class="panel">
                                	<header class="panel-heading">项目任务完成人比例</header>
                                	<div class="panel-body">
                                		<div id="chartTestsAccept" class="pie-chart"></div>
                                	</div>
                                </section>
                            </div>
							
							<!-- 10.项目Bug创建人比例    -->
							<div class="col-sm-6">
                                <section class="panel">
                                	<header class="panel-heading">项目任务完成人比例</header>
                                	<div class="panel-body">
                                		<div id="chartTestsUser" class="pie-chart"></div>
                                	</div>
                                </section>
                            </div>
							
							<!-- 11.项目Bug完成人比例     -->
							<div class="col-sm-6">
                                <section class="panel">
                                	<header class="panel-heading">项目任务完成人比例</header>
                                	<div class="panel-body">
                                		<div id="chartTestsComplete" class="pie-chart"></div>
                                	</div>
                                </section>
                            </div>
							
							
                        </div>

                    </div>
                </div>

        </section>
        
    </body>
</html>
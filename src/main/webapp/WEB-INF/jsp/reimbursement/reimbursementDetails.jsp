<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>报销详情</title>

<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<script src="${APP_PATH}/static/js/echarts.js"></script>
<script src="${APP_PATH}/static/js/shine.js"></script>

<script type="text/javascript">
function callbackFn(myChart,name,jsonURL){ 
	myChart.showLoading();
	$.ajax({
		url :jsonURL,
		data :{
			'name':name,
		},
		type : "GET",
		success : function(result) {
			myChart.hideLoading();
			myChart.setOption({
			   
				xAxis: {
		        	type: 'category',
		            data: ['1','2','3','4','5','6','7','8','9','10','11','12']  
		        },  
		        yAxis: {},  
		        series: [{
	                name: '销量',
	                type: 'bar',
	                data: [5, 20, 36, 10, 10, 20]
	            }]

			});  
		}
	})
}

$(function(){
	var chart = echarts.init(document.getElementById('chart'));
	initReport(chart);
	callbackFn(chart);
})
</script>
</head>

<body class="bg-common charts stickey-menu">
	<section>

		<!-- 页面模版，每页左侧区域固定不变 -->
		<jsp:include page="iniLeftMenu.jsp"></jsp:include>

		<div class="main-content">

			<!-- 页面模版，每页主体部分头部按需更改 -->
			<div class="content-head content-head-section">

				<a href="" class="toggle-btn"> <span
					class="glyphicon glyphicon-th-list"></span>
				</a>

				<form action="" class="serach-form">

					<select class="form-control">
						<option>用户状态</option>
						<option>占个位置</option>
						<option>占个位置</option>
						<option>占个位置</option>
						<option>占个位置</option>
					</select> <input type="text" placeholder="请输入用户名、姓名" value=""
						class="form-control">

					<button type="button" class="btn btn-primary">搜索</button>


					<div class="clearfix"></div>
				</form>


				<jsp:include page="iniUserInfo.jsp"></jsp:include>

				<div class="clearfix"></div>

			</div>

			<!-- 页面模版，按需更改 -->
			<div class="wrapper">

				<div class="om-header">
					<jsp:include page="iniHolidayManagementHref.jsp"></jsp:include>
				</div>
				<div class="row">
					
					<div class="om-wrapper">
						<div class="row">
							<div class="col-sm-12">

								<header class="om-wrapper-header"
									style="font-size: 1.5rem; color: #1691be;">
									<span class="glyphicon glyphicon-stats"
										style="margin-right: 5px;"></span>月度报销数据详情
									
								</header>

								<div class="om-wrpper-body">
								<div class="user-info" style="font-weight: bold;">
										<span>用户名:admin</span>
										<span>月份:1月</span>
									</div>									
									<div id="chart" style="width: 100%; height: 400px;"></div>
								
								</div>

							</div>

						</div>



					</div>

				</div>

			</div>
		</div>
	</section>
	
	<script type="text/javascript">
	function initReport(myChart){  
	    myChart.setOption({
	        tooltip: {
	        	trigger: 'axis'
	        },
	        legend: {  
	            data:['销量']  
	        },
	        toolbox: {
	            show: true,
	            feature: {
	                dataZoom: {
	                    yAxisIndex: 'none'
	                },
	                dataView: {readOnly: false},
	                magicType: {type: ['line', 'bar']},
	                restore: {},
	                saveAsImage: {}
	            }
	        },
	        xAxis: {
	        	type: 'category',
	            data: ['1','2','3','4','5','6','7','8','9','10','11','12']  
	        },  
	        yAxis: {},  
	        series: [{
                name: '销量',
                type: 'bar',
                data: [5, 20, 36, 10, 10, 20]
            }]
	    });  
	}
	</script>
</body>

</html>
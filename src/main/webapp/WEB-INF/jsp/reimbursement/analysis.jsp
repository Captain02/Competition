<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>报销数据分析</title>

<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<script src="${APP_PATH}/static/js/echarts.js"></script>
<script src="${APP_PATH}/static/js/shine.js"></script>
<script type="text/javascript">
function callbackFn(myChart,jsonURL,data){ 
	if (data == undefined) {
		data = 'kong'
	}
		$.ajax({
			url :jsonURL,
			data : "date="+data,
			type : "GET",
			success : function(result) {
				 myChart.setOption({  
                     series: [{  
                         // 根据名字对应到相应的系列  
                         name: '报销金额',  
                         data: result 
                     }]  
                 });  
				 // 设置加载等待隐藏  
                 myChart.hideLoading();
				
			}
		})
}

$(function(){
	$('.select-year').change(function(){
		var showDivId = 'main';
		var myChart = echarts.init(document.getElementById(showDivId));
		var jsonURL = "${APP_PATH}/admin/reimbursement/dataAnalysis";
		var data = $(this).val();
		
		callbackFn(myChart,jsonURL,data);
	})
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
										style="margin-right: 5px;"></span>报销数据统计图
									
									<select class="form-control pull-right select-year" style="width: 250px;">
										<option style="display: none;">选择年份</option>
										<c:forEach items="${years}" var="year">
										<option>${year}</option>
										</c:forEach>
									</select>
									
									
									
								</header>

								<div class="om-wrpper-body">									
									<div id="main" style="width: 100%; height: 400px;"></div>
									<script type="text/javascript">
										// 基于准备好的dom，初始化echarts实例
										var myChart = echarts.init(document.getElementById('main'),'shine');

										echarts.dispose(document.getElementById('main'));
										
										// 初始化echar报表的方法 
										function initReport(myChart){  
											
            								// 显示标题，图例和空的坐标轴  
								            myChart.setOption({
								            	//图表标题
								                title: {  
								                    text: '月度报销金额分析'  
								                },
								                //提示工具
								                tooltip: {
								                	trigger: 'axis'
								                },
								                //图例
								                legend: {  
								                    data:['报销金额']  
								                },
								                //工具栏
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
								                    name: '报销金额',  
								                    type: 'bar',  
								                    data: [],
								                    markPoint: {
								                        data: [
								                            {type: 'max', name: '最大值'},
								                            {type: 'min', name: '最小值'}
								                        ]
								                    },
								                    markLine: {
								                        data: [
								                            {type: 'average', name: '平均值'}
								                        ]
								                    }
								                }]  
								            });  
								        }  
										
										function createTestReport(showDivId,jsonURL){  
								            var myChart = echarts.init(document.getElementById(showDivId));  
								            // 初始化report对象  
								            initReport(myChart);  
								            myChart.showLoading({text: '正在努力的读取数据中...'});  
								            // 调用后台获取json数据  
								            callbackFn(myChart,jsonURL);  
								        }  
									</script>
									
									 <script type="text/javascript">  
								         $(document).ready(function(){
								            var showDivId = 'main';  
								            var jsonURL = "${APP_PATH}/admin/reimbursement/dataAnalysis";  
								            createTestReport(showDivId,jsonURL);  
								        });  
								    </script>  
								</div>

							</div>

						</div>



					</div>

				</div>

			</div>
		</div>
	</section>
</body>

</html>
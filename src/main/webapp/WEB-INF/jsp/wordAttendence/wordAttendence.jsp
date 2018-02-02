<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sh" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>考勤管理</title>

<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<link rel="stylesheet" href="${APP_PATH}/static/css/font-awesome.css">
<script src="${APP_PATH}/static/js/ctrolButton.js"></script>
</head>
<script type="text/javascript">
	var date;
	function add(){
		
	}
</script>

<body class="bg-common">
	<section>

		<!-- 页面模版，每页左侧区域固定不变 -->
		<jsp:include page="iniLeftMenu.jsp"></jsp:include>

		<div class="main-content">

			<!-- 页面模版，每页主体部分头部按需更改 -->
			<div class="content-head content-head-section">

				<a href="" class="toggle-btn"> <span
					class="glyphicon glyphicon-th-list"></span>
				</a>
				<form action="${APP_PATH}/admin/wordAttendence/list" class="serach-form" method="get">
					    <input name="date" value="${date}">
                        <input placeholder="请输入姓名" value="" class="form-control" name="userName" type="text">
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
							<span class="om-title">考勤管理</span> 
							<span class="om-list">
								<a href="">考勤</a>
							</span>
						</h3>
					</div>

					<div class="om-header-right">
						<button id="addButton" type="button" class="btn btn-warning brn-sm"
							onclick="">
							我的考勤
						</button>
						<button id="addButton" type="button" class="btn btn-success"
							onclick="window.location.href='/OA02/admin/user/add'">
							全部员工考勤
						</button>
					
					</div>


					<div class="clearfix"></div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="row">
							<div class="col-md-12">
								<div class="panel">
									<header class="panel-heading">
										考勤
										 <span class="tools pull-right">
											 <select class="form-control" id="ym" style="width: 124px; display: inline;"></select>
										</span>
									</header>
									<div class="panel-body" style="min-height: 186px;" id="print">
										<table
											class="table table-bordered table-striped table-condensed"
											border="1">
											<thead>
												<tr>
													<th>姓名</th>
													<th>日期</th>
													<th>开始时间</th>
													<th>结束时间</th>
													<th>状态</th>
													<th>IP</th>
												</tr>
											</thead>
											<tbody>

												<c:forEach items="${pageInfo.list}" var="WorkAttendenceDisplay">
												<tr>
													<td>${WorkAttendenceDisplay.userName }</td>
													<td>${WorkAttendenceDisplay.startdate }</td>
													<td>${WorkAttendenceDisplay.enddate }</td>
													<td>${WorkAttendenceDisplay.date }</td>
													<td>
														<c:forEach items="${WorkAttendenceDisplay.state}" var="state">
															${state}
														</c:forEach>
													</td>
													<td>${WorkAttendenceDisplay.userIp }</td>
												</tr>
												</c:forEach>

											</tbody>

										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-4">
          <div class="panel">
            <div class="panel-body">
              <div class="blog-post">
                <div class="text-center"> <a href="" id="js-clock" class="btn btn-info">打卡<br>
                  <span></span></a> 
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="panel">
            <div class="panel-body">
              <div class="blog-post">
                <h3>当月小计</h3>
                <ul>
                  <li>出勤天数: ${workAttendenceByMonthStatistics.countNum} 次</li>
                  
                  <li>正常：${workAttendenceByMonthStatistics.normal}次 </li>
                  
                  <li>迟到：${workAttendenceByMonthStatistics.late}次 </li>
                  
                  <li>早退：${workAttendenceByMonthStatistics.leave}次 </li>
                  
                  <li>加班：${workAttendenceByMonthStatistics.overTime}次 </li>
                  
                  <li>旷工：${workAttendenceByMonthStatistics.absenteeism}</li>
                
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
			</div>
	</div>
	</section>
	
<!-- 模态框 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
<div class="modal-dialog" role="document">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <h4 class="modal-title" id="myModalLabel"></h4>
    </div>
    <div class="modal-body">
      
    </div>
    <div class="modal-footer">
    
      <button type="button" class="btn btn-success" data-dismiss="modal" >关闭</button>
     </div>
   </div>
 </div>
</div>

<script type="text/javascript">
	$(function(){
		function getYm(date){
			var html = '';
			date = new Date();
			$('#js-clock').attr('data-now-year',date.getFullYear());
			$('#js-clock').attr('data-now-month',date.getMonth()+1);
			for(var i = 1; i <= parseInt($('#js-clock').attr('data-now-month')); i++){
				html += '<option value="'+$('#js-clock').attr('data-now-year')+'-'+i+'" data-month="'+i+'">'+$('#js-clock').attr('data-now-year')+'年'+i+'月</option>'
			}
			$('#ym').html(html);
			$('#ym option').each(function(){
				if($(this).attr('data-month') ==$('#js-clock').attr('data-now-month')){
					$(this).attr('selected', true);
				}
			})
		}
		//获取服务器响应头的时间
		$.ajax({
			success:function(result,status,xhr){
				var originalDate = new Date(xhr.getResponseHeader('Date'));
				var date = originalDate;
				callbackTime(date);
				getYm(date);
			}
		})
		
		var srv_nowtime;
		function callbackTime(req){
			srv_nowtime = new Date(req).getTime();
			showTime();
			window.setInterval(showTime, 1000);
		}
		function showTime(){
			srv_nowtime+=1000;
			var nowtime = new Date(srv_nowtime);
			$('#js-clock span').text(addZero(nowtime.getHours())+":"+addZero(nowtime.getMinutes())+":"+addZero(nowtime.getSeconds()));
		}
		function addZero(v){
			return parseInt(v)<10 ? '0'+v : v;
		}
		
		
	})
</script>

</body>

</html>
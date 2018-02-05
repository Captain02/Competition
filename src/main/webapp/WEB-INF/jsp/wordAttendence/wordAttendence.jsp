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
<script src="${APP_PATH}/static/js/selectAll.js"></script>

<script src="${APP_PATH}/static/js/echarts.js"></script>
<script src="${APP_PATH}/static/js/shine.js"></script>
</head>
<script type="text/javascript">
$(function(){
	var date = '';
	$('#js-clock').click(function(){
		date = $(this).find('span').html();
		$.ajax({
			url:'${APP_PATH}/admin/wordAttendence/add',
			type:'POST',
			data:{
				'date':date
			},
			success:function(result){
				if (result.code==200) {
					alert("今天已经完成签到");
				}
			}
		}) 
	});
		
	$('.editor-time-btn').each(function(){
		var btn = $(this);
		$(this).click(function(){
			var prevaNode = $(this).parent().prevAll();
			prevaNode.each(function(){
				if($(this).hasClass('hidden')){
					$(this).removeClass('hidden');
				}
				else{
					$(this).addClass('hidden');
				}
			})
			
			if($(this).html() === '编辑'){
				$(this).html('确定');
			}
			else{
				var changeTime = '';
				var whichStandardTime = $(this).attr("data-status");
				var prevaNodeSelect = $(this).parent().prev().find('select');
				prevaNodeSelect.each(function(){
					changeTime += $(this).val();
				})
				//在这里发送ajax请求
				 $.ajax({
					url:'${APP_PATH}/admin/wordAttendence/updateStanderTime',
					data:{
						'changeTime':changeTime,
						'whichStandardTime':whichStandardTime
					},
					type:'POST',
					success:function(result){
						btn.parent().prevAll('div.time-work').find('span.work-time').html(result.extend.changeTime);
					}
				}) 
				$(this).html('编辑');
			}
		});
	})
			
	//当日期改变时发送ajax
	$('#ym').on('change', function(){
		var date = $(this).val();
		var isByMyId = $(this).attr("data-isbymyid")
		var userName = $(this).attr("data-username")
		window.location.href="${APP_PATH}/admin/wordAttendence/list?date="+date+"&isByMyId="+isByMyId+"&userName="+userName;
	});
	
	//选项卡赋默认值
	var defaultDate = window.location.href;
	var x = defaultDate.indexOf('date');
	var y = defaultDate.substring (x+5,x+15);
	$('#ym option').each(function(){
		if($(this).val() === y){
			$(this).attr('selected', true);
		}
	})
	
})

//批量删除
function deleAll(){
	selectAllTips();
	var ids = $('.ids').val();
	$('.yes').click(function(){
	$.ajax({
		url:'${APP_PATH}/admin/wordAttendence/dele',
		type:'POST',
		data:{
			'ids':ids
		},
		success:function(result){
			if (result.code==100) {
				alert("删除成功");
			}
		}
		})  
	});
}

//请求图表数据的ajax
	$.ajax({
		url:,
		type:,
		data:,
		success:function(result)
	    myChart.setOption({
	        series: [{
	            // 根据名字对应到相应的系列
	            name: '销量',
	            data: result.data
	        }]
	    });
	})
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
					    <input type="hidden" name="date" value="${date}">
				<c:if test="${isByMyId==0}">
                        <input placeholder="请输入姓名" value="" class="form-control" name="userName" type="text">
                        <button type="submit" class="btn btn-primary">搜索</button>
      			</c:if>
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
					 <c:if test="${isByMyId==0}">
					  <button id="delButton" type="button" class="btn btn-danger " onclick="deleAll()">
                               <i>-</i>批量删除
                      </button>
					 </c:if>
                      <input type="hidden" value=""  class="ids"/>
						<c:if test="${isByMyId==0}">
						<button id="addButton" type="button" class="btn btn-warning brn-sm"
							onclick="window.location.href='${APP_PATH}/admin/wordAttendence/list?isByMyId=1'">
							我的考勤
						</button>
						</c:if>
						<c:if test="${isByMyId!=0}">
							<button id="addButton" type="button" class="btn btn-success"
								onclick="window.location.href='${APP_PATH}/admin/wordAttendence/list'">
								全部员工考勤
							</button>
						</c:if>
					
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
											 <select class="form-control" id="ym" style="width: 124px; display: inline;" data-isByMyId="${isByMyId}" data-userName="${userName}">
											 <option style="display: none;">选择日期</option>
											 <c:forEach items="${dateList}" var="dates">
											 	<option>${dates}</option>
											 </c:forEach>
											 </select>
										</span>
									</header>
									<div class="panel-body" style="min-height: 186px;" id="print">
										<table
											class="table table-bordered table-striped table-condensed"
											border="1">
											<thead>
												<tr>
												 	<th>
												 		<input type="checkbox" name="selectAll" class="selectAll" id="selectAll">
												 	</th>
													<th>姓名</th>
													<th>开始时间</th>
													<th>结束时间</th>
													<th>日期</th>
													<th>状态</th>
													<th>IP</th>
												</tr>
											</thead>
											<tbody>

												<c:forEach items="${pageInfo.list}" var="WorkAttendenceDisplay">
												<tr>
												 <td>
	                                                   <input type="checkbox" name="selectItem" class="selectItem">
	                                                </td>
													<td>${WorkAttendenceDisplay.userName }<input type="hidden" value="${WorkAttendenceDisplay.id}"></td>
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
										<nav aria-label="..." class="pull-right">
										  <ul class="pagination pagination-sm">
										    <li>
                                                <a href="${APP_PATH}/admin/wordAttendence/list?pn=1&userName=${userName}&isByMyId=${isByMyId}&date=${date}">首页</a>
                                            </li>
                                            <c:if test="${pageInfo.hasPreviousPage}">
                                                <li>
                                                    <a href="${APP_PATH}/admin/wordAttendence/list?pn=${pageInfo.pageNum-1}&userName=${userName}&isByMyId=${isByMyId}&date=${date}" aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                    </a>
                                                </li>
                                            </c:if>
                                            <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                                                <c:if test="${pageNum==pageInfo.pageNum}">
                                                    <li class="active">
                                                        <a href="#">${pageNum}</a>
                                                    </li>
                                                </c:if>
                                                <c:if test="${pageNum!=pageInfo.pageNum}">
                                                    <li>
                                                        <a href="${APP_PATH}/admin/wordAttendence/list?pn=${pageNum}&userName=${userName}&isByMyId=${isByMyId}&date=${date}">${pageNum}</a>
                                                    </li>
                                                </c:if>
                                            </c:forEach>

                                            <c:if test="${pageInfo.hasNextPage }">
                                                <li>
                                                    <a href="${APP_PATH}/admin/wordAttendence/list?pn=${pageInfo.pageNum+1}&userName=${userName}&isByMyId=${isByMyId}&date=${date}" aria-label="Next">
                                                        <span aria-hidden="true">&raquo;</span>
                                                    </a>
                                                </li>
                                            </c:if>

                                            <li>
                                                <a href="${APP_PATH}/admin/wordAttendence/list?pn=${pageInfo.pages}&userName=${userName}&isByMyId=${isByMyId}&date=${date}" aria-label="Next">
                                                    <span aria-hidden="true">末页</span>
                                                </a>
                                            </li>
										    
										  </ul>
									</nav>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-4">
		<c:if test="${isByMyId!=0}">
          <div class="panel">
            <div class="panel-body">
              <div class="blog-post">
                <div class="text-center"> <a  id="js-clock" class="btn btn-info">打卡<br>
                  <span></span></a> 
                </div>
              </div>
            </div>
          </div>
          </c:if>
          
        </div>
        <div class="col-md-4 ">
          <div class="panel">
            <div class="panel-body">
              <div class="blog-post clearfix">
               <div class="col-md-4 month-count">
                <h3>当月小计</h3>
                <ul>
				  <li>出勤天数: ${workAttendenceByMonthStatistics.countDays} 天</li>
					                
                  <li>出勤次数: ${workAttendenceByMonthStatistics.countNum} 次</li>
                  
                  <li>正常：${workAttendenceByMonthStatistics.normal}次 </li>
                  
                  <li>迟到：${workAttendenceByMonthStatistics.late}次 </li>
                  
                  <li>早退：${workAttendenceByMonthStatistics.leave}次 </li>
                  
                  <li>加班：${workAttendenceByMonthStatistics.overTime}次 </li>
                  
                  <li>旷工：${workAttendenceByMonthStatistics.absenteeism}</li>
                  
                  <li>加班：${workAttendenceByMonthStatistics.sumOverTime}</li>
                </ul>
               </div>
               <div class="col-md-8 count-chart">
               		<div class="main" id="main" style="width: 100%; height: 200px; margin-top: 15px;"></div>
               		<script type="text/javascript">
               	
                 // 基于准备好的dom，初始化echarts实例
                 var myChart = echarts.init(document.getElementById('main'));

                 // 指定图表的配置项和数据
                 var option = {
                		    tooltip: {
                		        trigger: 'item',
                		        formatter: "{a} <br/>{b}: {c} ({d}%)"
                		    },
                		    legend: {
                		        orient: 'vertical',
                		        x: 'right',
                		        data:['正常','迟到','早退','加班']
                		    },
                		    series: [
                		        {
                		            name:'出勤次数',
                		            type:'pie',
                		            radius: ['50%', '70%'],
                		            avoidLabelOverlap: false,
                		            label: {
                		                normal: {
                		                    show: false,
                		                    position: 'center'
                		                },
                		                emphasis: {
                		                    show: true,
                		                    textStyle: {
                		                        fontSize: '14',
                		                        fontWeight: 'bold'
                		                    }
                		                }
                		            },
                		            labelLine: {
                		                normal: {
                		                    show: false
                		                }
                		            },
                		            data:[
                		                {value:335, name:'正常'},
                		                {value:310, name:'迟到'},
                		                {value:234, name:'早退'},
                		                {value:135, name:'加班'},
                		            ]
                		        }
                		    ]
                		};
                 // 使用刚指定的配置项和数据显示图表。
                 myChart.setOption(option);
             </script>				
               </div>
              </div>
            </div>
          </div>
        </div>
        
         <div class="col-md-4 pull-right">
          <c:if test="${isByMyId==0}">
          <div class="panel">
            <div class="panel-body">
              <div class="blog-post">
                <h3 class="clearfix label-control">时间编辑</h3>
                <ul class="col-md-12 time-editor">
                
                	<li>
	                	<div class="col-md-4">上班时间</div>
	                	<div class="col-md-8">
	                		
	                		<div class="time-work pull-left">
		                		<span class="work-time ">${dateStandard.latetime}</span>
	                		 </div>

							<div class="col-md-12 select-time hidden">
								<select class="time-select-hour  col-md-4"></select>
								<select class="time-select-minute col-md-4"></select>
								<select class="time-select-second col-md-4 "></select>
							</div>
							
                			<span class="editor-time">
                				<a class="editor-time-btn" data-status="1">编辑</a>
                			</span>
	                	</div>
	                	
	                	<div class="clearfix"></div>
                	</li>
                	<li>
	                	<div class="col-md-4">下班时间</div>
	                	<div class="col-md-8">
	                	
	                		<div class="time-work pull-left">
		                		<span class="work-time">${dateStandard.leavetime}</span>
	                		 </div>

							<div class="col-md-12 select-time hidden">
								<select class="time-select-hour col-md-4"></select>
								<select class="time-select-minute col-md-4"></select>
								<select class="time-select-second col-md-4"></select>
							</div>
							
                			<span class="editor-time">
                				<a class="editor-time-btn" data-status="2">编辑</a>
                			</span>
	                	</div>
	                	
	                	<div class="clearfix"></div>
                	</li>
                	<li>
	                	<div class="col-md-4">加班时间</div>
	                	<div class="col-md-8">
	                	
	                		<div class="time-work pull-left">
		                		<span class="work-time">${dateStandard.overtime}</span>
	                		 </div>
								
							<div class="col-md-12 select-time hidden">
								<select class="time-select-hour  col-md-4"></select>
								<select class="time-select-minute col-md-4"></select>
								<select class="time-select-second col-md-4"></select>
							</div>
							
                			<span class="editor-time">
                				<a class="editor-time-btn" data-status="3">编辑</a>
                			</span>
	                	</div>
	                	
	                	<div class="clearfix"></div>
                	</li>
                
                </ul>
              </div>
            </div>
            
          </div>
            </c:if>
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
     	<button type="button" class="btn btn-warning yes">确认</button>
        <button type="button" class="btn btn-success no" data-dismiss="modal">取消</button>
     </div>
   </div>
 </div>
</div>

<script type="text/javascript">
	$(function(){
		function getYm(date){
			var html = '';
			date = new Date();
			$('#js-clock').attr('data-now-year-month-date',date.getFullYear()+'-'+addZero(date.getMonth()+1)+'-'+addZero(date.getDate()));
		}
		
		//获取服务器响应头的时间
		$.ajax({
			success:function(result,status,xhr){
				var originalDate = new Date(xhr.getResponseHeader('Date'));
				var date = originalDate;
				callbackTime(date);
				getYm(date);
			}
		});
		
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
		
		var time1 = '';
	    for(var i = 0; i<=24;i++){
	    	time1 +='<option>'+addZero(i)+':</option>'
	    }
		$('.time-select-hour').html(time1);
		
		var time2 = '';
		for(var i = 0; i<=59; i++){
			time2 +='<option>'+addZero(i)+':</option>'
		}
		$('.time-select-minute').html(time2);
		
		var time3='';
		for(var i = 0; i<=59; i++){
			time3 +='<option>'+addZero(i)+'</option>'
		}
		$('.time-select-second').html(time3);
		
	
	})
</script>

</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>我的任务</title>

<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>

<script src="${APP_PATH}/static/js/ctrolButton.js"></script>
<script type="text/javascript">
	$(function () {
		ShowEle('.yes', 'hide');
		$('.btn-assign').click(function () {
			$('#myModal').modal('show');
			var btnAssignPreviousSbiling = $(this).prev().attr('value');
			console.log(btnAssignPreviousSbiling);
			$('#assignHolidayProcessinstanceid').val(btnAssignPreviousSbiling);
		});

		var locationHref = location.href.split('herfPage=');
		var thisPagelocationHref = locationHref[1];
		var toolsA = $('.tools > a');
		$(toolsA[thisPagelocationHref]).addClass('active');
		$(toolsA[thisPagelocationHref]).siblings().removeClass('active');
	});

	function assignTask(object) {
		var assignHolidayProcessinstanceid = $(
			"#assignHolidayProcessinstanceid").val();
		var assignUsername = $(object).prev().val();
		$.ajax({
			url: "${APP_PATH}/admin/myTask/assignTask",
			type: "POST",
			data: "assignHolidayProcessinstanceid=" +
				assignHolidayProcessinstanceid + "&assignUsername=" +
				assignUsername,
			success: function (result) {
				if (result.code == 100) {
					$('#myModal').modal('show');
					ShowTips('.modal-title', '执行结果', '.modal-body',
						'<b style = "color:#5cb85c;">指派成功</b>');
					ShowEle('.yes', 'show');
				}
			}
		})
	}
</script>
</head>

<body>

	<body class="bg-common">

		<section>

			<!-- 页面模版，每页左侧区域固定不变 -->
		<jsp:include page="iniLeftMenu.jsp"></jsp:include>


		<div class="main-content">

			<!-- 页面模版，每页主体部分头部按需更改 -->
			<div class="content-head content-head-section">

				<a href="" class="toggle-btn">
					<span class="glyphicon glyphicon-th-list"></span>
				</a>

				<form action="${APP_PATH}/admin/myReimbursementTask/myReimbursementTask" class="serach-form" method="get">

					<input type="text" name="type" class="form-control" value="" placeholder="输入报销类型"/>
					<select class="form-control" name="state">
						<option>状态</option>
						<option>通过</option>
						<option>未通过</option>
						<option>审核中</option>
					</select>
					<input type="hidden" value="${herfPage}" name="herfPage" />
					<button type="submit" class="btn btn-primary">搜索</button>
					<div class="clearfix"></div>
				</form>
				<jsp:include page="iniUserInfo.jsp"></jsp:include>

				<div class="clearfix"></div>

			</div>

			<!-- 页面模版，按需更改 -->
			<div class="wrapper">

				<div class="om-header" style="margin-bottom: 15px;">
						<jsp:include page="iniMyApprovalManagement.jsp"></jsp:include>
				        <div class="clearfix "></div>
				</div>

				<div class="om-wrapper">
					<div class="row">
						<div class="col-sm-12">

							<header class="om-wrapper-header">
								任务 / 总数：${pageInfo.total}
								<span class="tools pull-right">
									<a href="${APP_PATH}/admin/myReimbursementTask/myReimbursementTask?herfPage=0" class="btn btn-default active">指派给我</a>
									<a href="${APP_PATH}/admin/myReimbursementTask/myReimbursementTask?herfPage=1" class="btn btn-default">由我创建</a>
									<a href="${APP_PATH}/admin/myReimbursementTask/myReimbursementTask?herfPage=2" class="btn btn-default">由我解决</a>
									<a href="${APP_PATH}/admin/myReimbursementTask/myReimbursementTask?herfPage=3" class="btn btn-default">由我完成</a>
								</span>
							</header>

							<div class="om-wrpper-body">
								<form action="" id="user-list" class="user-list">
									<table class="table table-bordered table-striped">

										<thead>
											<tr>
												<th>类型</th>
												<th>状态</th>
												<th>金额</th>
												<th>报销日期</th>
												<c:if test="${herfPage==2}">
													<th>到达时间</th>
												</c:if>
												<c:if test="${herfPage==2||herfPage==3}">
													<th>审批时间</th>
												</c:if>
												<th>操作</th>
											</tr>
										</thead>

										<tbody>
											<c:forEach items="${pageInfo.list}" var="reimbursement">
												<tr>
													<td>${reimbursement.type}</td>
													<td>${reimbursement.test}</td>
													<td>${reimbursement.money}</td>
													<td>${reimbursement.date}</td>
													<c:if test="${herfPage==2}">
														<td>
															<fmt:formatDate value="${reimbursement.startExaminationTime}" pattern="yyyy-mm-dd hh:dd:ss" />
														</td>
													</c:if>
													<c:if test="${herfPage==2||herfPage==3}">
														<td>
															<fmt:formatDate value="${reimbursement.examinationTime}" pattern="yyyy-mm-dd hh:dd:ss" />
														</td>
													</c:if>
													<td>
													<c:if test="${herfPage==0}">
														<a href="${APP_PATH}/admin/myReimbursementTask/examinationPage/${reimbursement.id}/${pageInfo.pageNum}" class="btn btn-success btn-info btn-xs" title="完成">
															<i class="glyphicon glyphicon-ok-sign "></i>
														</a>
													</c:if>
													<a href="${APP_PATH}/admin/reimbursement/reimbursementNote/${reimbursement.id}" class="btn btn-danger btn-xs" title="查看">
															<i class="glyphicon glyphicon-eye-open "></i>
													</a>
													</td>
												</tr>
											</c:forEach>
											
										</tbody>

									</table>
								</form>
							</div>

						</div>

					</div>

					<!-- 分页 -->
					<div class="page-area ">
						<div class="container page-possiton ">

							<nav aria-label="Page navigation">
								<ul class="pagination pagination-control">
									<li>
										<a href="${APP_PATH}/admin/myTask/myHolidayTask?pn=1&type=${type}&state=${state}&herfPage=${herfPage}">首页</a>
									</li>
									<c:if test="${pageInfo.hasPreviousPage}">
										<li>
											<a href="${APP_PATH}/admin/myTask/myHolidayTask?pn=${pageInfo.pageNum-1}&type=${type}&state=${state}&herfPage=${herfPage}"
											    aria-label="Previous">
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
												<a href="${APP_PATH}/admin/myTask/myHolidayTask?pn=${pageNum}&type=${type}&state=${state}&herfPage=${herfPage}">${pageNum}</a>
											</li>
										</c:if>
									</c:forEach>

									<c:if test="${pageInfo.hasNextPage }">
										<li>
											<a href="${APP_PATH}/admin/myTask/myHolidayTask?pn=${pageInfo.pageNum+1}&type=${type}&state=${state}&herfPage=${herfPage}"
											    aria-label="Next">
												<span aria-hidden="true">&raquo;</span>
											</a>
										</li>
									</c:if>

									<li>
										<a href="${APP_PATH}/admin/myTask/myHolidayTask?pn=${pageInfo.pages}&type=${type}&state=${state}&herfPage=${herfPage}" aria-label="Next">
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

	</section>




	<!-- 模态框  指派-->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">任务指派给？</h4>
				</div>
				<div class="modal-body">
					<table class="table table-bordered table-hover text-center">
						<thead>
							<tr>
								<th>用户名</th>
								<th>姓名</th>
								<th>部门</th>
								<th>职位</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${userlist}" var="user">
								<tr>
									<td>${user.username}</td>
									<td>${user.name}</td>
									<td style="width:20%;">${user.department.name}</td>
									<td style="width:20%;">${user.role.name}</td>
									<td>
										<!-- hidden 1 -->
										<input id="assignHolidayProcessinstanceid" type="hidden" value="">
										<input id="assignUsername" type="hidden" value="${user.username}">
										<button class="btn btn-defalut btn-success btn-sm" onclick="assignTask(this)">
											<span class="glyphicon glyphicon-hand-right" style="margin-right: 10px;"></span>指派
										</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<div class="modal-footer">
				<form action="${APP_PATH}/admin/myTask/myHolidayTask" method="get">
					<input type="hidden" value="${state}" name="state">
					<input type="hidden" value="${pageInfo.pageNum}" name="pn">
					<input type="hidden" value="${type}" name="type">
					<input type="hidden" value="${herfPage}" name="herfPage">
					<button type="submit" class="btn btn-success yes">确认</button>
				</form>
				</div>
			</div>
		</div>
	</div>
</body>

</html>
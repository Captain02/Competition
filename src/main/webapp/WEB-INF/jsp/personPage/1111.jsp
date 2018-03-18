<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	
						<!-- 我的项目 -->
						<div class="row">
							<div class="col-md-12">
								<div class="panel">
									<div class="panel-body">
										<div class="person-desk">
											<h1>
												项目 <a href="${APP_PATH}/admin/project/list" style="font-size: 16px; color: #65CEA7;"
													class="pull-right">更多</a>
											</h1>
											<table
												class="table table-bordered table-striped table-condensed cf">
												<thead class="cf">
													<tr>
														<th>项目名称</th>
														<th>结束日期</th>
														<th>状态</th>
														<th>项目负责人</th>
													</tr>
												</thead>
												<tbody>
												<c:forEach items="${ProjectDisplay}" var="projectDisplay">
													<tr>
														<td class="project-name">
															<a href="">${projectDisplay.projectName}</a>
														</td>
														<td>${projectDisplay.endDate}</td>
														<td>${projectDisplay.state}</td>
														<td class="project-name">
															<a href="">${projectDisplay.projectResponsiblePeople}</a>
														</td>
													</tr>
												</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>


						<div class="row">
							<div class="col-md-12">
								<div class="panel">
									<div class="panel-body">
										<div class="person-desk">
											<h1>
												任务 <a href="${APP_PATH}/admin/dusty/list" style="font-size: 16px; color: #65CEA7;"
													class="pull-right">更多</a>
											</h1>
											<table
												class="table table-bordered table-striped table-condensed cf project">
												<thead class="cf">
													<tr>
														<th>任务名称</th>
														<th>结束日期</th>
														<th>状态</th>
														<th>预计工时</th>
													</tr>
												</thead>
												<tbody>
												<c:forEach items="${DustyDisplay}" var="dustyDisplay">
													<tr>
														<td class="project-name">
															<a href="">${dustyDisplay.taskName}</a>
														</td>
														<td>${dustyDisplay.endTime}</td>
														<td>${dustyDisplay.state}</td>
														<td>${dustyDisplay.workTime}</td>
													</tr>
												</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						
						<div class="row">
							<div class="col-md-12">
								<div class="panel">
									<div class="panel-body">
										<div class="person-desk">
											<h1>
												BUG <a href="${APP_PATH}/admin/bug/list" style="font-size: 16px; color: #65CEA7;"
													class="pull-right">更多</a>
											</h1>
											<table
												class="table table-bordered table-striped table-condensed cf">
												<thead class="cf">
													<tr>
														<th>Bug标题</th>
														<th>创建日期</th>
														<th>状态</th>
														<th>创建人</th>
													</tr>
												</thead>
												<tbody>
												<c:forEach items="${BugDisplay}" var="bugDisplay">
													<tr>
														<td class="project-name">
															<a href="">${bugDisplay.bugTitle}</a>
														</td>
														<td>${bugDisplay.creatTime}</td>
														<td>${bugDisplay.state}</td>
														<td>${bugDisplay.creatPeople}</td>
													</tr>
												</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>

</body>
</html>
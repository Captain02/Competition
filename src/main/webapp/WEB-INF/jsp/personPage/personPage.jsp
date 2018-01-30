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
<title>个人主页</title>

<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<link rel="stylesheet" href="${APP_PATH}/static/css/font-awesome.css">
<script src="${APP_PATH}/static/js/ctrolButton.js"></script>

</head>

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



				<jsp:include page="iniUserInfo.jsp"></jsp:include>

				<div class="clearfix"></div>

			</div>

			<!-- 页面模版，按需更改 -->
			<div class="wrapper">

				<div class="row person-area">

					<!-- 左侧 -->
					<div class="col-md-4">
						<div class="row person-area">

							<!-- 头像显示区 -->
							<div class="col-md-12">
								<div class="panel">
									<div class="panel-body">
										<div class="profile-pic text-center">
										<img src="${APP_PATH}/personHeadFile/<sh:principal property="headFile" />" alt="" />
										</div>
									</div>
								</div>
							</div>

							<!-- 个人信息显示区 -->
							<div class="col-md-12">
								<div class="panel">
									<div class="panel-body">
										<ul class="p-info">
											<li>
											<div class="title">姓名</div>
											<div class="desk">${user.name}</div>
											</li>
											<li>
											<div class="title">性别</div>
											<div class="desk">${user.sex}</div>
											</li>
											<li>
											<div class="title">电话</div>
											<div class="desk">${user.phone}</div>
											</li>
											<li>
											<div class="title">部门</div>
											<div class="desk">${user.department.name}</div>
											</li>
											<li>
											<div class="title">职称</div>
											<div class="desk">${user.role.name}</div>
											</li>
											<li>
											<div class="title">QQ</div>
											<div class="desk">${user.qq}</div>
											</li>
										</ul>
									</div>
								</div>
							</div>


							<div class="col-md-12">
								<div class="panel">
									<div class="panel-body">
										<h4>公告</h4>
										 <ul class="dropdown-list">
										 <!-- li标签从数据库中遍历生成 -->
										<c:forEach items="${Notices}" var="Notice">
										 	<li class="new">
										 		<a href="">
										 			<span class="label label-danger">
										 				<i class="fa fa-bolt"></i>
										 			</span>
										 			<!-- 公告名称 -->
										 			<span class="name">${Notice.title} </span>
										 			<!-- 发布时间 -->
										 			<em class="small">${Notice.date}</em>
										 		</a>
										 	</li>
										</c:forEach>
										 </ul>
									</div>
								</div>
							</div>
							<div class="col-md-12">日历区域</div>
						</div>
					</div>

					<!-- 右侧 -->
					<div class="col-md-8">

						<!-- 我的项目 -->
						<div class="row">
							<div class="col-md-12">
								<div class="panel">
									<div class="panel-body">
										<div class="person-desk">
											<h1>
												项目 <a href="" style="font-size: 16px; color: #65CEA7;"
													class="pull-right">更多</a>
											</h1>
											<table
												class="table table-bordered table-striped table-condensed cf">
												<thead class="cf">
													<tr>
														<th>项目名称</th>
														<th>结束日期</th>
														<th class="numeric">状态</th>
														<th class="numeric">项目负责人</th>
													</tr>
												</thead>
												<tbody>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- 我的任务 -->
						<div class="row">
							<div class="col-md-12">
								<div class="panel">
									<div class="panel-body">
										<div class="person-desk">
											<h1>
												我的审批
											</h1>
											<table
												class="table table-bordered table-striped table-condensed cf text-center"  style="margin-bottom: 0px;" >
												<thead class="cf">
													<tr>
														<td><a href="${APP_PATH}/admin/myHolidayTask/myHolidayTask">请假</a></td>
														<td><a href="${APP_PATH}/admin/myReimbursementTask/myReimbursementTask">报销</a></td>
														<td><a href="${APP_PATH}/admin/myThingsTask/myThingsTask">物品</a></td>
													</tr>
												</thead>
												<tbody>
												</tbody>
											</table>
	
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<div class="row">
							<div class="col-md-12">BUG</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="panel">
				                <header class="panel-heading"> 知识 <span class="pull-right"> <a href="/knowledge/manage?filter=me">更多</a></span> </header>
				                <div class="panel-body">
				                	<ul class="activity-list">
											<!--此处li标签应遍历生成 -->
												<li>
													<div class="person-img">
														<a href="">	
															<!--此处放头像 -->
															<img src="/OA02/personHeadFile/140.png" alt="">
														</a>
													</div>
													<div class="activity-desk">
														<h5 class="">
															<!--此处放用户名 -->
															<a href="" class="user-name">超级管理员</a>
															<span class="activity-title">
																<!--此处放知识标题 -->
																<a href="/OA02/admin/KnowledgeSharing/detailedTopic?topicId=24">更新版</a>
															</span>
															<!--此处是知识所属标签-->
															<p class="pull-right activity-order">
																标签：
															    <span></span>
															</p>
														</h5>
														
														<!--此处放知识描述-->
														<p class="text-muted">aaaa</p>
														
														<!--此处放知识操作-->
														<p class="pull-right text-muted">
															
															<input value="24" type="hidden">
															<i class="fa fa-thumbs-o-up"></i>
															<!-- 点赞数量 -->
															<span>1</span>
															<i class="fa fa-heart-o"></i>
															<!-- 收藏数量 -->
															<span>1</span>
															<i class="fa fa-comment-o"></i>
															<!-- 评论数量 -->
															<span>1</span>
															<span class="activity-time">2018-01-29 22:57:38.0</span>
														</p>
													</div>
												</li>
											
										</ul>
				                </div>
				              </div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">相册</div>
						</div>
					</div>

				</div>

			</div>
		</div>
	</section>
</body>

</html>
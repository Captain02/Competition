<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>知识分享</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<link rel="stylesheet" href="${APP_PATH}/static/css/font-awesome.css">
</head>

<body class="bg-common">
	<section>
		<!-- 页面模版，每页左侧区域固定不变 -->
		<jsp:include page="iniLeftMenu.jsp"></jsp:include>
		<div class="main-content">
			<!-- 页面模版，每页主体部分头部按需更改 -->
			<div class="content-head content-head-section">
				<a href="" class="toggle-btn"> <span
					class="glyphicon Sglyphicon-th-list"></span>
				</a>
				<jsp:include page="iniUserInfo.jsp"></jsp:include>
				<div class="clearfix"></div>

			</div>
			<div class="wrapper">
				<div class="om-header">
					<div class="om-header-left">
						<h3>
							<span class="om-title">知识分享</span> <span class="om-list"></span>
						</h3>
					</div>

					<div class="om-header-right">
						<a href="" class="btn btn-warning btn-sm">我的知识</a>
						<a href="" class="btn btn-success btn-sm">全部知识</a> 
						<a href="" class="btn btn-success btn-sm">+分享知识</a>
					</div>


					<div class="clearfix"></div>
				</div>
				
				<div class="row">
					<div class="col-md-8">
						<div class="row">
							<div class="col-md-12">
								<div class="panel">
									<div class="panel-heading">精彩分享</div>
									<div class="panel-body">
										<ul class="activity-list">
											<!--此处li标签应遍历生成 -->
											<c:forEach items="${pageInfo.list}" var="bbsDisplayTopic">
												<li>
													<div class="person-img">
														<a href="">	
															<!--此处放头像 -->
															<img src="${APP_PATH}/personHeadFile/${bbsDisplayTopic.userHeadFile}" alt="" />
														</a>
													</div>
													<div class="activity-desk">
														<h5 class="">
															<!--此处放用户名 -->
															<a href="" class="user-name">${bbsDisplayTopic.userName}</a>
															<span class="activity-title">
																<!--此处放动态标题 -->
																<a href="${APP_PATH}/admin/KnowledgeSharing/detailedTopic/${bbsDisplayTopic.id}">${bbsDisplayTopic.title}</a>
															</span>
														</h5>
														
														<!--此处放动态描述-->
														<p class="text-muted">${bbsDisplayTopic.sketch}</p>
														
														<!--此处放动态操作-->
														<p class="pull-right text-muted">
															<a href="" title="修改" class="my-control"><i class="glyphicon glyphicon-edit"></i></a>
															<a href="" title="删除" class="my-control"><i class="glyphicon glyphicon-trash"></i></a>
															<i class="glyphicon glyphicon-thumbs-up"></i>${bbsDisplayTopic.like}
															<i class=" glyphicon glyphicon-heart"></i>${bbsDisplayTopic.collection}
															<i class="glyphicon glyphicon-comment"></i>${bbsDisplayTopic.comment}
															<span class="activity-time">${bbsDisplayTopic.date}</span>
														</p>
													</div>
												</li>
											</c:forEach>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="panel">
							<div class="panel-body">
								<div class="blog-post">
									<h3>分类</h3>
								<ul>
                  
				                  <li> <a href="">企业文化</a> </li>
				                  
				                  <li> <a href="">管理知识</a> </li>
				                  
				                  <li> <a href="">财务知识</a> </li>
				                  
				                  <li> <a href="">技术分享</a> </li>
				                  
				                  <li> <a href="">服务器</a> </li>
				                  
				                  <li> <a href="">市场营销</a> </li>
				                  
				                  <li> <a href="">运营</a> </li>
				                  
				                  <li> <a href="">随笔</a> </li>
                  
                				</ul>
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
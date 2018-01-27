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
				<a href="" class="toggle-btn"> <span class="glyphicon glyphicon-th-list"></span></a>
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
						<a href="${APP_PATH}/admin/KnowledgeSharing/list?isByMyId=1" class="btn btn-warning btn-sm">我的知识</a>
						<a href="${APP_PATH}/admin/KnowledgeSharing/list" class="btn btn-success btn-sm">全部知识</a> 
						<a href="${APP_PATH}/admin/KnowledgeSharing/add" class="btn btn-success btn-sm">+分享知识</a>
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
																<!--此处放知识标题 -->
																<a href="${APP_PATH}/admin/KnowledgeSharing/detailedTopic?topicId=${bbsDisplayTopic.id}">${bbsDisplayTopic.title}</a>
															</span>
															<!--此处是知识所属标签-->
															<p class="pull-right activity-order">
																标签：
															    <span>
															    	<c:forEach items="${bbsDisplayTopic.labelName}" var="labelName">
															    		${labelName}、
															    	</c:forEach>
																</span>
															</p>
														</h5>
														
														<!--此处放知识描述-->
														<p class="text-muted">${bbsDisplayTopic.sketch}</p>
														
														<!--此处放知识操作-->
														<p class="pull-right text-muted">
															<c:if test="${isByMyId!=0}">
																<a href="" title="修改" class="my-control"><i class="glyphicon glyphicon-edit"></i></a>
																<a href="" title="删除" class="my-control"><i class="glyphicon glyphicon-trash"></i></a>
															</c:if>
															<input type="hidden" value="${bbsDisplayTopic.id}">
															<i class="fa fa-thumbs-o-up"></i>${bbsDisplayTopic.like}
															<i class="fa fa-heart-o"></i>${bbsDisplayTopic.collection}
															<i class="fa fa-comment-o"></i>${bbsDisplayTopic.comment}
															<span class="activity-time">${bbsDisplayTopic.date}</span>
														</p>
													</div>
												</li>
											</c:forEach>
										</ul>
										<!-- 分页 -->
										<div class="page-nav pull-right">
											<nav aria-label="Page navigation">
											  <ul class="pagination">
											    <li>
													<a href="${APP_PATH}/admin/KnowledgeSharing/list?pn=1&isByMyId=${isByMyId}&labelId=${labelId}">首页</a>
												</li>
											<c:if test="${pageInfo.hasPreviousPage}">
												<li>
													<a href="${APP_PATH}/admin/KnowledgeSharing/list?pn=${pageInfo.pageNum-1}&isByMyId=${isByMyId}&labelId=${labelId}"
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
														<a href="${APP_PATH}/admin/KnowledgeSharing/list?pn=${pageNum}&isByMyId=${isByMyId}&labelId=${labelId}">${pageNum}</a>
													</li>
												</c:if>
											</c:forEach>
		
											<c:if test="${pageInfo.hasNextPage }">
												<li>
													<a href="${APP_PATH}/admin/KnowledgeSharing/list?pn=${pageInfo.pageNum+1}&isByMyId=${isByMyId}&labelId=${labelId}"
													    aria-label="Next">
														<span aria-hidden="true">&raquo;</span>
													</a>
												</li>
											</c:if>
		
											<li>
												<a href="${APP_PATH}/admin/KnowledgeSharing/list?pn=${pageInfo.pages}&isByMyId=${isByMyId}&labelId=${labelId}" aria-label="Next">
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
					</div>
					<div class="col-md-4">
						<div class="panel">
						<div class="panel-heading">分类</div>
							<div class="panel-body">
								<div class="blog-post">
								<ul>
                  					<c:forEach items="${BBSLabel}" var="bbsLabel">
					                	<li> <a href="${APP_PATH}/admin/KnowledgeSharing/list?labelId=${bbsLabel.id}&isByMyId=${isByMyId}">${bbsLabel.name}</a></li>
                  					</c:forEach>
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
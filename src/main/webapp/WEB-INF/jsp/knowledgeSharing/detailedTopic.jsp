<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>详细内容</title>
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
					class="glyphicon glyphicon-th-list"></span>
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

				

					<div class="clearfix"></div>
				</div>
				
			    <div class="row">
                     <!--详细内容 -->
					<div class="row">
						<div class="blog">
							<div class="col-md-12">
								<div class="panel">
									<div class="panel-body">
										<!--显示知识详细内容 -->
										<div class="single-blog">
										
										<a href="" class="btn p-follow-btn"><i class="glyphicon glyphicon-thumbs-up" title="点赞"></i></a>
										<a href="" class="btn p-follow-btn"><i class=" glyphicon glyphicon-heart" title="收藏"></i></a>
										<a href="" class="btn p-follow-btn"><i class="glyphicon glyphicon-comment" title="评论"></i></a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<!--显示评论和回复操作 -->
					<div class="row">
						<div class="col-md-12">
							<div class="panel">
								<header class="panel-heading">精彩点评</header>
								<div class="panel-body">
									<ul class="activity-list">
										<c:forEach items="${bbsDetailedTopic.comments}" var="comments">
										
											<c:if test="${comments.repliesId == 0}">
												<li>
													<div class="person-img">
														<a href="">	
															<!--此处放头像 -->
															<img src="${APP_PATH}/personHeadFile/${comments.repliesUserHeadFile}" alt="" />
														</a>
													</div>
													
													<div class="activity-desk">
															<h5 class="">
																<!--此处放评论者用户名 -->
																<a href="" class="user-name">${comments.repliesUserName}</a>
																<span class="activity-title">
																	<!--此处放评论内容 -->
																	<span>${comments.text}</span>
																</span>
															</h5>
															
															<!--此处放评论时间-->
															<p class="text-muted">
															${comments.date}
															<!-- 回复按钮 -->
															<span><a href="" class="answer">回复</a></span>
															</p>
														</div>
													</li>
											</c:if>
											
											<c:if test="${comments.repliesId != 0}">
												<li>
													<div class="person-img">
														<a href="">	
															<!--此处放头像 -->
															<img src="${APP_PATH}/personHeadFile/${comments.repliesUserHeadFile}" alt="" />
														</a>
													</div>
													
													<div class="activity-desk">
															<h5 class="">
																<!--此处放评论者用户名 -->
																<a href="" class="user-name">${comments.repliesUserName}</a>
																<span class="activity-title">
																	<!--此处放评论内容 -->
																	<span>${comments.text}</span>
																</span>
															</h5>
															
															<!--此处放评论时间-->
															<p class="text-muted">
															${comments.date}
															<!-- 回复按钮 -->
															<span><a href="" class="answer">回复</a></span>
															</p>
														</div>
													</li>
											</c:if>
											
										</c:forEach>
									</ul>
									<form action="" method="post" class="form-horizontal">
										<div class="form-group">
						                    <div class="col-sm-12">
						                      <textarea name="comment" rows="6" class="form-control" placeholder="精彩评论不断……"></textarea>
						                      <br>
						                      <input name="knowid" value="" type="hidden">
						                      <button type="submit" class="btn btn-success pull-right">我来点评</button>
						                    </div>
                  						</div>
									</form>
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
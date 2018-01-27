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
<script type="text/javascript">
function likeTopic() {
	var topicId = $("#topicId").val();
	$.ajax({
		url:'${APP_PATH}/admin/KnowledgeSharing/like',
		data:{
			'topicId':topicId
		},
		type:"POST",
		success:function(result){
			alert(result.code);
		}
	})
}

</script>
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
											
											
											<input id="topicId" type="hidden" value="${bbsDetailedTopic.id}">
											
											
											<!--这里是知识的标题-->
											<h1 class="text-center">
												<a href="">${bbsDetailedTopic.title}</a>
											</h1>
											
											<!--这里是知识的作者姓名和发布时间-->
											<p class="text-center auth-row"> By <a href="">${bbsDetailedTopic.userName}</a> |   ${bbsDetailedTopic.date} </p>
											
											<!--这里是知识正文，使用文本编辑器格式化好的-->
											<div>
												${bbsDetailedTopic.text}
											</div>
											
											
										<a href="" class="btn p-follow-btn" onclick="likeTopic()" title="点赞">
											<i class="fa fa-thumbs-o-up" ></i>
											${bbsDetailedTopic.like}
										</a>
										<a href="" class="btn p-follow-btn" title="收藏">
											<i class="fa fa-heart-o" ></i>
											${bbsDetailedTopic.collection}
										</a>
										<a href="" class="btn p-follow-btn"  title="评论">
											<i class="fa fa-comment-o"></i>
											${bbsDetailedTopic.comment}
										</a>
										
										<!--这里是动态的分类-->
										<p class="pull-right activity-order">
											标签：
										    <span>
										    	<c:forEach items="${bbsDetailedTopic.labelName}" var="labelName">
										    		${labelName}、
										    	</c:forEach>
											</span>
										</p>
										
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
										<c:forEach items="${pageInfo.list}" var="comments">
										
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
															<p class="text-muted pull-right">
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
															<p class="text-muted pull-right">
																${comments.date}
																<!-- 回复按钮 -->
																<span><a class="answer">回复</a></span>
															</p>
														</div>
													</li>
											</c:if>
											
										</c:forEach>
									</ul>
									
									<!--分页-->
								    <div class="page-nav pull-right">
								    	<nav aria-label="Page navigation">
										  <ul class="pagination pagination-sm">
										    <li>
													<a href="${APP_PATH}/admin/KnowledgeSharing/detailedTopic?pn=1&topicId=${bbsDetailedTopic.id}">首页</a>
												</li>
											<c:if test="${pageInfo.hasPreviousPage}">
												<li>
													<a href="${APP_PATH}/admin/KnowledgeSharing/detailedTopic?pn=${pageInfo.pageNum-1}&topicId=${bbsDetailedTopic.id}"
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
														<a href="${APP_PATH}/admin/KnowledgeSharing/detailedTopic?pn=${pageNum}&topicId=${bbsDetailedTopic.id}">${pageNum}</a>
													</li>
												</c:if>
											</c:forEach>
		
											<c:if test="${pageInfo.hasNextPage }">
												<li>
													<a href="${APP_PATH}/admin/KnowledgeSharing/detailedTopic?pn=${pageInfo.pageNum+1}&topicId=${bbsDetailedTopic.id}"
													    aria-label="Next">
														<span aria-hidden="true">&raquo;</span>
													</a>
												</li>
											</c:if>
		
											<li>
												<a href="${APP_PATH}/admin/KnowledgeSharing/detailedTopic?pn=${pageInfo.pages}&topicId=${bbsDetailedTopic.id}" aria-label="Next">
													<span aria-hidden="true">末页</span>
												</a>
											</li>
										  </ul>
  										</nav>
								    </div>
									
									<form action="" method="post" class="form-horizontal">
										<div class="form-group">
						                    <div class="col-sm-12">
						                      <textarea name="comment" rows="6" class="form-control" placeholder="精彩评论不断……"></textarea>
						                      <br>
						                      <input name="knowid" value="" type="hidden">
						                      <button type="submit" class="btn btn-primary pull-right">我来点评</button>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<script src="${APP_PATH}/static/js/ctrolButton.js"></script>


<script src="${APP_PATH}/static/kindeditor/kindeditor-all-min.js"></script>
<script src="${APP_PATH}/static/kindeditor/lang/zh-CN.js"></script>
<script src="${APP_PATH}/static/js/comment-kindeditor-option.js"></script>




<script type="text/javascript">
function likeTopic() {
	var topicId = $("#topicId").val();
	var isLike = $("#isLike").val();
	$.ajax({
		url: '${APP_PATH}/admin/KnowledgeSharing/like',
		data: {
			'topicId': topicId,
			'isLike': isLike
		},
		type: "POST",
		success: function (result) {
			addClassToThumbs(result, '#isLike', '.fa-thumbs-up',
				'.thumbsNum');
		}
	})
}

function collectionTopic() {
	var topicId = $("#topicId").val();
	var isCollection = $("#isCollection").val();
	$.ajax({
		url: '${APP_PATH}/admin/KnowledgeSharing/collection',
		data: {
			'topicId': topicId,
			'isCollection': isCollection
		},
		type: "POST",
		success: function (result) {
			addClassToCollection(result, '#isCollection', '.fa-heart',
				'.collectionNum');
		}
	})
}

var repliesId;
var byRepliesUserId;
var repliescontent;

function replies(ele) {
	var topicId = $("#topicId").val();
	var pn = $("#pn").val();

	repliescontent = $(ele).siblings("textarea[name='editor-container-area']").val();
	
	alert( repliesId + byRepliesUserId + repliescontent);

	$.ajax({
		url: "${APP_PATH}/admin/KnowledgeSharing/addReplies",
		data: {
			'comment': repliescontent,
			'topicId': topicId,
			'repliesId': repliesId,
			'byUserId': byRepliesUserId,
			'pn': pn
		},
		type: "POST",
		success: function (result) {
			//直接刷新页面
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
	<a href="" class="toggle-btn">
		<span class="glyphicon glyphicon-th-list"></span>
	</a>
	<jsp:include page="iniUserInfo.jsp"></jsp:include>
	<div class="clearfix"></div>
</div>
<div class="wrapper">
	<div class="om-header">
		<div class="om-header-left">
			<h3>
				<span class="om-title">知识分享</span>
				<span class="om-list"></span>
			</h3>
		</div>
		<div class="clearfix"></div>
	</div>

	<div class="row">
		<div class="row">
			<div class="blog">
				<div class="col-md-12">
					<div class="panel">
						<div class="panel-body">
							<!--显示知识详细内容 -->
							<div class="single-blog">
								<input id="topicId" type="hidden" value="${bbsDetailedTopic.id}">
								<input id="isCollection" type="hidden" value="${collectionNum}">
								<input id="isLike" type="hidden" value="${likeNum}">
								<!--这里是知识的标题-->
								<h1 class="text-center">
									<a href="">${bbsDetailedTopic.title}</a>
								</h1>

								<!--这里是知识的作者姓名和发布时间-->
								<p class="text-center auth-row">
									By
									<a href="">${bbsDetailedTopic.userName}</a> | ${bbsDetailedTopic.date}
								</p>

								<!--这里是知识正文，使用文本编辑器格式化好的-->
								<div style="margin-bottom: 50px;">${bbsDetailedTopic.text}</div>


								<a class="btn p-follow-btn" onclick="likeTopic()" title="点赞">
									<i class="fa fa-thumbs-up"></i>
									<span class="thumbsNum">${bbsDetailedTopic.like}
									</span>
								</a>
								<a class="btn p-follow-btn" onclick="collectionTopic()" title="收藏">
									<i class="fa fa-heart"></i>
									<span class="collectionNum"> ${bbsDetailedTopic.collection}
									</span>

								</a>
								<a href="" class="btn p-follow-btn" title="评论">
									<i class="fa fa-comment-o"></i> ${bbsDetailedTopic.comment}
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


		<div class="row">
			<div class="col-md-12">
				<div class="panel">
					<header class="panel-heading">精彩点评</header>
					<div class="panel-body">

					
						<c:forEach items="${pageInfo.list}" var="comments">
						   <!-- 一层楼  start -->
							<div class="l-post col-md-12"> 
								<c:if test="${comments.repliesId == 0}">
								    <!-- 回帖人的相关信息 start -->
									<div class="d-author col-md-2">
										<ul class="p-author">
											<li class="author-icon">
												<div class="author-icon-img clearfix">
													<a href="">
														<img src="${APP_PATH}/personHeadFile/${comments.repliesUserHeadFile}" alt="" />
													</a>
												</div>
											</li>
											<li class="author-name">
												<a href="p-author-name">${comments.repliesUserName}
												</a>
											</li>
										</ul>
									</div>
									<!-- 回帖人的相关信息 end -->
								</c:if>
								
								<!-- 对发帖人的回复和对层主的回复 start -->
								<div class="d-author-post-content-main col-md-10">
								    <!-- 对帖主的回复 start -->
									<div class="d-content text-justify">
										${comments.text}
									</div>
									<!-- 对帖主的回复 end -->
									
									<!-- 记录帖主的每一条回复的相关信息 start -->
									<div class="core-reply clearfix">
										<div class="core-reply-tail">
											<div class="p_reply pull-right">
												<input id="repliesId" type="hidden" value="${comments.id}">
												<input id="ByRepliesUserId" type="hidden" value="${comments.repliesUserId}">
												<a class="btn-reply-lz">回复</a>
											</div>
											
											<ul class="p-tail pull-right">
												<li>
													<span class="l-num">1</span>楼</li>
												<li>
													<span>${comments.date}</span>
													
												</li>
											</ul>
										</div>
									</div>
									<!-- 记录帖主的每一条回复的相关信息 end -->
									
									<c:forEach items="${comments.comments}" var="childComments">
										<!-- 对帖主的回复的回复 strat -->
										<div class="core-reply-wrapper">
											<div class="core-reply-content">
												<c:if test="${childComments.repliesId != 0}">
												
													<!-- 记录对帖主的回复的回复的相关信息  strat -->
													<ul class="core-reply-info clearfix">
														<li class="clearfix">
															<a href="" class="core-reply-info-img">
																<img src="${APP_PATH}/personHeadFile/${childComments.repliesUserHeadFile}" alt="" />
															</a>
															<div class="lzl-cnt">
																<a href="" class="lzl-username">${childComments.repliesUserName}</a>
																<span style="margin: 0 5px;">回复</span>	
																<a href="" class="lzl-reply-username">${childComments.userName}</a>:
																<span>${childComments.text}</span>
																<div class="lzl-content_reply">
																	<span class="lzl-time">${childComments.date}</span>
																	
																	<input id="repliesId" type="hidden" value="${comments.id}">
																	<input id="ByRepliesUserId" type="hidden" value="${childComments.repliesUserId}">
																	
																	<a class="btn-reply-lz-reply">回复</a>
																</div>
															</div>
														</li>
													</ul>
												<!-- 记录对帖主的回复的回复的相关信息  end -->
												
												</c:if>
											</div>
										</div>
										<!-- 对帖主的回复的回复 end -->
									</c:forEach>
									<!--回复框 -->
									<div class="lzl-editor-container form-group clearfix">
										<div class="editor-container">
											<textarea name="editor-container-area" class="form-control" placeholder="回复框"></textarea>
											<input type="submit" class="btn btn-primary btn-sm btn-editor-reply pull-right" value="发表" onclick="replies (this);" />
										</div>

									</div>
								</div>
								<!-- 对发帖人的回复和对层主的回复 end -->
								<div class="clearfix"></div>
							</div>
							<!-- 一层楼end -->
						</c:forEach>


						<!--分页-->
						<div class="page-nav pull-right">
							<nav aria-label="Page navigation">
								<ul class="pagination pagination-sm">
									<li>
										<a href="${APP_PATH}/admin/KnowledgeSharing/detailedTopic?pn=1&topicId=${bbsDetailedTopic.id}">首页</a>
									</li>
									<c:if test="${pageInfo.hasPreviousPage}">
										<li>
											<a href="${APP_PATH}/admin/KnowledgeSharing/detailedTopic?pn=${pageInfo.pageNum-1}&topicId=${bbsDetailedTopic.id}" aria-label="Previous">
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
											<a href="${APP_PATH}/admin/KnowledgeSharing/detailedTopic?pn=${pageInfo.pageNum+1}&topicId=${bbsDetailedTopic.id}" aria-label="Next">
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

						<form action="${APP_PATH}/admin/KnowledgeSharing/addReplies " method="post" class="form-horizontal">
							<div class="form-group">
								<div class="col-sm-12">
									<textarea name="comment" rows="6" class="form-control" placeholder="精彩评论不断……"></textarea>
									<br>
									<input id="pn" type="hidden" name="pn" value="${pageInfo.pageNum}" />
									<input type="hidden" name="topicId" value="${bbsDetailedTopic.id}" />
									<input type="hidden" name="byUserId" value="${bbsDetailedTopic.userId}" />
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
<script src="${APP_PATH}/static/js/activity-opreate.js"></script>
<script src="${APP_PATH}/static/js/reply.js"></script>
</body>

</html>
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
pageContext.setAttribute("APP_PATH", request.getContextPath());
 
String path = request.getContextPath();
String basePath = request.getServerName() + ":"
	+ request.getServerPort() + path + "/";
String basePath2 = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<link rel="stylesheet" href="${APP_PATH}/static/css/font-awesome.css">
</head>
<script type="text/javascript">
	function videoTalk(ele) {
		var path = '<%=basePath%>';
		var friendId = $(ele).attr('data-info-userid');
		var userId = $("#userId").val();
		var websocket;
				var data={};
		$.ajax({
			url:"${APP_PATH}/admin/friends/talk",
			data:{
   				'toId':friendId,
   				'text':"http://"+path+"admin/friends/videoTalk/?oid="+userId+""
   			},
			type:"POST",
			success:function(result){
				var fromName=result.extend.fromName;
   				data["fromId"]=result.extend.fromId;
				data["fromName"]=result.extend.fromName;
				data["toId"]=friendId;
				data["text"]="http://"+path+"admin/friends/videoTalk/?oid="+userId+"";
				data["type"]="videoTalk";
				data["user"]=result.extend.user;
					
				if ('WebSocket' in window) {
					// 创建一个Socket实例  ws表示WebSocket协议
					websocket = new WebSocket("ws://" + path + "/ws?uid="+userId);
				} else if ('MozWebSocket' in window) {
					websocket = new MozWebSocket("ws://" + path + "/ws"+userId);
				} else {
					websocket = new SockJS("http://" + path + "/ws/sockjs"+userId);
				}
				websocket.onopen = function(event) {
					console.log("WebSocket:已连接");
					console.log(event);
					send();
				};
				
				websocket.onerror = function(event) {
					console.log("WebSocket:发生错误 ");
					console.log(event);
				};
				 // 监听Socket的关闭
				websocket.onclose = function(event) {
					console.log("WebSocket:已关闭");
					console.log(event);
					linkURL();
				}
			}
		})
		function send() {
			websocket.send(JSON.stringify(data));
			websocket.close();
		}
		function linkURL(){
			window.location.href="${APP_PATH}/admin/friends/videoTalk";
		}
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
										<h4>公告
											<a href="" style="font-size: 16px; color: #65CEA7;" class="pull-right">更多</a>
										</h4>
										 <ul class="dropdown-list">
										 <!-- li标签从数据库中遍历生成 -->
										<c:forEach items="${Notices}" var="Notice">
										 	<li class="new">
										 		<a>
										 			<span class="label label-danger">
										 				<i class="fa fa-bolt"></i>
										 			</span>
										 			<!-- 公告名称 -->
										 			<span class="name">${Notice.title} </span>
										 			<input type="hidden" value="${Notice.text }" class="notice-text">
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
				                <header class="panel-heading"> 知识 <span class="pull-right"> <a href="${APP_PATH}/admin/KnowledgeSharing/list">更多</a></span> </header>
				                <div class="panel-body">
				                	<ul class="activity-list">
											<!--此处li标签应遍历生成 -->
											<c:forEach items="${topics}" var="topic">
												<li>
													<div class="person-img">
														<a href="">	
															<!--此处放头像 -->
															<img src="${APP_PATH}/personHeadFile/${topic.userHeadFile}" alt="">
														</a>
													</div>
													<div class="activity-desk">
														<h5 class="">
															<!--此处放用户名 -->
															<a href="" class="user-name">超级管理员</a>
															<span class="activity-title">
																<!--此处放知识标题 -->
																<a href="${APP_PATH}/admin/KnowledgeSharing/detailedTopic?topicId=${topic.id}">${topic.title}</a>
															</span>
															<!--此处是知识所属标签-->
															<p class="pull-right activity-order">
																标签：
															    <span>
															    	<c:forEach items="${topic.labelName}" var="labelName">
															    		${labelName}、
															    	</c:forEach>
															    </span>
															</p>
														</h5>
														
														<!--此处放知识描述-->
														<p class="text-muted">${topic.sketch}</p>
														
														<!--此处放知识操作-->
														<p class="pull-right text-muted">
															
															<input value="24" type="hidden">
															<i class="fa fa-thumbs-o-up"></i>
															<!-- 点赞数量 -->
															<span>${topic.like}</span>
															<i class="fa fa-heart-o"></i>
															<!-- 收藏数量 -->
															<span>${topic.collection}</span>
															<i class="fa fa-comment-o"></i>
															<!-- 评论数量 -->
															<span>${topic.comment}</span>
															<span class="activity-time">${topic.date}</span>
														</p>
													</div>
												</li>
											</c:forEach>
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
	
		<div class="charts-area" id="chat">
		
		<!-- 操作start -->
	    <div class="col-md-12">
		   <div class="row">
		   	 <ul class="charts-opearte clearfix">
		   	 	<li class="col-md-4 active" title="消息" data-index="0" data-status="0"><span class="fa fa-comment-o" ></span></li>
				<li onclick="myFriends(this);" class="col-md-4" title="联系人" data-index="1" data-status="0"><span class="fa fa-user-o"></span></li>
			</ul>
		   </div>
	    </div>
		 <!-- 操作end -->
		 
		 <!--消息 start -->
		<div class="col-md-12">
			<div class="row">
				<div class="chat-info comment" data-index="0">
				<div class="col-md-12 friends-title">
					<h5>消息</h5>
				</div>
				<div class="col-md-12" style="padding-right: 0px;">
				  <ul class="charts-myfriends-list char-comment"></ul>
				</div>
			</div>
			</div>
		</div>
		 <!-- 消息 end -->
		 
		<!-- 好友start -->
		<div class="col-md-12">
			<div class="row">
				<div class="chat-info friend hidden" data-index="1">
				<div class="col-md-12 friends-title">
					<h5>我的好友</h5>
				</div>
				<div class="col-md-12" style="padding-right: 0px;">
				  <ul class="charts-myfriends-list chart-friends">
				  
				  </ul>
				</div>
			</div>
			</div>
		</div>
		<!-- 好友end -->
		
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
     </div>
   </div>
 </div>
</div>

<!-- 聊天框 -->
<div class="chat-info-show" id="chat-window">
	<div class="chat-content-header">
		<button type="button" class="close btn-close" data-dismiss="chat-info-show" aria-label="Close"><span aria-hidden="true">×</span></button>
		<h4 class="chat-content-title" id="myChatLabel">admin</h4>
	</div>
		
			<div class="chat-dialog col-md-12">
				<div class="row" style="height: 100%;">
					<div class="chat-content col-md-6">
					<div class="chat-content-body">
						<div class="panel-body">
							<ul class="chats cool-chat" style="max-height: 500px;"></ul>
						</div>
					</div>
					<div class="chat-content-footer clearfix">
						<div class="footer-content clearfix">
							<div class="tool-bar clearfix">
								<a class="message-history pull-right">消息记录<span class="caret" style="vertical-align: super;"></span></a>
								<input id="userId" type="hidden" value="<sh:principal property="id" />">
								<a onclick="videoTalk(this);" class="message-video pull-left " title="视频通话"><span class="glyphicon glyphicon-facetime-video"></span></a>
							</div>
							<p class="input-chat-text" contenteditable="true" data-emojiable="true"></p>
							<button class="btn btn-primary btn-sm pull-right btn-send" style="padding: 2px 20px;" onclick="sendMessage(this);">发送</button>
							
						</div>
					</div>
				</div>
				
				<div class="message-histroty-content col-md-6">
					<div class="row" style="height: 100%;">
						<iframe frameborder="0"></iframe>
					</div>
				</div>
			</div>
			
		
		
		</div>
	</div>

<script>
var iframe = $('.message-histroty-content').find('iframe');
//消息记录按钮
$('.message-history').click(function(){
	iframe.attr('src','${APP_PATH}/admin/friends/historyTalk?friendId='+$('.btn-send').attr('data-info-userid')+'');
})//end

</script>

</body>

</html>
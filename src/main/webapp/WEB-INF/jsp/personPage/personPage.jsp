<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sh" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=e	dge">
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
<link rel="stylesheet" href="${APP_PATH}/static/calendar/clndr.css">
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
				data["text"]="视频通话";
				data["answerAddress"]="http://"+path+"admin/friends/videoTalk/?oid="+userId+"";
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
// 					showMessageHistoryArea();
// 					showOrHide($(ele));
// 					var pathName = window.document.location.pathname;
// 					var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
// 					//创建视频容器
// 					var iframeMy = $("<iframe frameborder='0' class='my-vtalk' src="+projectName+"/admin/friends/videoTalk>"+
// 							"</iframe>"
// 						   );
// 					$('div.vtalk-view').append(iframeMy);
					
// 					$('div.wait-desc').html('<p class="glyphicon glyphicon-facetime-video" style="display: block; font-size: 60px;"></p>正在等待对方接受邀请<span class="ani_dot">...</span>')
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
<body class="bg-common stickey-menu">
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
											<a href="${APP_PATH}/admin/notice/list" style="font-size: 16px; color: #65CEA7;" class="pull-right">更多</a>
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
							
							<div class="col-md-12">
				              <div class="panel">
				                <div class="panel-body">
				                  <div class="calendar-block ">
				                    <div class="cal1"> </div>
				                  </div>
				                </div>
				              </div>
            			</div>
							
							
							
							
						</div>
					</div>

					<!-- 右侧 -->
					<div class="col-md-8">
					
						<!-- 我的项目 -->
						<div class="row">
							<div class="col-md-12">
								<section class="panel">
								
									<!-- 选项卡切换 -->
									<header class="panel-heading my-approval-tab">
										<ul class="nav nav-tabs">
										  <li role="presentation" class="approval-tab active" data-more-href="${APP_PATH}/admin/dusty/list"><a href="#myDusty" data-toggle="tab">任务</a></li>
										  <li role="presentation" class="approval-tab" data-more-href="${APP_PATH}/admin/bug/list"><a href="#myBug" data-toggle="tab">Bug</a></li>
										  <li role="presentation" class="approval-tab" data-more-href="${APP_PATH}/admin/project/list"><a href="#myProject" data-toggle="tab">项目</a></li>
										  <li class="pull-right my-approval-more"><a href="${APP_PATH}/admin/dusty/list" style="color: #65CEA7;">更多</a></li>
										</ul>
									</header>
									
									<!-- 项目选项卡面板 -->
									<div class="panel-body my-approval-tab-content">
										<div class="tab-content">
											<div class="tab-pane fade in active" id="myDusty">
												<table class="table table-hover table-project">
													<thead>
														<tr>
															<th>级别</th>
															<th>名称</th>
															<th>结束日期</th>
															<th>状态</th>
														</tr>
													</thead>
													
													<tbody>
												<c:forEach items="${DustyDisplay}" var="dustyDisplay">
													<tr>
														<td class="project-grade" data-grade="${dustyDisplay.grade}"><span class="label">${dustyDisplay.grade}</span></td>
														<td class="project-name"><a href="${APP_PATH}/admin/dusty/detailed?id=${dustyDisplay.id}">${dustyDisplay.taskName}</a></td>
														<td>${dustyDisplay.endTime}</td>
														<td>${dustyDisplay.state}</td>
													</tr>
												</c:forEach>
													</tbody>
												</table>
											</div>
											
											<div class="tab-pane fade" id="myBug">
												<table class="table table-hover table-project">
													<thead>
														<tr>
															<th>级别</th>
															<th>Bug标题</th>
															<th>创建日期</th>
															<th>状态</th>
															<th>创建人</th>
														</tr>
													</thead>
													
													<tbody>
														<c:forEach items="${BugDisplay}" var="bugDisplay">
															<tr>
																<td class="project-grade" data-grade="${bugDisplay.grade}"><span class="label">${bugDisplay.grade}</span></td>
																<td class="project-name"><a href="${APP_PATH}/admin/bug/detailed?bugId=${bugDisplay.id}">${bugDisplay.bugTitle}</a></td>
																<td>${bugDisplay.creatTime}</td>
																<td>${bugDisplay.state}</td>
																<td>${bugDisplay.creatPeople}</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
											
											<div class="tab-pane fade" id=myProject>
												<table class="table table-hover table-project">
													<thead>
														<tr>
															<th>项目名称</th>
															<th>结束日期</th>
															<th>状态</th>
															<th>负责人</th>
														</tr>
													</thead>
													
													<tbody>
														<c:forEach items="${ProjectDisplay}" var="projectDisplay">
													<tr>
														<td class="project-name"><a href="${APP_PATH}/admin/project/projectDetails?projectId=${projectDisplay.id}">${projectDisplay.projectName}</a></td>
														<td class="project-name">${projectDisplay.endDate}</td>
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
									
								</section>
							</div>
						</div>
						
						<!-- 我的审批 -->
						<div class="row">
							<div class="col-md-12">
								<section class="panel">
								
									<!-- 选项卡切换 -->
									<header class="panel-heading my-approval-tab">
										<ul class="nav nav-tabs">
										  <li role="presentation" class="approval-tab active" data-more-href="${APP_PATH}/admin/myHolidayTask/myHolidayTask"><a href="#myholiday" data-toggle="tab">请假</a></li>
										  <li role="presentation" class="approval-tab" data-more-href="${APP_PATH}/admin/myReimbursementTask/myReimbursementTask"><a href="#myreimbursement" data-toggle="tab">报销</a></li>
										  <li role="presentation" class="approval-tab" data-more-href="${APP_PATH}/admin/myThingsTask/myThingsTask"><a href="#mything" data-toggle="tab">物品</a></li>
										  <li class="pull-right my-approval-more"><a href="${APP_PATH}/admin/myHolidayTask/myHolidayTask" style="color: #65CEA7;">更多</a></li>
										</ul>
									</header>
									
									<!-- 审批选项卡面板 -->
									<div class="panel-body my-approval-tab-content">
										<div class="tab-content">
											<div class="tab-pane fade in active" id="myholiday">
												<table class="table table-hover">
													<thead>
														<tr>
															<th>类型</th>
															<th>请假日期</th>
															<th>天数</th>
															<th>状态</th>
														</tr>
													</thead>
													
													<tbody>
												<c:forEach items="${holidays}" var="holiday">
													<tr>
														<td>${holiday.type}</td>
														<td>${holiday.date}</td>
														<td>${holiday.holidaydays}</td>
														<td>${holiday.test}</td>
													</tr>
												</c:forEach>
													</tbody>
												</table>
											</div>
											
											<div class="tab-pane fade" id="myreimbursement">
												<table class="table table-hover">
													<thead>
														<tr>
															<th>类型</th>
															<th>金额</th>
															<th>状态</th>
															<th>报销日期</th>
														</tr>
													</thead>
													
													<tbody>
														<c:forEach items="${listReimbursement}" var="Reimbursement">
													<tr>
														<td >${Reimbursement.type}</td>
														<td>${Reimbursement.money}</td>
														<td>${Reimbursement.test}</td>
														<td>${Reimbursement.date}</td>
													</tr>
												</c:forEach>
													</tbody>
												</table>
											</div>
											
											<div class="tab-pane fade" id=mything>
												<table class="table table-hover">
													<thead>
														<tr>
															<th>用途</th>
															<th>物品名称</th>
															<th>申请时间</th>
															<th>状态</th>
														</tr>
													</thead>
													
													<tbody>
														<c:forEach items="${listTings}" var="Tings">
													<tr>
														<td >${Tings.purpose}</td>
														<td>${Tings.name}</td>
														<td>${Tings.date}</td>
														<td>${Tings.state}</td>
													</tr>
												</c:forEach>
													</tbody>
												</table>
											</div>
										</div>
									</div>
									
								</section>
							</div>
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
						
						<!--我的相册 -->
						<div class="row">
							<div class="col-md-12">
								<div class="panel">
							<header class="panel-heading"> 相册 <span class="pull-right"> <a href="${APP_PATH}/admin/image/list">更多</a></span> </header>
								<div class="panel-body">
									<div id="gallery" class="media-gal">
										<c:forEach items="${MyImageDispaly}" var="MyImageDispaly">
										<div class="images item ">
											<a href="${APP_PATH}/myImage/${MyImageDispaly.imageName}" data-lightbox="example-set">
												<img src="${APP_PATH}/myImage/${MyImageDispaly.imageName}" alt="" />
											</a>
											<p class="img-title"><a href="${APP_PATH}/admin/KnowledgeSharing/detailedTopic?topicId=${MyImageDispaly.topicId}">${fn:substring(MyImageDispaly.title,0, 10)}</a> </p>
											<p class="img-desc">${MyImageDispaly.sketch}</p>
											<p>${MyImageDispaly.userName}${fn:substring(MyImageDispaly.date, 0, 10)}上传</p>
										</div>
									</c:forEach>
									</div>
								</div>
							</div>
							</div>
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
<div class="chat-info-show message-hide hidden" id="chat-window">
	<div class="chat-content-header">
		<button type="button" class="close btn-close" data-dismiss="chat-info-show" aria-label="Close"><span aria-hidden="true">×</span></button>
		<h4 class="chat-content-title" id="myChatLabel">admin</h4>
	</div>
		
			<div class="chat-dialog col-md-12">
				<div class="row" style="height: 100%;">
					<div class="chat-content col-md-12">
					<div class="chat-content-body">
						<div class="panel-body">
							<ul class="chats cool-chat" style="max-height: 500px;"></ul>
						</div>
					</div>
					<div class="chat-content-footer clearfix">
						<div class="footer-content clearfix">
							<div class="tool-bar clearfix">
								<a class="message-history pull-right" onselectstart="return false" data-info-type="message-history">消息记录<span class="caret" style="vertical-align: super;"></span></a>
								<input id="userId" type="hidden" value="<sh:principal property="id" />">
								<a onclick="videoTalk(this);" class="message-video pull-left " title="视频通话" data-info-type="wait-answer-vtalk"><span class="glyphicon glyphicon-facetime-video"></span></a>
							</div>
							<p class="input-chat-text" contenteditable="true" data-emojiable="true"></p>
							<button class="btn btn-primary btn-sm pull-right btn-send" style="padding: 2px 20px;" onclick="sendMessage(this);">发送</button>
							
						</div>
					</div>
				</div>
				
				<div class="message-histroty-content col-md-6 hidden">
					<div class="row" style="height: 100%;">
					
						<!--消息历史 -->
						<div class="message-history-show" data-info-type="message-history" style="width: 100%; height: 100%;">
							<iframe frameborder="0" class="message-history-href"></iframe>
						</div>
						
						<!-- 有视频通话邀请 -->
						<div class="video-talk" data-info-type="videoTalk">
							<div style="display:inline-block; position: relative; top: 20%;">
								<a class="user-img"><img src="" alt="" /></a>
								<p style="margin:15px 0;">发起了视频通话</p>
								<p class="clearfix">
									<a class="btn btn-success btn-sm pull-left answer-video" data-info-type="wait-answer-vtalk" data-answer-status="1" onclick="answerVideo(this);"><span class="glyphicon glyphicon-phone-alt" style="margin-right: 10px;"></span>接听</a>
									<a class="btn btn-danger btn-sm pull-right answer-video" data-answer-status="0" onclick="answerVideo(this);"><span class="glyphicon glyphicon-remove-sign" style="margin-right: 10px;"></span>挂断</a>
								</p>
							</div>
						</div>
						
						<!-- 邀请对方接听视频电话 -->
						<div class="wait-answer-vtalk" data-info-type="wait-answer-vtalk">
							<div class="wait-vtalk-lodaing">
								<div style="display: inline-block; position: relative; top: 25%">
									<div class="wait-desc">
										<p class="glyphicon glyphicon-facetime-video" style="display: block; font-size: 60px;"></p>
										等待对方接受邀请<span class="ani_dot">...</span>
									</div>
								</div>
								
								<iframe frameborder="0" class="other-vtalk hidden" style="width: 100%; height: 100%;"></iframe>
								
							</div>
							<div class="vtalk-view">
								
							</div>
						</div>
						
					</div>
				</div>
			</div>
			
		
		
		</div>
	</div>

<script>
var iframe = $('.message-histroty-content').find('iframe.message-history-href');
//消息记录按钮
$('.message-history').click(function(){
	iframe.attr('src','${APP_PATH}/admin/friends/historyTalk?friendId='+$('.btn-send').attr('data-info-userid')+'');
})//end

</script>

<script src="${APP_PATH}/static/calendar/js/clndr.js"></script>
<script src="${APP_PATH}/static/calendar/js/evnt.calendar.init.js"></script>
<script src="${APP_PATH}/static/calendar/js/moment-2.2.1.js"></script>
<script src="${APP_PATH}/static/calendar/js/underscore-min.js"></script>

<script type="text/javascript">
	$(function(){
		var myApprovalTab = $('.my-approval-tab ul li.approval-tab');
		var myApprovalMore = $('.my-approval-tab ul li.my-approval-more a');
		
		myApprovalTab.each(function(){
			$(this).click(function(){
				myApprovalMore.attr('href',$(this).attr('data-more-href'));
			})
		})
	})
</script>

</body>

</html>
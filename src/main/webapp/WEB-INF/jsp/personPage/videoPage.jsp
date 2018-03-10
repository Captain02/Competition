<%@ page language="java" pageEncoding="UTF-8"%><%@ page isELIgnored="false" %><!DOCTYPE HTML>
<html>
	<head>
		<title>WEBRTC视频通话</title>
		<meta charset="utf-8" />
		<meta name="keywords" content="ACGIST的视频应用,webrtc" />
		<meta name="description" content="使用webrtc实现的网页视频通话。" />
<%
      pageContext.setAttribute("APP_PATH", request.getContextPath());
       
String path = request.getContextPath();
String basePath = request.getServerName() + ":"
		+ request.getServerPort() + path + "/";
String basePath2 = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";
%>
   
		<!-- 
			注意：1.本功能暂时只支持google chrome浏览器；
				 2.本功能暂时只支持两人视频聊天；
				 3.由于本功能可以让游客使用，使用session的ID区分不同用户，所以请不要使用同一个浏览器两个窗口之间通话；
				 4.由于宽带有限所以对同事在线通话人数有限制，每天晚上0点将会销毁所有通话，所以该时刻可能出现异常情况。
				 5.注意如果2分钟对方未进入聊天室，将会关闭；
				 5.手机可以使用chrome移动版也可以视频聊天；
				 6.如果你不能访问google，也不能使用本功能；
			以上。
			
			参考文章：http://blog.csdn.net/leecho571/article/details/8146525
		 -->
		
		<!-- <script src="https://talkgadget.google.com/talkgadget/channel.js"></script> -->
		<script src="channel.js"></script>
		<style type="text/css">
		
		</style>
	</head>
	<body ondblclick="fullScreen()">
		<!-- <div class="browser">对不起暂时只支持google chrome浏览器！</div> -->
		<div id="main">
			<video id="localVideo" autoplay="autoplay"></video>
			<video id="remoteVideo" autoplay="autoplay"></video>
			<video id="miniVideo" autoplay="autoplay"></video>
		</div>
		<div id="footer"></div>
		<script type="text/javascript">
			var pc;
			var main; // 视频的DIV
			var errorNotice; // 错误提示DIV
			var socket; // websocket
			var localVideo; // 本地视频
			var miniVideo; // 本地小窗口
			var remoteVideo; // 远程视频
			var localStream; // 本地视频流
			var remoteStream; // 远程视频流
			var localVideoUrl; // 本地视频地址
			var initiator = ${requestScope.initiator }; // 是否已经有人在等待
			
			var started = false; // 是否开始
			var channelReady = false; // 是否打开websocket通道
			
			var channelOpenTime;
			var channelCloseTime;
			
			var PeerConnection = window.RTCPeerConnection || window.mozRTCPeerConnection || window.webkitRTCPeerConnection;
			
			var mediaConstraints = {
				"has_audio" : true,
				"has_video" : true
			}; // 音频和视频
			
			// 初始化
			function initialize() {
				console.log("初始化");
				
				main = document.getElementById("main");
				errorNotice = document.getElementById("errorNotice");
				localVideo = document.getElementById("localVideo");
				miniVideo = document.getElementById("miniVideo");
				remoteVideo = document.getElementById("remoteVideo");
				
				noticeMsg();//初始化
				openChannel();//开启连接
				getUserMedia();
			}
			
			// 获取用户的媒体
			function getUserMedia() {
				console.log("获取用户媒体");
				
				navigator.aa = navigator.getUserMedia ||  
							                navigator.webkitGetUserMedia ||  
							                navigator.mozGetUserMedia ||  
							                navigator.msGetUserMedia;
				
				navigator.aa({
					"audio" : true,
					"video" : true
				}, onUserMediaSuccess, onUserMediaError)
			}
			
			// 获取用户媒体成功
			function onUserMediaSuccess(stream) {
				var url = URL.createObjectURL(stream);
				localVideo.style.display = "inline-block";
				remoteVideo.style.display = "none";
				
				localVideo.src = url;
				localVideoUrl = url;
				localStream = stream;
				
				if (initiator)
					maybeStart();
			}
			
			// 开始连接
			function maybeStart() {
				if (!started && localStream && channelReady) {
					console.log("连接中");
					setNotice("连接中...");
					createPeerConnection();
					pc.addStream(localStream);
					started = true;
					if (initiator)
						doCall();
				}
			}
			
			// 开始通话
			function doCall() {
				console.log("开始呼叫");
				
				pc.createOffer(setLocalAndSendMessage,function (error){
				    console.log('Failure callback: ' + error);
				});
			}
			
			function setLocalAndSendMessage(sessionDescription) {
				pc.setLocalDescription(sessionDescription);
				sendMessage(sessionDescription);
			}
			
			// 发送信息
			function sendMessage(message) {
				var msgJson = JSON.stringify(message);
				
				socket.send(msgJson);
				
				console.log("发送信息 : " + msgJson);
			}
			
			var path = '<%=basePath%>';
			// 打开websocket
			function openChannel() {
				console.log("打开websocket");
				
				socket = new WebSocket("ws://"+path+"acgist.video/${requestScope.uid}");
				
				socket.onopen = onChannelOpened;
				socket.onmessage = onChannelMessage;
				socket.onclose = onChannelClosed;
				socket.onerror = onChannelError();
			}
			
			// 设置状态
			function noticeMsg() {
				if (!initiator) {
					setNotice("让别人加入（注意事项查看源码）: http://"+path+"msg?oid=${requestScope.uid }");
				} else {
					setNotice("初始化...");
				}
			}
			
			// 打开连接
			function createPeerConnection() {
				var server = {"iceServers" : [
					{url:'stun:stun1.l.google.com:19302'},
					{url:'stun:stun2.l.google.com:19302'},
					{url:'stun:stun3.l.google.com:19302'},
					{url:'stun:stun4.l.google.com:19302'},
					{url:'stun:stunserver.org'},
					{url:'stun:stun.softjoys.com'},
					{url:'stun:stun.voiparound.com'},
					{url:'stun:stun.voipbuster.com'},
					{url:'stun:stun.voipstunt.com'},
					{url:'stun:stun.voxgratia.org'},
					{url:'stun:stun.xten.com'},
					{
						url: 'turn:numb.viagenie.ca',
						credential: 'muazkh',
						username: 'webrtc@live.com'
					},
					{
						url: 'turn:192.158.29.39:3478?transport=udp',
						credential: 'JZEOEt2V3Qb0y27GRntt2u2PAYA=',
						username: '28224511:1379330808'
					},
					{
						url: 'turn:192.158.29.39:3478?transport=tcp',
						credential: 'JZEOEt2V3Qb0y27GRntt2u2PAYA=',
						username: '28224511:1379330808'
					}]};
				
				pc = new PeerConnection(server);
				
				pc.onicecandidate = onIceCandidate;
				pc.onconnecting = onSessionConnecting;//开始连接
				pc.onopen = onSessionOpened;//链接打开
				pc.onaddstream = onRemoteStreamAdded;//添加或远程视频
				pc.onremovestream = onRemoteStreamRemoved;//移除远程视频
			}
			
			// 谁知状态
			function setNotice(msg) {
				document.getElementById("footer").innerHTML = msg;
			}
			
			// 响应
			function doAnswer() {
				pc.createAnswer(setLocalAndSendMessage, function (error){
					console.log('Failure callback: ' + error);
				});
			}
			
			// websocket打开
			function onChannelOpened() {
				console.log("websocket打开");
				
				channelOpenTime = new Date();
				channelReady = true;
				if (initiator)
					maybeStart();
			}
			
			// websocket收到消息
			function onChannelMessage(message) {
				console.log("收到信息 : " + message.data);
				
				processSignalingMessage(message.data);//建立视频连接
			}
			
			// 处理消息
			function processSignalingMessage(message) {
				var msg = JSON.parse(message);
				
				if (msg.type === "offer") {
					if (!initiator && !started)
						maybeStart();
					pc.setRemoteDescription(new RTCSessionDescription(msg));
					doAnswer();
				} else if (msg.type === "answer" && started) {
					pc.setRemoteDescription(new RTCSessionDescription(msg));
				} else if (msg.type === "candidate" && started) {
					var candidate = new RTCIceCandidate({
						sdpMLineIndex : msg.label,
						candidate : msg.candidate
					});
					pc.addIceCandidate(candidate);
				} else if (msg.type === "bye" && started) {
					onRemoteClose();
				} else if(msg.type === "nowaiting") {
					onRemoteClose();
					setNotice("对方已离开！");
				}
			}
			
			// websocket异常
			function onChannelError(event) {
				console.log("websocket异常 ： " + event);
				
				//alert("websocket异常");
			}
			
			// websocket关闭
			function onChannelClosed() {
				console.log("websocket关闭");
				
				if(!channelOpenTime){
					channelOpenTime = new Date();
				}
				channelCloseTime = new Date();
				openChannel();
			}
			
			// 获取用户流失败
			function onUserMediaError(error) {
				console.log("获取用户流失败！");
				
				alert("获取用户流失败！");
			}
			
			// 邀请聊天：这个不是很清楚，应该是对方进入聊天室响应函数
			function onIceCandidate(event) {
				if (event.candidate) {
					sendMessage({
						type : "candidate",
						label : event.candidate.sdpMLineIndex,
						id : event.candidate.sdpMid,
						candidate : event.candidate.candidate
					});
				} else {
					console.log("End of candidates.");
				}
			}
			
			// 开始连接
			function onSessionConnecting(message) {
				console.log("开始连接");
			}
			
			// 连接打开
			function onSessionOpened(message) {
				console.log("连接打开");
			}
			
			// 远程视频添加
			function onRemoteStreamAdded(event) {
				console.log("远程视频添加");
				
				var url = URL.createObjectURL(event.stream);
				
				miniVideo.src = localVideo.src;
				remoteVideo.src = url;
				remoteStream = event.stream;
				waitForRemoteVideo();
			}
			
			// 远程视频移除
			function onRemoteStreamRemoved(event) {
				console.log("远程视频移除");
			}
			
			// 远程视频关闭
			function onRemoteClose() {
				started = false;
				initiator = false;
				
				miniVideo.style.display = "none";
				remoteVideo.style.display = "none";
				localVideo.style.display = "inline-block";
				
				main.style.webkitTransform = "rotateX(360deg)";
				
				miniVideo.src = "";
				remoteVideo.src = "";
				localVideo.src = localVideoUrl;
				
				setNotice("对方已断开！");
				
				pc.close();
			}
			
			// 等待远程视频
			function waitForRemoteVideo() {
				if (remoteVideo.currentTime > 0) { // 判断远程视频长度
					transitionToActive();
				} else {
					setTimeout(waitForRemoteVideo, 100);
				}
			}
			
			// 接通远程视频
			function transitionToActive() {
				remoteVideo.style.display = "inline-block";
				localVideo.style.display = "none";
				main.style.webkitTransform = "rotateX(360deg)";
				setTimeout(function() {
					localVideo.src = "";
				}, 500);
				setTimeout(function() {
					miniVideo.style.display = "inline-block";
					//miniVideo.style.display = "none";
				}, 1000);
				
				setNotice("连接成功！");
			}
			
			// 全屏
			function fullScreen() {
				main.webkitRequestFullScreen();
			}
		
			// 关闭窗口退出
			window.onbeforeunload = function() {
				sendMessage({type : "bye"});
				pc.close();
				socket.close();
			}

			// 设置浏览器支持提示信息
			function errorNotice(msg) {
				main.style.display = "none";
				
				errorNotice.style.display = "block";
				errorNotice.innerHTML = msg;
			}
			
			if(!WebSocket) {
			//	errorNotice("你的浏览器不支持WebSocket！建议使用<a href=\"https://www.google.com/intl/zh-CN/chrome/browser/\" target=\"_blank\">google chrome浏览器！</a>");
			} else if(!PeerConnection) {
				//errorNotice("你的浏览器不支持RTCPeerConnection！建议使用<a href=\"https://www.google.com/intl/zh-CN/chrome/browser/\" target=\"_blank\">google chrome浏览器！</a>");
			} else {
				//if(window.navigator.userAgent.indexOf("Chrome") !== -1)
					setTimeout(initialize, 1); // 加载完成调用初始化方法
			}
		</script>
	</body>
</html>

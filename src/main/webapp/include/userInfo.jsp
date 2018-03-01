<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sh" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
      pageContext.setAttribute("APP_PATH", request.getContextPath());
       
String path = request.getContextPath();
String basePath = request.getServerName() + ":"
		+ request.getServerPort() + path + "/";
String basePath2 = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";
%>
            <!-- 此处显示登录所用的用户名以及职位，用include标签包含进来 -->
            <div class="content-head-right">
                <ul class="login-info">
                    <li>
                        <a class="fa fa-envelope-o btn-myinfo dropdown-toggle" title="消息" data-toggle="dropdown"></a>
                        <div class="dropdown-menu dropdown-menu-head pull-right">
                        	<h5 class="title">您有${systemMessagesize}未读消息</h5>
                        	<ul class="dropdown-list normal-list" >
                        		<li class="myinfo">
                        				<c:forEach items="${systemMessage}" var="message">
                        			<a href="${APP_PATH}/admin/KnowledgeSharing/detailedTopic?topicId=${message.topicId}&isCancel=${message.id}">
                        				<span class="myinfo-type">
                        					<img src="${APP_PATH}/personHeadFile/${message.headFile}" alt="" />
                        				</span>
                        				<span class="myinfo-desc">
                        					<span class="myinfo-name">${message.userName}</span>
                        					<span class="myinfo-msg">${message.action}  ${message.text}  ${message.title}</span>
                        				</span>
                        				
                        			</a>
                        				</c:forEach>
                        		</li>
                        		<li>
                        			<a href="${APP_PATH}/admin/systemMessage/list">查看更多</a>
                        		</li>
                        	</ul>
                        </div>
                    </li>
                    
                    
                    
                     <li>
                        <a class="fa fa-comment-o btn-mycomment" title="会话" data-chat-status='true'></a>
                    </li>
                    
                    
                    <li>
                        <a href="#" data-toggle="dropdown">
                        <img alt="" src="${APP_PATH}/personHeadFile/<sh:principal property="headFile" />" class="person-img">
                            <sh:principal property="name"></sh:principal>
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                            <li>
                                <a href="#">个人主页</a>
                            </li>
                            <li role="separator" class="divider"></li>
                             <li>
                                <a href="${APP_PATH}/admin/MyCollection/list">我的收藏</a>
                            </li>
                            <li role="separator" class="divider"></li>
                            <li>
                                <a href="${APP_PATH}/admin/user/changePassword/<sh:principal property="id" />">修改密码</a>
                            </li>
                            <li role="separator" class="divider"></li>
                             <li>
                                <a href="${APP_PATH}/admin/personPage/personHeadPage">更换头像</a>
                            </li>
                            <li role="separator" class="divider"></li>
                            <li>
                                <a href="${APP_PATH}/logout">退出</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
            
            <script type="text/javascript">
                var websocket;
            	function openSocket(){
            		 $.ajax({
            			url:"${APP_PATH}/admin/friends/responseAddFridens",
            			data:"",
            			type:"GET",
            			success:function(result){
            				if (result.code==100) {
            					var path = '<%=basePath%>';
                        		var uid=result.extend.uid;
                        		if ('WebSocket' in window) {
                        			// 创建一个Socket实例  ws表示WebSocket协议
                        			websocket = new WebSocket("ws://" + path + "/ws?uid="+uid);
                        		} else if ('MozWebSocket' in window) {
                        			websocket = new MozWebSocket("ws://" + path + "/ws"+uid);
                        		} else {
                        			websocket = new SockJS("http://" + path + "/ws/sockjs"+uid);
                        		}
                        		websocket.onopen = function(event) {
                        			console.log("WebSocket:已连接");
                        			console.log(event);
                        		};
                        		 // 监听消息
                        		websocket.onmessage = function(event) {
                        			var data=JSON.parse(event.data);
                        			console.log(event.data);
                        			addNewsToList(data);
                        			if($('#chat-window').attr('data-status')==='1' && data.fromId===parseInt($('#chat-window').find('button.btn-send').attr('data-info-userid')) && data.type==='sendTalk'){
                        				addMessageToMessageList(data,'');
                        				$('.char-comment li').each(function(){
                        					if($(this).attr('data-info-userid')=== $('#chat-window').find('button.btn-send').attr('data-info-userid')){
                        						$(this).find('span.label-new-info-num').remove();
                        					}
                        				})
                        				$('.chat-content-body').scrollTop($('.chat-content-body')[0].scrollHeight );
                        			}                                                   
                        			console.log("WebSocket:收到一条消息",data);
                        			
                        		};
                        		websocket.onerror = function(event) {
                        			console.log("WebSocket:发生错误 ");
                        			console.log(event);
                        		};
                        		 // 监听Socket的关闭
                        		websocket.onclose = function(event) {
                        			console.log("WebSocket:已关闭");
                        			console.log(event);
                        		} 
                        			
					 		}
            			}
            		}) 
            		
            	}
            	
            	
            	
            	//关闭会话
            	function close(){
            		websocket.close();
            		console.log('关闭')
            	}
            	
            	//同意好友请求
            	function sure(ele){
            		var toId = $(ele).attr('data-sure-id');
            		$.ajax({
            			url:"${APP_PATH}/admin/friends/agreeAddFriend",
            			data:{
            				'friendId':toId,
            				'isAgree':1
            			},
            			type:"POST",
            			success:function(result){
	    					messageText=result.extend.fromName+"同意添加您为好友。";
	    					type="agreeAddFriend";
	    					user=result.extend.friend;
	    					sendTime="";
	    					sendFunction(result.extend.fromId,result.extend.fromName,toId,messageText,type,user,sendTime);
	    					$('.char-comment li').each(function(){
	    						if( $(this).attr('data-info-userid')===$(ele).attr('data-sure-id') && $(this).attr('data-info-status')===$(ele).attr('data-info-status') ){
	    							$(this).remove();
	    						}
	    					})
	    					
	    					$('#myModal').modal('hide');
	    					
	    					
            			}
            		})
            	}
            	
            	//拒绝好友请求
            	function notSure(ele){
            		var toId = $(ele).attr('data-not-sure-id');
            		$.ajax({
            			url:"${APP_PATH}/admin/friends/agreeAddFriend",
            			data:{
            				'friendId':toId,
			            	'isAgree':0
            			},
            			type:"POST",
            			success:function(result){
							messageText=result.extend.fromName+"不同意添加您为好友。";
							type="agreeAddFriend";
							user=result.extend.friend;
							sendTime="";
							sendFunction(result.extend.fromId,result.extend.fromName,toId,messageText,type,user,sendTime);
							$('.char-comment li').each(function(){
	    						if( $(this).attr('data-info-userid')===$(ele).attr('data-not-sure-id') && $(this).attr('data-info-status')===$(ele).attr('data-info-status') ){
	    							$(this).remove();
	    						}
	    					})
	    					
	    					$('#myModal').modal('hide');
							
            			}
            		})
            	}
            	
            	//遍历好友列表
            	function myFriends(ele){
            		$.ajax({
            			url:"${APP_PATH}/admin/friends/friends",
            			type:"GET",
            			data:"",
            			success:function(result){
            				$('.chart-friends li').remove();
            				addFriendsToList(result);
							console.log(result.extend.friends);
            			}
            			
            		})
            	}
            	
            	//释放请求消息队列
            	function unAgreeAddFriend(toId) {
	           		$.ajax({
	           			url:"${APP_PATH}/admin/friends/unAgreeAddFriend",
	           			data:"",
	           			type:"POST",
	           			success:function(result){
								messageText="";
								type="unAgreeAddFriend";
								user="";
								sendTime="";
								sendFunction(result.extend.fromId,result.extend.fromName,toId,messageText,type,user,sendTime);
	           				}
	           			})
				}
            	//关闭会话框
            	function chatWindowClose(toId){
            		$.ajax({
            			url:"${APP_PATH}/admin/friends/acceptTalk",
            			data:"",
            			type:"POST",
            			success:function(result){
            				var data={};
	           				data["fromId"]=result.extend.fromId;
	    					data["fromName"]=result.extend.fromName;
	    					data["toId"]=toId;
	    					data["text"]="";
	    					data["type"]="acceptTalks";
	    					websocket.send(JSON.stringify(data));
            			}
            		})
            	}
            	
            	//谈话
            	function sendMessage(ele){
            		//获取id
            		var toId = $(ele).attr('data-info-userid');
            		//获取消息内容
            		var messageText = $(ele).siblings('p.input-chat-text').html();
            		$.ajax({
	           			url:"${APP_PATH}/admin/friends/talk",
	           			data:{
	           				'toId':toId,
	           				'text':messageText
	           			},
	           			type:"POST",
	           			success:function(result){
	           				var type = "sendTalk";
		            		sendFunction(result.extend.fromId,result.extend.fromName,toId,messageText,type,result.extend.user,result.extend.sendTime);
		            		$('.chat-content-body').scrollTop($('.chat-content-body')[0].scrollHeight );
	           			}
	           		})
            	}
            	
            	//发送任何消息
            	function sendFunction(fromId,fromName,toId,text,type,user,sendTime){
            		var data={};
            		data["fromId"]=fromId;
					data["fromName"]=fromName;
					data["toId"]=toId;
					data["text"]=text;
					data["type"]=type;
					data["user"]=user;
            		if (type == "sendTalk") {
						data["date"] = sendTime;
						addMessageToMessageList(data,'in-my clearfix');
					}
					websocket.send(JSON.stringify(data));
					console.log("WebSocket发送一条消息",data);
					
            	}
            	
            	//接听/挂断视频电话
            	function answerVideo(ele){
            		//用户的选择：0表示拒绝，1表示同意
            		var answerStatus = $(ele).attr('data-answer-status');
            		var messageText = "";
            		if (answerStatus == 0) { 
            			messageText = "拒绝通话";
					}
            		if (answerStatus == 1) {
            			showOrHide($(ele));
            			messageText = "同意通话";
//         				var iframeMy = $("<iframe frameborder='0' class='my-vtalk' src='"+$(ele).attr('data-info-answeraddress')+"'>"+
//         						"</iframe>"
//         							   );
//         				$('div.vtalk-view').append(iframeMy);
        				
        				window.location.href=$(ele).attr('data-info-answeraddress');
					}
            		//获得发送者的id
            		var answerFromId = $(ele).attr('data-info-fromid');
            		//获得接受者的id
            		var answerToId = $(ele).attr('data-info-toid');
            		 $.ajax({
	           			url:"${APP_PATH}/admin/friends/talk",
	           			data:{
	           				'toId':answerFromId,
	           				'text':messageText
	           			},
	           			type:"POST",
	           			success:function(result){
	           				var type = "unVideoTalk";
		            		sendFunction(result.extend.fromId,result.extend.fromName,answerFromId,messageText,type,result.extend.user,result.extend.sendTime);
	           			}
	           		}) 
            	}
            	
            	
            </script>

            
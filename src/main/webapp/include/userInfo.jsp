<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sh" uri="http://shiro.apache.org/tags" %>
        <%
	      pageContext.setAttribute("APP_PATH", request.getContextPath());
		%>
            <!-- 此处显示登录所用的用户名以及职位，用include标签包含进来 -->
            <div class="content-head-right">
                <ul class="login-info">
                    <li>
                        <a class="fa fa-envelope-o btn-myinfo dropdown-toggle" title="消息" data-toggle="dropdown"></a>
                        <div class="dropdown-menu dropdown-menu-head pull-right">
                        	<h5 class="title">您有0最新消息</h5>
                        	<ul class="dropdown-list normal-list" >
                        		<li class="myinfo">
                        			<a>
                        				<span class="myinfo-type">
                        					<img src="${APP_PATH}/personHeadFile/140.png" alt="" />
                        				</span>
                        				
                        				<span class="myinfo-desc">
                        					<span class="myinfo-name">李白</span>
                        					<span class="myinfo-msg">请求添加我为好友</span>
                        				</span>
                        				
                        			</a>
                        		</li>
                        		<li class="new">
                        			<a href="">查看更多</a>
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
            	function open(){
            		console.log('打开')
            	}
            	function close(){
            		console.log('关闭')
            	}
            </script>

            
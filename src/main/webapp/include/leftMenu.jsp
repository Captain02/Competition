<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 	<%
	      pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

	<div class="left-side">
            <ul class="nav-stacked nav-user">

                 <li>
                    <a href="${APP_PATH}/admin/personPage/list">
                        <span class="glyphicon glyphicon-home left-list-icon"></span>
                        <span class="menu-text">个人主页</span>
                    </a>
                </li>
                
                 <li>
                    <a href="${APP_PATH}/admin/schedule/list">
                        <span class="glyphicon glyphicon-calendar left-list-icon"></span>
                        <span class="menu-text">日程管理</span>
                    </a>
                </li>
                
                <li>
                    <a href="${APP_PATH}/admin/project/list">
                        <span class="glyphicon glyphicon-bookmark left-list-icon"></span>
                        <span class="menu-text">项目管理</span>
                    </a>
                </li>
                <li>
                    <a href="${APP_PATH}/admin/wordAttendence/list">
                        <span class="glyphicon glyphicon-bell left-list-icon"></span>
                        <span class="menu-text">考勤管理</span>
                    </a>
                </li>
                <li>
                    <a href="${APP_PATH}/admin/welcome/weclomeApproval">
                        <span class="glyphicon glyphicon-edit left-list-icon"></span>
                        <span class="menu-text">审批管理</span>
                    </a>
                </li>
                <li>
                    <a href="${APP_PATH}/admin/KnowledgeSharing/list">
                        <span class="glyphicon glyphicon-duplicate left-list-icon"></span>
                        <span class="menu-text">知识分享</span>
                    </a>
                </li>
                <li>
                    <a href="${APP_PATH}/admin/image/list">
                        <span class="glyphicon glyphicon-camera left-list-icon"></span>
                        <span class="menu-text">员工相册</span>
                    </a>
                </li>
                <li>
                    <a href="${APP_PATH}/admin/welcome/organization">
                        <span class="glyphicon glyphicon-user left-list-icon"></span>
                        <span class="menu-text">组织管理</span>
                    </a>
                </li>
                <li>
                    <a href="${APP_PATH}/admin/deploy/list">
                        <span class="glyphicon glyphicon-retweet left-list-icon"></span>
                        <span class="menu-text">流程管理</span>
                    </a>
                </li>

            </ul>


        </div>
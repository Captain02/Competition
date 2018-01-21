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
                        <a href="">
                            <i class="glyphicon glyphicon-envelope"></i>
                        </a>
                    </li>
                    <li>
                        <span>欢迎！</span>
                        <a href="#" data-toggle="dropdown">
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
                                <a href="${APP_PATH}/admin/user/changePassword/<sh:principal property="id" />">更换头像</a>
                            </li>
                            <li role="separator" class="divider"></li>
                            <li>
                                <a href="${APP_PATH}/logout">退出</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
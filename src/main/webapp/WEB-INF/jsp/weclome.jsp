<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sh" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>企业自动化办公系统欢迎您</title>
    
    <%
	  pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

    <link rel="stylesheet" href="${APP_PATH}/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/static/css/reset.css">
    <link rel="stylesheet" href="${APP_PATH}/static/css/style.css">
    
    <script src="${APP_PATH}/static/js/jquery.min.js"></script>
    <script src="${APP_PATH}/static/js/bootstrap.min.js"></script>

    <script src="${APP_PATH}/static/js/change.js"></script>

</head>

<body class="bg-common">

    <section>

        <!-- 页面模版，每页左侧区域固定不变 -->
        <div class="left-side">
            <ul class="nav-stacked nav-user">
                <li>
                    <a href="${APP_PATH}/admin/personPage/list">
                        <span class="glyphicon glyphicon-home left-list-icon"></span>
                        <span class="menu-text">个人主页</span>
                    </a>
                </li>
                <li>
                    <a href="http://">
                        <span class="glyphicon glyphicon-bookmark left-list-icon"></span>
                        <span class="menu-text">项目管理</span>
                    </a>
                </li>
                <li>
                    <a href="${APP_PATH}/admin/holiday/list">
                        <span class="glyphicon glyphicon-edit left-list-icon"></span>
                        <span class="menu-text">审批管理</span>
                        </a>
                </li>
                <li>
                    <a href="http://">
                        <span class="glyphicon glyphicon-duplicate left-list-icon"></span>
                        <span class="menu-text">知识分享</span>
                        </a>
                </li>
                <li>
                    <a href="http://">
                        <span class="glyphicon glyphicon-camera left-list-icon"></span>
                        <span class="menu-text">员工相册</span>
                        </a>
                </li>
                <li>
                    <a href="http://">
                        <span class="glyphicon glyphicon-pushpin left-list-icon"></span>
                        <span class="menu-text">简历管理</span>
                        </a>
                </li>
                <li>
                    <a href="${APP_PATH}/admin/user/list">
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


        <div class="main-content">

            <!-- 页面模版，每页主体部分头部按需更改 -->
            <div class="content-head content-head-section">

                <a class="toggle-btn">
                    <span class="glyphicon glyphicon-th-list"></span>
                </a>

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

                <div class="clearfix"></div>

            </div>

            <!-- 页面模版，按需更改 -->
            <div class="wrapper">

                <div class="row">
                    <div class="jumbotron text-center welcome-text" style="background-color:transparent;">
                        <h2>欢迎使用企业自动化办公系统！</h2>
                        <br>
                        <br>
                        <br>
                        <a href="" target="_blank">公司官网</a> ·
                        <a href="" target="_blank">公司简介</a> ·
                    </div>
                </div>

            </div>



        </div>




    </section>

</body>

</html>
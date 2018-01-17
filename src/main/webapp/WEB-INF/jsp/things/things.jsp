<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>物品管理</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
    <jsp:include page="iniCssHref.jsp"></jsp:include>

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

                <form action="/OA02/admin/things/list" class="serach-form" method="get">

                    <input class="form-control" type="text" name="name" placeholder="物品名称" value="">

                    <select class="form-control" name="state">
                        <option>状态</option>
                        <option>已通过</option>
                        <option>未通过</option>
                        <option>审核中</option>
                    </select>
                    <button type="submit" class="btn btn-primary">搜索</button>

                    <div class="clearfix"></div>
                </form>


                <!-- 此处显示登录所用的用户名以及职位，用include标签包含进来 -->
               <jsp:include page="iniUserInfo.jsp"></jsp:include>

                <div class="clearfix"></div>

            </div>

            <!-- 页面模版，按需更改 -->
            <div class="wrapper">

                <div class="om-header">

                     <jsp:include page="iniHolidayManagementHref.jsp"></jsp:include>

                    <div class="om-header-right ">
                        <button id="addButton" onclick="window.location.href='${APP_PATH}/admin/things/add'" type="button" class="btn btn-success btn-sm">
                            <i>+</i>我要领用
                        </button>
                    </div>
                    <div class="clearfix "></div>
                </div>

                <div class="om-wrapper ">
                    <div class="row ">
                        <div class="col-sm-12 ">

                            <header class="om-wrapper-header ">领用 / 总数：${pageInfo.total }</header>

                            <div class="om-wrpper-body ">
                                <table class="table table-hover holiday-table">
                                    <thead>
                                        <tr>
                                            <th>用途</th>
                                            <th>物品名称</th>
                                            <th>申请时间</th>
                                            <th>状态</th>
                                            <th>操作</th>
                                        </tr>
                                    </thead>
                                    <tbody>
										<c:forEach items="${pageInfo.list }" var="things">
	                                        <tr>
	                                            <td>${things.purpose}</td>
	                                            <td>${things.name}</td>
	                                            <td>${things.date}</td>
	                                            <td>
	                                                <span class="label label-success">${things.state}</span>
	                                            </td>
	                                            <td>
	                                                <div class="btn-group">
	                                                    <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
	                                                        操作
	                                                        <span class="caret"></span>
	                                                    </button>
	                                                    <ul class="dropdown-menu">
	                                                        <li>
	                                                            <a href="${APP_PATH}/admin/things/thingsNote/${things.id}">查看物品</a>
	                                                        </li>
	                                                        <li role="separator" class="divider"></li>
	                                                        <li>
	                                                            <a href="${APP_PATH}/admin/things/showCurrentView/${things.processinstanceid}">查看进度</a>
	                                                        </li>
	                                                    </ul>
	                                                </div>
	                                            </td>
	                                        </tr>
										</c:forEach>
                                    </tbody>
                                </table>
                            </div>

                        </div>

                    </div>
                    <!-- 分页 -->
                    <div class="page-area ">
                        <div class="container page-possiton ">

                          <nav aria-label="Page navigation">
								<ul class="pagination pagination-control">
									<li>
										<a href="${APP_PATH}/admin/things/list?pn=1&name=${name}&state=${state}">首页</a>
									</li>
									<c:if test="${pageInfo.hasPreviousPage}">
										<li>
											<a href="${APP_PATH}/admin/things/list?pn=${pageInfo.pageNum-1}&name=${name}&state=${state}" aria-label="Previous">
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
												<a href="${APP_PATH}/admin/things/list?pn=${pageNum}&name=${name}&state=${state}">${pageNum}</a>
											</li>
										</c:if>
									</c:forEach>

									<c:if test="${pageInfo.hasNextPage }">
										<li>
											<a href="${APP_PATH}/admin/things/list?pn=${pageInfo.pageNum+1}&name=${name}&state=${state}" aria-label="Next">
												<span aria-hidden="true">&raquo;</span>
											</a>
										</li>
									</c:if>

									<li>
										<a href="${APP_PATH}/admin/things/list?pn=${pageInfo.pages}&name=${name}&state=${state}" aria-label="Next">
											<span aria-hidden="true">末页</span>
										</a>
									</li>
								</ul>
							</nav>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </section>



</body>

</html>
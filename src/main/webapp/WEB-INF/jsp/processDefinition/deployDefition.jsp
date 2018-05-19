<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>流程定义</title>

<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>

</head>

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

				<form action="${APP_PATH}/admin/processDefinition/list" class="serach-form"
					method="get">

				 <input type="text" placeholder="输入流程定义名称" value="${name}"
						class="form-control" name="name">

					<button type="submit" class="btn btn-primary">搜索</button>


					<div class="clearfix"></div>
				</form>


				<jsp:include page="iniUserInfo.jsp"></jsp:include>

				<div class="clearfix"></div>

			</div>

			<!-- 页面模版，按需更改 -->
			<div class="wrapper">

				<div class="om-header">

					<div class="om-header-left">
						<h3>
							<span class="om-title">流程管理</span> <span class="om-list">
								 <a href="${APP_PATH}/admin/deploy/list">流程部署</a>
                                 <a href="${APP_PATH}/admin/processDefinition/list">流程定义</a>
                                 <a href="${APP_PATH}/admin/model/list">模块管理</a>

							</span>
						</h3>
					</div>

					
					<div class="clearfix"></div>
				</div>

				<div class="om-wrapper">
					<div class="row">
						<div class="col-sm-12">

							<header class="om-wrapper-header">流程定义 / 总数：${pageInfo.total}</header>

							<div class="om-wrpper-body">
								<form action="" id="user-list" class="user-list">
									<table class="table table-bordered table-striped">

										<thead>
											<tr>
												<th><input type="checkbox" name="selectAll"></th>
												<th>编号</th>
												<th>流程名称</th>
												<th>流程定义的key</th>
												<th>版本</th>
												<th>流程的规则文件名称</th>
												<th>图片名称</th>
												<th>流程部署ID</th>
												<th>操作</th>
											</tr>
										</thead>

										<tbody>
											<c:forEach items="${pageInfo.list}" var="ProcessDefinition">
												<tr>
													<td><input type="checkbox" name="selectThisLine">
													</td>
													<td>${ProcessDefinition.id }</td>
													<td>${ProcessDefinition.name }</td>
													<td>${ProcessDefinition.key }</td>
													<td>${ProcessDefinition.version }</td>
													<td>${ProcessDefinition.resourceName }</td>
													<td>${ProcessDefinition.diagramResourceName }</td>
													<td>${ProcessDefinition.deploymentId }</td>
													<td>
														<div class="btn-group">
															<button type="button"
																class="btn btn-success dropdown-toggle"
																data-toggle="dropdown" aria-haspopup="true"
																aria-expanded="false"
																onclick="window.open('${APP_PATH}/admin/processDefinition/showView/${ProcessDefinition.deploymentId}/${ProcessDefinition.diagramResourceName}')" >
																<span class="glyphicon glyphicon-picture"></span> 查看流程图
															</button>
														</div>
													</td>
												</tr>
											</c:forEach>

										</tbody>

									</table>
								</form>
							</div>

						</div>

					</div>

					<!-- 分页 -->
					<div class="page-area">
						<div class="container page-possiton">
							<nav aria-label="Page navigation">
								<ul class="pagination pagination-control">
									<li><a href="${APP_PATH}/admin/processDefinition/list?pn=1&name=${name}">首页</a></li>
									<c:if test="${pageInfo.hasPreviousPage}">
										<li><a
											href="${APP_PATH}/admin/processDefinition/list?pn=${pageInfo.pageNum-1}&name=${name}"
											aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
										</a></li>
									</c:if>
									<c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
										<c:if test="${pageNum==pageInfo.pageNum}">
											<li class="active"><a href="#">${pageNum}</a></li>
										</c:if>
										<c:if test="${pageNum!=pageInfo.pageNum}">
											<li><a href="${APP_PATH}/admin/processDefinition/list?pn=${pageNum}&name=${name}">${pageNum}</a>
											</li>
										</c:if>
									</c:forEach>

									<c:if test="${pageInfo.hasNextPage }">
										<li><a
											href="${APP_PATH}/admin/processDefinition/list?pn=${pageInfo.pageNum+1}&name=${name}"
											aria-label="Next"> <span aria-hidden="true">&raquo;</span>
										</a></li>
									</c:if>

									<li><a
										href="${APP_PATH}/admin/processDefinition/list?pn=${pageInfo.pages}&name=${name}"
										aria-label="Next"> <span aria-hidden="true">末页</span>
									</a></li>
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
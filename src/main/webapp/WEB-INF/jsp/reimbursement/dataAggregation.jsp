<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>报销数据汇总</title>
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

				<a href="" class="toggle-btn">
					<span class="glyphicon glyphicon-th-list"></span>
				</a>


				<form action="${APP_PATH}/admin/reimbursement/list" class="serach-form" method="get">
					<input placeholder="请输入用户名" value="" class="form-control" name="userName" type="text">
					
                     <select class="form-control" name="state">
	                    <option style="display: none;">选择月份</option>
	                    <c:forEach items="${collectDate}" var="date">
	                    <option style="display: none;" value="${date}">${date}</option>
	                    </c:forEach>
                    </select>
                    
					<button type="submit" class="btn btn-primary">搜索</button>

                     <div class="clearfix"></div>
                 </form>

				<jsp:include page="iniUserInfo.jsp"></jsp:include>

				<div class="clearfix"></div>

			</div>

			<!-- 页面模版，按需更改 -->
			<div class="wrapper">

				<div class="om-header">
					<jsp:include page="iniHolidayManagementHref.jsp"></jsp:include>


					<div class="clearfix"></div>
				</div>

				<div class="om-wrapper">
					<div class="row">
						<div class="col-sm-12">

							<header class="om-wrapper-header">月度报销数据汇总 / 总数：${pageInfo.total}</header>

							<div class="om-wrpper-body">
								<form action="" id="user-list" class="user-list">
									<table class="table table-hover general-table">
										
										<thead>
											<tr>
												<th>用户名</th>
												<th>姓名</th>
												<th>部门</th>
												<th>职称</th>
												<th>日期</th>
												<th>金额(元)</th>
												<th>操作</th>
											</tr>
										</thead>
										
										<tbody>
											<c:forEach items="${pageInfo.list}" var="reimbursementCollect">
												<tr>
													<td>${reimbursementCollect.username}</td>
													<td>${reimbursementCollect.name}</td>
													<td>${reimbursementCollect.departmentName}</td>
													<td>${reimbursementCollect.roleName}</td>
													<td>${reimbursementCollect.date}</td>
													<td>${reimbursementCollect.money}</td>
													<td>
														<a class="btn btn-info btn-sm">查看详情</a>
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
									<li>
										<a href="${APP_PATH}/admin/reimbursement/dataCollectPage?pn=1&userName=${userName}&date=${date}">首页</a>
									</li>
									<c:if test="${pageInfo.hasPreviousPage}">
										<li>
											<a href="${APP_PATH}/admin/reimbursement/dataCollectPage?pn=${pageInfo.pageNum-1}&userName=${userName}&date=${date}" aria-label="Previous">
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
												<a href="${APP_PATH}/admin/reimbursement/dataCollectPage?pn=${pageNum}&userName=${userName}&date=${date}">${pageNum}</a>
											</li>
										</c:if>
									</c:forEach>

									<c:if test="${pageInfo.hasNextPage }">
										<li>
											<a href="${APP_PATH}/admin/reimbursement/dataCollectPage?pn=${pageInfo.pageNum+1}&userName=${userName}&date=${date}" aria-label="Next">
												<span aria-hidden="true">&raquo;</span>
											</a>
										</li>
									</c:if>

									<li>
										<a href="${APP_PATH}/admin/reimbursement/dataCollectPage?pn=${pageInfo.pages}&userName=${userName}&date=${date}" aria-label="Next">
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
      
        <button type="button" class="btn btn-warning yes">确认</button>
        <button type="button" class="btn btn-success no">取消</button>
        
        <!-- 用于页面跳转的按钮 -->
        <form action="${APP_PATH}/admin/deploy/list">
        	<input type="hidden" value="${approved}" name="approved">
        	<input type="hidden" value="${pageInfo.pageNum}" name="pn">
        	<button type="submit" class="btn btn-danger down">关闭</button>
        </form>
        
      </div>
    </div>
  </div>
</div>
</body>

	</html>
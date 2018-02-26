<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>项目管理</title>

<%
   pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<link rel="stylesheet" href="${APP_PATH}/static/css/font-awesome.css">
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

                    <form action="${APP_PATH}/admin/demand/list" class="serach-form" method="get">

                        
						<select name="state" class="form-control">
				          <option value="需求状态">需求状态</option>
				          <option value="草稿">草稿</option>
				          <option value="激活">激活</option>
				          <option value="已变更">已变更</option>
				          <option value="待关闭">待关闭</option>
				          <option value="已关闭">已关闭</option>
       					</select>
                        <input type="text" placeholder="输入项目名称" value="${demandName == '需求名称'?null:demandName}" class="form-control" name="demandName">

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
								<span class="om-title">项目管理</span>
								<jsp:include page="projectLeftManagement.jsp"></jsp:include>
							</h3>
						</div>
                         
                        <div class="om-header-right">
	                        <div class="tools pull-left" style="margin-right: 3px;">
	                        		<a href="" class="btn btn-default btn-sm active">全部</a>
									<a href="" class="btn btn-default btn-sm">指派给我</a>
									<a href="" class="btn btn-default btn-sm">由我创建</a>
									<a href="" class="btn btn-default btn-sm">由我解决</a>
							</div>
                            <button id="addButton" type="button" class="btn btn-success btn-sm" onclick="window.location.href='${APP_PATH}/admin/demand/addPage'">
                                <i>+</i>提Bug
                            </button>
                        </div>


                        <div class="clearfix"></div>
                    </div>

                    <div class="om-wrapper">
                        <div class="row">
                            <div class="col-sm-12">

                                <header class="om-wrapper-header">测试/ 总数：${pageInfo.total}</header>

                                <div class="om-wrpper-body">
                                    <form action="" id="user-list" class="user-list">
                                        <table class="table table-bordered table-striped table-project">

                                            <thead>
                                                <tr>
                                                 <th>级别</th>
                                                 <th>Bug标题</th>
                                                 <th>状态</th>
                                                 <th>创建人</th>
                                                 <th>创建日期</th>
                                                 <th>指派人</th>
                                                 <th>解决人</th>
                                                 <th>解决日期</th>
                                                 <th>操作</th>
                                                </tr>
                                            </thead>

                                            <tbody>
                                           
	                                                <tr>
	                                               
	                                                    <td>1</td>
	                                                	<td class="project-name"><a href="${APP_PATH}/admin/demand/detailed?demandId=${DemandDisplay.id}">1</a></td>
	                                                    <td>1</td>
	                                                    <td>1</td>
	                                                    <td>1</td>
	                                                    <td>1</td>
	                                                    <td>1</td>
	                                                    <td>1</td>
	                                                    <td>
	                                                        <a class="btn btn-warning btn-xs btn-assign" title="指派"><i class="glyphicon glyphicon-hand-right"></i></a>
	                                                        <a href="" class="btn btn-info btn-xs" title="完成"><i class="glyphicon glyphicon-ok-sign "></i></a>
	                                                        <a href="" title="编辑" class="btn btn-danger btn-xs"><i class="fa fa-pencil-square-o"></i></a>
	                                                    </td>
	                                                </tr>
                                            
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
                                            <a href="${APP_PATH}/admin/demand/list?pn=1&projectName=${demandName}&state=${state}">首页</a>
                                        </li>
                                        <c:if test="${pageInfo.hasPreviousPage}">
                                            <li>
                                                <a href="${APP_PATH}/admin/demand/list?pn=${pageInfo.pageNum-1}&projectName=${demandName}&state=${state}" aria-label="Previous">
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
                                                    <a href="${APP_PATH}/admin/demand/list?pn=${pageNum}&projectName=${demandName}&state=${state}">${pageNum}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>

                                        <c:if test="${pageInfo.hasNextPage }">
                                            <li>
                                                <a href="${APP_PATH}/admin/demand/list?pn=${pageInfo.pageNum+1}&projectName=${demandName}&state=${state}" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>
                                        </c:if>

                                        <li>
                                            <a href="${APP_PATH}/admin/demand/list?pn=${pageInfo.pages}&projectName=${demandName}&state=${state}" aria-label="Next">
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
    </div>
  </div>
</div>

    </body>

</html>
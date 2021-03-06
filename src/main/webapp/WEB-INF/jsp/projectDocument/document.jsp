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

                    <form action="${APP_PATH}/admin/document/list" class="serach-form" method="get">

                        
						<select name="type" class="form-control" data-type="${type}">
				          <option value="类型">类型</option>
				          <option value="正文">正文</option>
				          <option value="连接">连接</option>
       					</select>
                        <input type="text" placeholder="输入项目名称" value="${documentName == '文档名'?'':documentName}" class="form-control" name="documentName">

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
								<span class="om-title">文档管理</span>
								<jsp:include page="projectLeftManagement.jsp"></jsp:include>
							</h3>
						</div>
                         
                        <div class="om-header-right">
                            <button id="addButton" type="button" class="btn btn-success btn-sm" onclick="window.location.href='${APP_PATH}/admin/document/addPage'">
                                <i>+</i>新文档
                            </button>
                        </div>


                        <div class="clearfix"></div>
                    </div>

                    <div class="om-wrapper">
                        <div class="row">
                            <div class="col-sm-12">

                                <header class="om-wrapper-header">文档 / 总数：${pageInfo.total}</header>

                                <div class="om-wrpper-body">
                                    <form action="documentForm" id="user-list" class="user-list">
                                        <table class="table table-bordered table-striped table-project">

                                            <thead>
                                                <tr>
                                                 <th>名称</th>
                                                 <th>类型</th>
                                                 <th>创建人</th>
                                                 <th>创建日期</th>
                                                 <th>操作</th>
                                                </tr>
                                            </thead>

                                            <tbody>
                                          			<c:forEach items="${pageInfo.list}" var="document">
	                                                <tr>
	                                                	<td class="project-name"><a href="${APP_PATH}/admin/document/detailed?id=${document.id}">${document.documentName}</a></td>
	                                                    <td>${document.type}</td>
	                                                    <td>${document.createPeople}</td>
	                                                    <td>${document.createTime}</td>
	                                                    <td>
	                                                    	<a href="${APP_PATH}/admin/document/editor?id=${document.id}" title="编辑" class="btn btn-danger btn-xs"><i class="fa fa-pencil-square-o"></i></a> 
	                                                    	<a href="${APP_PATH}/admin/document/detailed?id=${document.id}" title="查看" class="btn btn-success btn-xs"><i class="fa fa-eye"></i></a>
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
                                            <a href="${APP_PATH}/admin/project/list?pn=1&type=${type}&documentName=${documentName}">首页</a>
                                        </li>
                                        <c:if test="${pageInfo.hasPreviousPage}">
                                            <li>
                                                <a href="${APP_PATH}/admin/project/list?pn=${pageInfo.pageNum-1}&type=${type}&documentName=${documentName}" aria-label="Previous">
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
                                                    <a href="${APP_PATH}/admin/project/list?pn=${pageNum}&type=${type}&documentName=${documentName}">${pageNum}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>

                                        <c:if test="${pageInfo.hasNextPage }">
                                            <li>
                                                <a href="${APP_PATH}/admin/project/list?pn=${pageInfo.pageNum+1}&type=${type}&documentName=${documentName}" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>
                                        </c:if>

                                        <li>
                                            <a href="${APP_PATH}/admin/project/list?pn=${pageInfo.pages}&type=${type}&documentName=${documentName}" aria-label="Next">
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
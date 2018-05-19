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
    <title>模块管理</title>

<%
   pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<script src="${APP_PATH}/static/js/selectAll.js"></script>
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

                    <form action="${APP_PATH}/admin/deploy/list" class="serach-form" method="get">

                        

                        <input type="text" placeholder="输入流程部署名称" value="${name}" class="form-control" name="name">

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
                                <span class="om-title">流程管理</span>
                                <span class="om-list">
                                    <a href="${APP_PATH}/admin/deploy/list">流程部署</a>
                                    <a href="${APP_PATH}/admin/processDefinition/list">流程定义</a>
									 <a href="${APP_PATH}/admin/model/list">模块管理</a>
                                </span>
                            </h3>
                        </div>

                        <div class="om-header-right">
                            <button id="addButton" type="button" class="btn btn-success btn-sm" onclick="window.location.href='${APP_PATH}/admin/deploy/addeploy'">
                                <i>+</i>添加
                            </button>
                            <button id="delButton" type="button" class="btn btn-danger btn-sm" onclick="deleAll()">
                                <i>-</i>批量删除
                            </button>
                            <input type="hidden" value=""  class="ids"/>
                        </div>


                        <div class="clearfix"></div>
                    </div>

                    <div class="om-wrapper">
                        <div class="row">
                            <div class="col-sm-12">

<%--                                 <header class="om-wrapper-header">模块管理 / 总数：${pageInfo.total}</header> --%>

                                <div class="om-wrpper-body">
                                    <form action="" id="user-list" class="user-list">
                                        <table class="table table-bordered table-striped">

                                            <thead>
                                                <tr>
                                                <th><input type="checkbox" name="selectAll" class="selectAll" id="selectAll"></th>
                                                    <th>Key</th>
                                                    <th>名称</th>
                                                    <th>描述</th>
                                                </tr>
                                            </thead>

                                            <tbody>
												<c:forEach items="${list}" var="model">
	                                                <tr>
	                                                <td>${model.key} <input type="hidden" value="${model.key}" /></td>
                                                    <td>${model.name}</td>
                                                    <td>${model.version}</td>
													</c:forEach>
                                            </tbody>

                                        </table>
                                    </form>
                                </div>

                            </div>

                        </div>

                        <!-- 分页 -->
<!--                         <div class="page-area"> -->
<!--                             <div class="container page-possiton"> -->
<!--                                 <nav aria-label="Page navigation"> -->
<!--                                     <ul class="pagination pagination-control"> -->
<!--                                         <li> -->
<%--                                             <a href="${APP_PATH}/admin/deploy/list?pn=1&name=${name}">首页</a> --%>
<!--                                         </li> -->
<%--                                         <c:if test="${pageInfo.hasPreviousPage}"> --%>
<!--                                             <li> -->
<%--                                                 <a href="${APP_PATH}/admin/deploy/list?pn=${pageInfo.pageNum-1}&name=${name}" aria-label="Previous"> --%>
<!--                                                     <span aria-hidden="true">&laquo;</span> -->
<!--                                                 </a> -->
<!--                                             </li> -->
<%--                                         </c:if> --%>
<%--                                         <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum"> --%>
<%--                                             <c:if test="${pageNum==pageInfo.pageNum}"> --%>
<!--                                                 <li class="active"> -->
<%--                                                     <a href="#">${pageNum}</a> --%>
<!--                                                 </li> -->
<%--                                             </c:if> --%>
<%--                                             <c:if test="${pageNum!=pageInfo.pageNum}"> --%>
<!--                                                 <li> -->
<%--                                                     <a href="${APP_PATH}/admin/deploy/list?pn=${pageNum}&name=${name}">${pageNum}</a> --%>
<!--                                                 </li> -->
<%--                                             </c:if> --%>
<%--                                         </c:forEach> --%>

<%--                                         <c:if test="${pageInfo.hasNextPage }"> --%>
<!--                                             <li> -->
<%--                                                 <a href="${APP_PATH}/admin/deploy/list?pn=${pageInfo.pageNum+1}&name=${name}" aria-label="Next"> --%>
<!--                                                     <span aria-hidden="true">&raquo;</span> -->
<!--                                                 </a> -->
<!--                                             </li> -->
<%--                                         </c:if> --%>

<!--                                         <li> -->
<%--                                             <a href="${APP_PATH}/admin/deploy/list?pn=${pageInfo.pages}&name=${name}" aria-label="Next"> --%>
<!--                                                 <span aria-hidden="true">末页</span> -->
<!--                                             </a> -->
<!--                                         </li> -->
<!--                                     </ul> -->
<!--                                 </nav> -->
<!--                             </div> -->
<!--                         </div> -->

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
<%--         <form action="${APP_PATH}/admin/deploy/list"> --%>
<%--         	<input type="hidden" value="${pageInfo.pageNum}" name="pn"> --%>
<!--         	<button type="submit" class="btn btn-danger down">关闭</button> -->
<!--         </form> -->
        
      </div>
    </div>
  </div>
</div>

    </body>

</html>
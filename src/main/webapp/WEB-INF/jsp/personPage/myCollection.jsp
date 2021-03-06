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
<title>我的收藏</title>

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

                    <form action="" class="serach-form" method="get">

                        

                       <select class="form-control" name="type" value="类型">
                            <option>类型</option>
                            <option>点赞</option>
                            <option>评论</option>
                            <option>收藏</option>
                        </select>
                        <select class="form-control" name="state" value="状态">
                            <option>类型</option>
                            <option>已读</option>
                            <option>未读</option>
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

                        <div class="om-header-left">
                            <h3>
                                <span class="om-title">我的收藏</span>
                               
                            </h3>
                        </div>

                        


                        <div class="clearfix"></div>
                    </div>

                    <div class="om-wrapper">
                        <div class="row">
                            <div class="col-sm-12">

                                <header class="om-wrapper-header">我的收藏 / 总数：${pageInfo.total}</header>

                                <div class="om-wrpper-body">
                                    <form action="" id="user-list" class="user-list">
                                        <table class="table table-info">

                                        

                                            <tbody>
													<c:forEach items="${pageInfo.list}" var="myCollectionDisplay">
	                                                <tr>
	                                                <td colspan="1">
	                                                   <div class="info-desc" style="margin-left: 20px;">
		                                                   <a href="这里加个人主页链接" class="pull-left info-img">
		                                                   	<img src="${APP_PATH}/personHeadFile/${myCollectionDisplay.userHead}" alt="" />
		                                                   </a>
		                                                   <a href="${APP_PATH}/admin/KnowledgeSharing/detailedTopic?topicId=${myCollectionDisplay.topicId}" class="pull-left info-user">
		                                                   	<strong>${myCollectionDisplay.userName}</strong>
		                                                   	<span>${myCollectionDisplay.userName}的${myCollectionDisplay.topicType} ${myCollectionDisplay.topicName}</span>
		                                                   </a>
		                                                   <a href="${APP_PATH}/admin/KnowledgeSharing/detailedTopic?topicId=${myCollectionDisplay.topicId}" class="pull-right text-muted info-time">
		                                                   	<small>${myCollectionDisplay.collectionDate}</small>
		                                                   </a>
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
                    </div>
                    <nav aria-label="Page navigation" class="pull-right" style="position: absolute; right: 40px; bottom: 0;">
									  <ul class="pagination pagination-sm">
									    <li>
                                                <a href="${APP_PATH}/admin/KnowledgeSharing/list?pn=1&type=${type}&name=${name}">首页</a>
                                            </li>
                                            <c:if test="${pageInfo.hasPreviousPage}">
                                                <li>
                                                    <a href="${APP_PATH}/admin/KnowledgeSharing/list?pn=${pageInfo.pageNum-1}&type=${type}&name=${name}" aria-label="Previous">
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
                                                        <a href="${APP_PATH}/admin/KnowledgeSharing/list?pn=${pageNum}&type=${type}&name=${name}">${pageNum}</a>
                                                    </li>
                                                </c:if>
                                            </c:forEach>

                                            <c:if test="${pageInfo.hasNextPage }">
                                                <li>
                                                    <a href="${APP_PATH}/admin/KnowledgeSharing/list?pn=${pageInfo.pageNum+1}&type=${type}&name=${name}" aria-label="Next">
                                                        <span aria-hidden="true">&raquo;</span>
                                                    </a>
                                                </li>
                                            </c:if>

                                            <li>
                                                <a href="${APP_PATH}/admin/KnowledgeSharing/list?pn=${pageInfo.pages}&type=${type}&name=${name}" aria-label="Next">
                                                    <span aria-hidden="true">末页</span>
                                                </a>
                                            </li>
									  </ul>
								</nav>

                            
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
        	<input type="hidden" value="${pageInfo.pageNum}" name="pn">
        	<button type="submit" class="btn btn-danger down">关闭</button>
        </form>
        
      </div>
    </div>
  </div>
</div>

    </body>

</html>
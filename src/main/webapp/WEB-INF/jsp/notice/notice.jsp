<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>公告</title>
	<%
	      pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<script type="text/javascript">
function dele(id) {
	var noticeId = id;
	
	$.ajax({
		url:"${APP_PATH}/admin/notice/dele",
		data:{
			'noticeId':noticeId
		},
		type:"POST",
		success:function(result){
			//弹模态框直接刷新
		}
	})
}

</script>

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

                   


                    <jsp:include page="iniUserInfo.jsp"></jsp:include>

                    <div class="clearfix"></div>

                </div>

                <!-- 页面模版，按需更改 -->
                <div class="wrapper">

                    <div class="om-header">

                        <jsp:include page="iniOrganizationManagementHref.jsp"></jsp:include>

                        <div class="om-header-right">
                        <c:if test="${isByMyId !=0 }">
                        	<button id="addButton" type="button" class="btn btn-success" onclick="window.location.href='${APP_PATH}/admin/notice/list'">
                               	全部</button>
                        </c:if>
                         <c:if test="${isByMyId ==0 }">
                            <button id="addButton" type="button" class="btn btn-warning" onclick="window.location.href='${APP_PATH}/admin/notice/list?isByMyId=${userId}'">
                               	由我发布</button>
                          </c:if>
                            <button id="addButton" type="button" class="btn btn-success" onclick="window.location.href='${APP_PATH}/admin/notice/add'">
                                <i>+</i>发布新公告</button>
                        
                        </div>


                        <div class="clearfix"></div>
                    </div>

                    <div class="om-wrapper">
                        <div class="row">
                            <div class="col-sm-12">

                                <header class="om-wrapper-header">公告管理 / 总数：${pageInfo.total}</header>

                                <div class="om-wrpper-body">
                                    <form action="" id="user-list" class="user-list">
                                        <table class="table table-striped table-bordered table-notice">

                                            <thead>
                                                <tr>
                                                    <th>公告标题</th>
                                                    <th>公告内容</th>
                                                    <th>发布时间</th>
                                                    <th>操作</th>
                                                </tr>
                                            </thead>

                                            <tbody>
												<c:forEach items="${pageInfo.list}" var="Notice">
	                                                <tr>
	                                                    <td>${Notice.title}</td>
	                                                    <td class="notice-text text-center" title="查看详情"><a>${Notice.text}</a></td>
	                                                    <td>${Notice.date}</td>
	                                                    <td>
	                                                        <div class="btn-group">
	                                                            <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                                                                	操作
	                                                                <span class="caret"></span>
	                                                            </button>
	                                                            <ul class="dropdown-menu">
	                                                             <li>
	                                                                    <a href="">查看</a>
	                                                                </li>
	                                                                <c:if test="${isByMyId !=0 }">
	                                                                <li role="separator" class="divider"></li>
	                                                                <li>
	                                                                    <a href="${APP_PATH}/admin/notice/update/${Notice.id}">编辑</a>
	                                                                </li>
	                                                                <li role="separator" class="divider"></li>
	                                                                 <li>
																		<a>删除</a>
	                                                                </li>
	                                                               </c:if>
	                                                            </ul>
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
                                            <li>
                                                <a href="${APP_PATH}/admin/notice/list?pn=1&isByMyId=${isByMyId}">首页</a>
                                            </li>
                                            <c:if test="${pageInfo.hasPreviousPage}">
                                                <li>
                                                    <a href="${APP_PATH}/admin/notice/list?pn=${pageInfo.pageNum-1}&isByMyId=${isByMyId}" aria-label="Previous">
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
                                                        <a href="${APP_PATH}/admin/notice/list?pn=${pageNum}&isByMyId=${isByMyId}">${pageNum}</a>
                                                    </li>
                                                </c:if>
                                            </c:forEach>

                                            <c:if test="${pageInfo.hasNextPage }">
                                                <li>
                                                    <a href="${APP_PATH}/admin/notice/list?pn=${pageInfo.pageNum+1}&isByMyId=${isByMyId}" aria-label="Next">
                                                        <span aria-hidden="true">&raquo;</span>
                                                    </a>
                                                </li>
                                            </c:if>

                                            <li>
                                                <a href="${APP_PATH}/admin/notice/list?pn=${pageInfo.pages}&isByMyId=${isByMyId}" aria-label="Next">
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
     </div>
   </div>
 </div>
</div>

<script type="text/javascript">
	$(function(){
		$('.notice-text a').each(function(){
			var maxwidth = 20
			if($(this).text().length>20){
				$(this).text($(this).text().substring(0,maxwidth));
				$(this).html($(this).html() + '...');
			}
			
		})
		
		$('.notice-text').each(function(){
			$(this).click(function(){
				$('#myModal').modal('show');
			})
		})
		
	})
</script>

 </body>

</html>
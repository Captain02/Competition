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
<script src="${APP_PATH}/static/js/ctrolButton.js"></script>
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
	                                                    <td class="notice-text text-center" title="查看详情"><a data-notice-text="${Notice.text}">${Notice.text}</a></td>
	                                                    <td>${Notice.date}</td>
	                                                    <td>
	                                                        <div class="btn-group">
	                                                            <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                                                                	操作
	                                                                <span class="caret"></span>
	                                                            </button>
	                                                            <ul class="dropdown-menu">
	                                                             <li>
	                                                             		
	                                                                    <a
	                                                                    data-notice-title="${Notice.title}" 
	                                                                    data-notice-text="${Notice.text}"
	                                                                    data-notice-date="${Notice.date}"
	                                                                    data-notice-username="${Notice.userName}"
	                                                                    data-notice-role="${Notice.role}"
	                                                                    data-notice-department="${Notice.department}"
	                                                                    data-notice-headFile="${APP_PATH}/personHeadFile/${Notice.headFile}" class="view-notice">查看</a>
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
      <button class="btn btn-warning pull-left btn-more-info">更多<span class="caret"></span></button>
      <button type="button" class="btn btn-success" data-dismiss="modal">关闭</button>
      <div class="notice-info clearfix" style="margin-top: 15px; border-bottom: 1px solid #e5e5e5;">
      	<div class="col-md-12">
      		<div class="col-md-4">
      			<div class="panel">
				<div class="panel-body">
					<div class="profile-pic text-center">
					<img src="/OA02/personHeadFile/140.png" alt="">
					</div>
				</div>
			</div>
      	</div>
      	
      	<div class="col-md-8">
      		<div class="panel">
			<div class="panel-body">
				<ul class="p-info" style="margin-top: 20px;">
					<li>
						<div class="title">发布人</div>
						<div class="desk notice-author"></div>
					</li>
					
					
					<li>
						<div class="title">部门</div>
						<div class="desk notice-author-deparment"></div>
					</li>
					
					<li>
						<div class="title">角色</div>
						<div class="desk notice-author-role"></div>
					</li>
					
					
					
					<li>
						<div class="title">发布日期</div>
						<div class="desk notice-date"></div>
					</li>
				
				</ul>
			</div>
		</div>
      	</div>
      	</div>
      
      </div>
     </div>
   </div>
 </div>
</div>

<script type="text/javascript">
	$(function(){
		$('.notice-text a').each(function(){
			var maxwidth = 30
			if($(this).text().length>maxwidth){
				$(this).text($(this).text().substring(0,maxwidth));
				$(this).html($(this).html() + '...');
			}
			
			$(this).click(function(){
				$('#myModal').modal('show');
				$('.btn-more-info').addClass('hidden');
				$('div.notice-info').addClass('hidden');
				ShowTips('.modal-title','公告详情','.modal-body',$(this).attr('data-notice-text'));
			})
			
		})
		
		$('.view-notice').each(function(){
			$(this).click(function(){
				$('#myModal').modal('show');
				ShowTips('.modal-title','公告详情','.modal-body',$(this).attr('data-notice-text'));
				$('div.notice-info').addClass('hidden');
				$('.btn-more-info').removeClass('hidden');
				$('.notice-author').html($(this).attr('data-notice-username'));
				$('.notice-author-deparment').html($(this).attr('data-notice-department'));
				$('.notice-author-role').html($(this).attr('data-notice-role'));
				$('.notice-date').html($(this).attr('data-notice-date'));
			})
		})
		
		$('.btn-more-info').click(function(){
			if($('div.notice-info').hasClass('hidden')){
				$('div.notice-info').removeClass('hidden');
			}
			else{
				$('div.notice-info').addClass('hidden');
			}
		});
		
	})
</script>

 </body>

</html>
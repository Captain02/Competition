<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>部门管理</title>
	<%
	      pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
<jsp:include page="iniCssHref.jsp"></jsp:include>

<script src="${APP_PATH}/static/js/change.js"></script>
<script type="text/javascript">
<!-- 初始状态下，关闭按钮是隐藏的 -->
$(function(){
	ShowEle('.down','hide');
});
	$(document).on("click",".dele",function(){
		var name = $(this).parents("tr").find("td:eq(0)").text();
		var id = $(this).attr("value");
        ShowTips('.modal-title','删除确认？','.modal-body','确认删除' + '<b style = "color:#c9302c;">' + name + '</b>' + '吗？');
		$('.yes').click(function(){
			$.ajax({
				url:"${APP_PATH}/admin/department/dele/"+id+"",
				type:"DELETE",
				success:function(result){
					if (result.code==100) {
						$('#myModal').modal('show');
						ShowTips('.modal-title','删除结果回执','.modal-body','已成功删除' + '<b style = "color:#c9302c;">' + name + '</b>' + '的相关信息');
						ShowEle('.yes','hide','.no','hide','.down','show');
						
					}
					else if(result.code==200){
						$('#myModal').modal('show');
						ShowTips('.modal-title','删除结果回执','.modal-body','<b style = "color:#c9302c;">' + '操作失败,该部门还存在人员!' + '</b>');
						ShowEle('.yes','hide','.no','hide','.down','show');
					}
				}
			});
			
		});
		
		$('.no').click(function(){
			$('#myModal').modal('hide');
		});
		ShowEle('.yes','show','.no','show');
	});
	
	
</script>
</head>

<body>

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

                    <form action="${APP_PATH}/admin/department/list" class="serach-form" method="get">

                       

                        <input type="text" placeholder="请输入名称" value="${name}" class="form-control" name="name">

                        <button type="submit" class="btn btn-primary">搜索</button>


                        <div class="clearfix"></div>
                    </form>


                    <jsp:include page="iniUserInfo.jsp"></jsp:include>

                    <div class="clearfix"></div>

                </div>

                <!-- 页面模版，按需更改 -->
                <div class="wrapper">

                    <div class="om-header">

                        <jsp:include page="iniOrganizationManagementHref.jsp"></jsp:include>

                        <div class="om-header-right">
                            <button id="addButton" type="button" class="btn btn-success" onclick="window.location.href='${APP_PATH}/admin/department/add'">
                                <i>+</i>添加新部门</button>
                        </div>


                        <div class="clearfix"></div>
                    </div>

                    <div class="om-wrapper">
                        <div class="row">
                            <div class="col-sm-12">

                                <header class="om-wrapper-header">部门管理 / 总数：${pageInfo.total}</header>

                                <div class="om-wrpper-body">
                                    <form action="" id="user-list" class="user-list">
                                        <table class="table table-bordered table-striped">

                                            <thead>
                                                <tr>
                                                    <th>部门名称</th>
                                                    <th>描述</th>
                                                    <th>地理位置</th>
                                                    <th>操作</th>
                                                </tr>
                                            </thead>

                                            <tbody>
												<c:forEach items="${pageInfo.list}" var="department">
	                                                <tr>
	                                                    <td>${department.name}</td>
	                                                    <td>${department.description}</td>
	                                                    <td>${department.address}</td>
	                                                    <td>
	                                                        <div class="btn-group">
	                                                            <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                                                                操作
	                                                                <span class="caret"></span>
	                                                            </button>
	                                                            <ul class="dropdown-menu">
	                                                                <li>
	                                                                    <a href="${APP_PATH}/admin/department/update/${department.id}/${pageInfo.pageNum}">编辑</a>
	                                                                </li>
	                                                                <li role="separator" class="divider"></li>
	                                                                <li>
	                                                                    <a class="dele" value="${department.id }" data-toggle="modal" data-target="#myModal">删除</a>
	                                                                </li>
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
                                            <a href="${APP_PATH}/admin/department/list?pn=1&name=${name}">首页</a>
                                        </li>
                                        <c:if test="${pageInfo.hasPreviousPage}">
                                            <li>
                                                <a href="${APP_PATH}/admin/department/list?pn=${pageInfo.pageNum-1}&name=${name}" aria-label="Previous">
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
                                                    <a href="${APP_PATH}/admin/department/list?pn=${pageNum}&name=${name}">${pageNum}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>

                                        <c:if test="${pageInfo.hasNextPage }">
                                            <li>
                                                <a href="${APP_PATH}/admin/department/list?pn=${pageInfo.pageNum+1}&name=${name}" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li
                                            >
                                        </c:if>

                                        <li>
                                            <a href="${APP_PATH}/admin/department/list?pn=${pageInfo.pages}&name=${name}" aria-label="Next">
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
        <form action="${APP_PATH}/admin/department/list">
        	<input type="hidden" value="${pageInfo.pageNum}" name="pn">
        	<button type="submit" class="btn btn-danger down">关闭</button>
        </form>
        
      </div>
    </div>
  </div>
</div>


 </body>

</html>
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
<!-- 控制按钮的状态以及模态框展示的信息 -->
<script src="${APP_PATH}/static/js/selectAll.js"></script>
<script type="text/javascript">
	function changeState(ele) {
		var state = $(ele).attr('data-state');
		var projectId = $(ele).attr('data-projectId');
		$.ajax({
			url:"${APP_PATH}/admin/project/changeState",
			data:{
				'state':state,
				'projectId':projectId
			},
			type:"POST",
			success:function(result){
				$('#myModal').modal('show');
				ShowTips('.modal-title','执行结果','.modal-body','项目状态更改成功');
				 setTimeout(function(){
					 $('#myModal').modal('hide');
					 window.location.reload();
				 },1000);
			}
		})
	}

</script>
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

                    <form action="${APP_PATH}/admin/project/list" class="serach-form" method="get">

                        
						<select name="state" class="form-control">
				          <option value="">项目状态</option>
				          <option value="1">挂起</option>
				          <option value="2">延期</option>
				          <option value="3">进行</option>
				          <option value="4">结束</option>
       					</select>
                        <input type="text" placeholder="输入项目名称" value="${projectName == '项目名称'?'':projectName}" class="form-control" name="projectName">

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
                            </h3>
                        </div>

                        <div class="om-header-right">
                            <button id="addButton" type="button" class="btn btn-success btn-sm" onclick="window.location.href='${APP_PATH}/admin/project/addPage'">
                                <i>+</i>新项目
                            </button>
                        </div>


                        <div class="clearfix"></div>
                    </div>

                    <div class="om-wrapper">
                        <div class="row">
                            <div class="col-sm-12">

                                <header class="om-wrapper-header">项目管理 / 总数：${pageInfo.total}</header>

                                <div class="om-wrpper-body">
                                    <form action="" id="user-list" class="user-list">
                                        <table class="table table-bordered table-striped table-project">

                                            <thead>
                                                <tr>
                                                 <th>名称</th>
                                                 <th>别名</th>
                                                 <th>创建人</th>
                                                 <th>负责人</th>
                                                 <th>结束时间</th>
                                                 <th>状态</th>
                                                 <th>操作</th>
                                                </tr>
                                            </thead>

                                            <tbody>
                                            <c:forEach items="${pageInfo.list}" var="ProjectDisplay">
	                                                <tr>
	                                                	<td class="project-name"><a href="${APP_PATH}/admin/project/projectDetails?projectId=${ProjectDisplay.id}">${ProjectDisplay.projectName}</a></td>
	                                                    <td>${ProjectDisplay.projectAliasName}</td>
	                                                    <td>${ProjectDisplay.createPeople}</td>
	                                                    <td>${ProjectDisplay.projectResponsiblePeople}</td>
	                                                    <td>${ProjectDisplay.endDate}</td>
	                                                    <td>${ProjectDisplay.state}</td>
	                                                    <td>
	                                                        <div class="btn-group">
	                                                            <button type="button" class="btn btn-primary dropdown-toggle " data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                                                                	操作
	                                                                <span class="caret"></span>
	                                                            </button>
	                                                            <ul class="dropdown-menu">
	                                                                <li>
	                                                                    <a href="${APP_PATH}/admin/project/editor?projectId=${ProjectDisplay.id}">编辑</a>
	                                                                </li>
	                                                                <li role="separator" class="divider"></li>
	                                                                 <li>
	                                                                    <a onclick="changeState(this);" data-projectId="${ProjectDisplay.id}" data-state="挂起">挂起</a>
	                                                                </li>
	                                                                 <li>
	                                                                    <a onclick="changeState(this);" data-projectId="${ProjectDisplay.id}" data-state="延期">延期</a>
	                                                                </li>
	                                                                 <li role="separator" class="divider"></li>
	                                                                  <li>
	                                                                    <a onclick="changeState(this);" data-projectId="${ProjectDisplay.id}" data-state="进行">进行</a>
	                                                                </li>
	                                                                 <li>
	                                                                    <a onclick="changeState(this);" data-projectId="${ProjectDisplay.id}" data-state="结束">结束</a>
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
                                            <a href="${APP_PATH}/admin/project/list?pn=1&projectName=${projectName}&state=${state}">首页</a>
                                        </li>
                                        <c:if test="${pageInfo.hasPreviousPage}">
                                            <li>
                                                <a href="${APP_PATH}/admin/project/list?pn=${pageInfo.pageNum-1}&projectName=${projectName}&state=${state}" aria-label="Previous">
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
                                                    <a href="${APP_PATH}/admin/project/list?pn=${pageNum}&projectName=${projectName}&state=${state}">${pageNum}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>

                                        <c:if test="${pageInfo.hasNextPage }">
                                            <li>
                                                <a href="${APP_PATH}/admin/project/list?pn=${pageInfo.pageNum+1}&projectName=${projectName}&state=${state}" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>
                                        </c:if>

                                        <li>
                                            <a href="${APP_PATH}/admin/project/list?pn=${pageInfo.pages}&projectName=${projectName}&state=${state}" aria-label="Next">
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
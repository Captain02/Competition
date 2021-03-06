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
<script type="text/javascript">
	function changeState(ele){
		var id = $(ele).attr('data-id');
		var state = $(ele).attr('data-state');
		
		$.ajax({
			url:"${APP_PATH}/admin/bug/changeState",
			data:{
				'id':id,
				'state':state
			},
			type:"POST",
			success:function(result){
				
			}
			
		})
	}
	function assignTask(ele) {
		var bugId = $(ele).attr('data-bugId');
		var assignor = $(ele).attr('data-assignor');
		$.ajax({
			url:"${APP_PATH}/admin/bug/assignTask",
			data:{
				'bugId':bugId,
				'assignor':assignor
			},
			type:"POST",
			success:function(result){
				$('#myModal').modal('show');
				ShowTips('.modal-title', '执行结果', '.modal-body',
					'<b style = "color:#5cb85c;">指派成功</b>');
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

                    <form action="${APP_PATH}/admin/bug/list" class="serach-form" method="get">

                        
						<select name="state" class="form-control" data-type="${state}">
				          <option value="状态">状态</option>
				          <option value="设计如此">设计如此</option>
				          <option value="重复bug">重复bug</option>
				          <option value="外部原因">外部原因</option>
				          <option value="已解决">已解决</option>
				          <option value="无法重现">无法重现</option>
				          <option value="延期处理">延期处理</option>
				          <option value="不予解决">不予解决</option>
				          <option value="待解决">待解决</option>
       					</select>
                        <input type="text" placeholder="输入项目名称" value="${name=='名称'?'':名称}" class="form-control" name="name">

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
	                        		<a href="${APP_PATH}/admin/bug/list?herfPage=0" class="btn btn-default btn-sm active">全部</a>
									<a href="${APP_PATH}/admin/bug/list?herfPage=1" class="btn btn-default btn-sm">指派给我</a>
									<a href="${APP_PATH}/admin/bug/list?herfPage=2" class="btn btn-default btn-sm">由我创建</a>
									<a href="${APP_PATH}/admin/bug/list?herfPage=3" class="btn btn-default btn-sm">由我解决</a>
							</div>
                            <button id="addButton" type="button" class="btn btn-success btn-sm" onclick="window.location.href='${APP_PATH}/admin/bug/add'">
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
                                           		<c:forEach items="${pageInfo.list}" var="bugDisplay">
	                                                <tr>
	                                           			<input type="hidden" value="${bugDisplay.id}" class="bugdisplayId">
	                                                    <td data-grade="${bugDisplay.grade}" class="project-grade"><span class="label">${bugDisplay.grade}</span></td>
	                                                	<td class="project-name"><a href="${APP_PATH}/admin/bug/detailed?bugId=${bugDisplay.id}">${bugDisplay.bugTitle}</a></td>
	                                                    <td>${bugDisplay.state}</td>
	                                                    <td>${bugDisplay.creatPeople}</td>
	                                                    <td>${bugDisplay.creatTime}</td>
	                                                    <td>${bugDisplay.assginor}</td>
	                                                    <td>${bugDisplay.completpeople}</td>
	                                                    <td>${bugDisplay.endtime}</td>
	                                                    <td>
	                                                        <a class="btn btn-warning btn-xs btn-assign" title="指派" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-hand-right"></i></a>
	                                                        <a onclick="changeState(this);" class="btn btn-info btn-xs" data-id="${bugDisplay.id}" data-state="已完成" title="完成"><i class="glyphicon glyphicon-ok-sign "></i></a>
	                                                        <a href="${APP_PATH}/admin/bug/editor?bugId=${bugDisplay.id}" title="编辑" class="btn btn-danger btn-xs"><i class="fa fa-pencil-square-o"></i></a>
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
                                            <a href="${APP_PATH}/admin/bug/list?pn=1&name=${name}&state=${state}&herfPage=${herfPage}">首页</a>
                                        </li>
                                        <c:if test="${pageInfo.hasPreviousPage}">
                                            <li>
                                                <a href="${APP_PATH}/admin/bug/list?pn=${pageInfo.pageNum-1}&name=${name}&state=${state}&herfPage=${herfPage}" aria-label="Previous">
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
                                                    <a href="${APP_PATH}/admin/bug/list?pn=${pageNum}&name=${name}&state=${state}&herfPage=${herfPage}">${pageNum}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>

                                        <c:if test="${pageInfo.hasNextPage }">
                                            <li>
                                                <a href="${APP_PATH}/admin/bug/list?pn=${pageInfo.pageNum+1}&name=${name}&state=${state}&herfPage=${herfPage}" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>
                                        </c:if>

                                        <li>
                                            <a href="${APP_PATH}/admin/bug/list?pn=${pageInfo.pages}&name=${name}&state=${state}&herfPage=${herfPage}" aria-label="Next">
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
				<script type="text/javascript">
					$(function(){
						var locationHref = location.href.split('herfPage=');
						var thisPagelocationHref = locationHref[1];
						console.log(thisPagelocationHref);
						var toolsA = $('.tools > a');
						$(toolsA[thisPagelocationHref]).addClass('active');
						$(toolsA[thisPagelocationHref]).siblings().removeClass('active');
						
						$('.btn-assign').click(function(){
							$('.btn-select-assign').attr('data-bugId',$(this).parent().siblings('input.bugdisplayId').val());
						})
					})
			</script>
        </section>
        
 <!-- 模态框 -->
 <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">任务指派给？</h4>
      </div>
      <div class="modal-body">
      <table class="table table-bordered table-hover text-center">
						<thead>
							<tr>
								<th>用户名</th>
								<th>姓名</th>
								<th>部门</th>
								<th>职位</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${users}" var="user">
								<tr>
									<td>${user.userName}</td>
									<td>${user.name}</td>
									<td style="width:20%;">${user.departmentName}</td>
									<td style="width:20%;">${user.roleName}</td>
									<td>
										<!-- hidden 1 -->
										<button class="btn btn-defalut btn-success btn-sm btn-select-assign" data-assignor="${user.id}" onclick="assignTask(this);">
											<span class="glyphicon glyphicon-hand-right" style="margin-right: 10px;"></span>指派
										</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
      </div>
    </div>
  </div>
</div>
    </body>

</html>
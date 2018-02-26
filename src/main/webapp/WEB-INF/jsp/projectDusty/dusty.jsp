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
function changeState(ele) {
	var state = $(ele).attr('data-state');
	var id = $(ele).attr('data-id');
	$.ajax({
		url:"${APP_PATH}/admin/dusty/changeState",
		data:{
			'state':state,
			'id':id
		},
		type:"POST",
		success:function(result){
		}
	})
	}
function assignTask(ele) {
	var dustyId = $(ele).attr('data-dustyId');
	var assignor = $(ele).attr('data-assignor');
	$.ajax({
		url:"${APP_PATH}/admin/dusty/assignTask",
		data:{
			'dustyId':dustyId,
			'assignor':assignor
		},
		type:"POST",
		success:function(result){
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

                    <form action="${APP_PATH}/admin/demand/list" class="serach-form" method="get">

                        
						<select name="state" class="form-control">
				          <option value="需求状态">需求状态</option>
				          <option value="草稿">草稿</option>
				          <option value="激活">激活</option>
				          <option value="已变更">已变更</option>
				          <option value="待关闭">待关闭</option>
				          <option value="已关闭">已关闭</option>
       					</select>
                        <input type="text" placeholder="输入项目名称" value=" " class="form-control" name="demandName">

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
								<a href="${APP_PATH}/admin/dusty/list?herfPage=0" class="btn btn-default btn-sm">显示全部</a>
								<a href="${APP_PATH}/admin/dusty/list?herfPage=1" class="btn btn-default btn-sm active">指派给我</a>
								<a href="${APP_PATH}/admin/dusty/list?herfPage=2" class="btn btn-default btn-sm">由我创建</a>
								<a href="${APP_PATH}/admin/dusty/list?herfPage=3" class="btn btn-default btn-sm">由我解决</a>
								<a href="${APP_PATH}/admin/dusty/list?herfPage=4" class="btn btn-default btn-sm">由我关闭</a>
								<a href="${APP_PATH}/admin/dusty/list?herfPage=5" class="btn btn-default btn-sm">由我取消</a>
							</div>
							
                            <a id="addButton" type="button" class="btn btn-success btn-sm" onclick="window.location.href='${APP_PATH}/admin/dusty/addPage'">
                                <i>+</i>新任务
                            </a>
                            <a id="addButton" type="button" class="btn btn-warning btn-sm" onclick="">
                                <i>+</i>批量添加
                            </a>
                        </div>


                        <div class="clearfix"></div>
                    </div>

                    <div class="om-wrapper">
                        <div class="row">
                            <div class="col-sm-12">

                                <header class="om-wrapper-header">任务 / 总数：${pageInfo.total}</header>

                                <div class="om-wrpper-body">
                                    <form action="" id="user-list" class="user-list">
                                    <table class="table table-bordered table-striped table-project">

                                        <thead>
                                            <tr>
                                             <th>级别</th>
                                             <th>名称</th>
                                             <th>状态</th>
                                             <th>截止日期</th>
                                             <th>创建者</th>
                                             <th>指派给</th>
                                             <th>预工时</th>
                                             <th>需求</th>
                                             <th>操作</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                       		<c:forEach items="${pageInfo.list}" var="DustyDisplay">
                                                <tr>
                                                    <input value="${DustyDisplay.id}" type="hidden" class="dustyDisplayId">
                                                    <td>${DustyDisplay.grade}</td>
                                                	<td class="project-name"><a href="${APP_PATH}/admin/dusty/detailed?id=${DustyDisplay.id}">${DustyDisplay.taskName}</a></td>
                                                    <td>${DustyDisplay.state}</td>
                                                    <td>${DustyDisplay.endTime}</td>
                                                    <td>${DustyDisplay.creatPeople}</td>
                                                    <td>${DustyDisplay.assignor}</td>
                                                    <td>${DustyDisplay.workTime}</td>
                                                    <td>${DustyDisplay.demandName}</td>
                                                    <td>
                                                        <a class="btn btn-warning btn-xs btn-assign" title="指派" data-toggle="modal" data-target="#myModal">
															<i class="glyphicon glyphicon-hand-right"></i>
														</a>
														
														<a onclick="changeState(this);" data-state="进行中" data-id="${DustyDisplay.id}" class="btn btn-success btn-xs" title="开始">
															<i class="glyphicon glyphicon-triangle-right "></i>
														</a>
														
														<a onclick="changeState(this);" data-state="已完成" data-id="${DustyDisplay.id}" class="btn btn-info btn-xs" title="完成">
															<i class="glyphicon glyphicon-ok-sign "></i>
														</a>
														
														<a href="${APP_PATH}/admin/dusty/editor?id=${DustyDisplay.id}" class="btn btn-danger btn-xs" title="编辑">
															<i class="glyphicon glyphicon-edit"></i>
														</a>
														
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
                                            <a href="${APP_PATH}/admin/dusty/list?pn=1&type=${type}&state=${state}&dustyName=${dustyName}&herfPage=${herfPage}">首页</a>
                                        </li>
                                        <c:if test="${pageInfo.hasPreviousPage}">
                                            <li>
                                                <a href="${APP_PATH}/admin/dusty/list?pn=${pageInfo.pageNum-1}&type=${type}&state=${state}&dustyName=${dustyName}&herfPage=${herfPage}" aria-label="Previous">
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
                                                    <a href="${APP_PATH}/admin/dusty/list?pn=${pageNum}&type=${type}&state=${state}&dustyName=${dustyName}&herfPage=${herfPage}">${pageNum}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>

                                        <c:if test="${pageInfo.hasNextPage }">
                                            <li>
                                                <a href="${APP_PATH}/admin/dusty/list?pn=${pageInfo.pageNum+1}&type=${type}&state=${state}&dustyName=${dustyName}&herfPage=${herfPage}" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>
                                        </c:if>

                                        <li>
                                            <a href="${APP_PATH}/admin/dusty/list?pn=${pageInfo.pages}&type=${type}&state=${state}&dustyName=${dustyName}&herfPage=${herfPage}" aria-label="Next">
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
						var toolsA = $('.tools > a');
						$(toolsA[thisPagelocationHref]).addClass('active');
						$(toolsA[thisPagelocationHref]).siblings().removeClass('active');
						
						$('.btn-assign').click(function(){
							$('.btn-select-assign').attr('data-dustyId',$(this).parent().siblings('input.dustyDisplayId').val());
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
      <!-- <div class="modal-footer">
            <button data-dismiss="modal" class="btn btn-default" type="button">取消</button>
            <button class="btn btn-primary js-dialog-taskaccept" type="button">提交</button>
          </div> -->
    </div>
  </div>
</div>

    </body>

</html>
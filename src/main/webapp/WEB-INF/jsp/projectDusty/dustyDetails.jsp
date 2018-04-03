<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>项目介绍</title>

<%
   pageContext.setAttribute("APP_PATH", request.getContextPath());
	
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<link rel="stylesheet" href="${APP_PATH}/static/css/font-awesome.css">
<!-- 控制按钮的状态以及模态框展示的信息 -->
<script src="${APP_PATH}/static/js/selectAll.js"></script>
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
			$('#myModal').modal('show');
			ShowTips('.modal-title','操作结果','.modal-body','任务状态更改成功');
			setTimeout(function(){
				$('#myModal').modal('hide');
				window.location.reload();
			},1000);
		}
	})
}

function dele(ele) {
	var id = $(ele).attr('data-id');
	$.ajax({
		url:"${APP_PATH}/admin/dusty/dele",
		data:{
			'id':id
		},
		type:"POST",
		success:function(result){
			$('#myModal').modal('show');
			ShowTips('.modal-title','操作结果','.modal-body','该任务已删除');
			setTimeout(function(){
				$('#myModal').modal('hide');
				window.location.href='${APP_PATH}/admin/dusty/list';
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



                     <jsp:include page="iniUserInfo.jsp"></jsp:include>

                    <div class="clearfix"></div>

                </div>
                <!-- 页面模版，按需更改 -->
                <div class="wrapper">

                    <div class="om-header">

						<div class="om-header-left">
							<h3>
								<span class="om-title">任务管理</span>
								<jsp:include page="projectLeftManagement.jsp"></jsp:include>
							</h3>
						</div>
                        <jsp:include page="projectRightManagement.jsp"></jsp:include>
                    </div>
					
					
	      <div class="row">
	        <div class="col-md-8">
	          <div class="row">
	            <div class="col-md-12">
	              <div class="panel">
	                <div class="panel-body">
	                  <div class="profile-desk">
	                    <h1>关联项目</h1>
	                    <div class="content">${dustyDetailed.demandName}</div>
	                    <h1>任务描述</h1>
	                    <div class="content">${dustyDetailed.descs}</div>
	                    <h1>任务备注</h1>
	                    <div class="content">${dustyDetailed.remarks}</div>
	                    <h1>关联需求</h1>
	                    <div class="content">${dustyDetailed.projectName}</div>
						<input type="hidden" value="">
		                    <a class="btn btn-danger" href="${APP_PATH}/admin/dusty/detailed?id=${dustyDetailed.id}"> <i class="fa fa-check"></i> 编辑</a>&nbsp;
		                    <a onclick="dele(this);" data-id="${dustyDetailed.id}" class="btn p-follow-btn"><i class="fa fa-times"></i>删除</a>  
		                    <a onclick="changeState(this);" data-project-state="${dustyDetailed.state}" data-state="未开始" data-id="${dustyDetailed.id}" class="btn p-follow-btn">未开始</a> 
		                    <a onclick="changeState(this);" data-project-state="${dustyDetailed.state}" data-state="进行中" data-id="${dustyDetailed.id}" class="btn p-follow-btn">进行中</a> 
		                    <a onclick="changeState(this);" data-project-state="${dustyDetailed.state}" data-state="已完成" data-id="${dustyDetailed.id}" class="btn p-follow-btn">已完成</a> 
		                    <a onclick="changeState(this);" data-project-state="${dustyDetailed.state}" data-state="已暂停" data-id="${dustyDetailed.id}" class="btn p-follow-btn">已暂停</a>
		                    <a onclick="changeState(this);" data-project-state="${dustyDetailed.state}" data-state="已取消" data-id="${dustyDetailed.id}" class="btn p-follow-btn">已取消</a>
		                    <a onclick="changeState(this);" data-project-state="${dustyDetailed.state}" data-state="已关闭" data-id="${dustyDetailed.id}" class="btn p-follow-btn">已关闭</a> 
		                    <a href="${APP_PATH}/admin/dusty/clone?id=${dustyDetailed.id}" class="btn btn-warning"><i class="fa fa-files-o"></i>
		                                                                     克隆
		                    </a> 
						</div>
					</div>
	              </div>
	            </div>
	          	<div class="col-md-12">
	          		<div class="panel">
	          			<div class="panel-body">
	          				<c:if test="${dustyDetailed.fileName != null}">
	          				<div class="profile-desk">
		          				<h1>附件下载</h1>
				          		<p>
				          			<a href="${APP_PATH}/admin/dusty/down/${dustyDetailed.id}" style="color:#6bc5a4">${dustyDetailed.fileName}</a>
				          		</p>
	          				</div>
	          				</c:if>
		          			<div class="profile-desk" style="margin-top: 15px;">
		          				<h1>历史记录</h1>
				          		<ul>
				          		<c:forEach items="${dustyHistory}" var="history">
                     			 <li>${history.operationTime}  ${history.operationPeople}  ${history.operationType}</li>
				          		</c:forEach>
                    			</ul>
		          			</div>
	          			</div>
	          		</div>
	          	</div>
	          </div>
	        </div>
	        <div class="col-md-4">
	          <div class="panel">
	            <div class="panel-body">
	              <ul class="p-info">
	                <li>
	                  <div class="title">任务名称</div>
	                  <div class="desk">${dustyDetailed.taskName}</div>
	                </li>
	                <li>
	                  <div class="title">任务类型</div>
	                  <div class="desk">${dustyDetailed.taskType}</div>
	                </li>
	                <li>
	                  <div class="title">优先级</div>
	                  <div class="desk">${dustyDetailed.grade}</div>
	                </li>
	                <li>
	                  <div class="title">预计工时</div>
	                  <div class="desk">${dustyDetailed.workTime}</div>
	                </li>
	                <li>
	                  <div class="title">起止日期</div>
	                  <div class="desk">${dustyDetailed.startTime}</div>
	                </li>
	                <li>
	                  <div class="title">状态</div>
	                  <div class="desk">${dustyDetailed.state}</div>
	                </li>
	                <li>
	                  <div class="title">创建人</div>
	                  <div class="desk">${dustyDetailed.creatPeople}</div>
	                </li>
	                <li>
	                  <div class="title">指派人</div>
	                  <div class="desk">${dustyDetailed.assignor}</div>
	                </li>
	              </ul>
	            </div>
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
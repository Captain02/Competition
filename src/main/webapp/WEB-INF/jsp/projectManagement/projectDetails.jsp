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
                        <jsp:include page="projectRightManagement.jsp"></jsp:include>
                    </div>
					
					
	      <div class="row">
	        <div class="col-md-8">
	          <div class="row">
	            <div class="col-md-12">
	              <div class="panel">
	                <div class="panel-body">
	                  <div class="profile-desk">
	                    <h1>项目介绍</h1>
	                    <span class="designation">${projectDetailed.projectName}</span>
	                    <div class="content"> ${projectDetailed.descs} </div>
						<input type="hidden" value="">
		                    <a class="btn btn-danger" href="${APP_PATH}/admin/project/editor?projectId=${projectDetailed.id}"> <i class="fa fa-check"></i> 编辑</a>&nbsp; 
		                    <a onclick="changeState(this);" class="btn p-follow-btn" data-projectId="${projectDetailed.id}" data-state="挂起" data-project-state="${projectDetailed.state}" data-status="1">挂起</a> 
		                    <a onclick="changeState(this);" class="btn p-follow-btn" data-projectId="${projectDetailed.id}" data-state="延期" data-project-state="${projectDetailed.state}" data-status="2">延期</a> 
		                    <a onclick="changeState(this);" class="btn p-follow-btn" data-projectId="${projectDetailed.id}" data-state="进行" data-project-state="${projectDetailed.state}" data-status="3">进行</a> 
		                    <a onclick="changeState(this);" class="btn p-follow-btn" data-projectId="${projectDetailed.id}" data-state="结束" data-project-state="${projectDetailed.state}" data-status="4">结束</a> 
						</div>
					</div>
	              </div>
	            </div>
	          	<div class="col-md-12">
	          		<div class="panel">
	          			<div class="panel-body">
		          			<div class="profile-desk" style="margin-top: 15px;">
		          				<h1>历史记录</h1>
				          		<ul>
				          		<c:forEach items="${projectHistory}" var="history">
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
	                  <div class="title">项目名称</div>
	                  <div class="desk">${projectDetailed.projectName} </div>
	                </li>
	                <li>
	                  <div class="title">代号</div>
	                  <div class="desk">${projectDetailed.projectAliasName}</div>
	                </li>
	                <li>
	                  <div class="title">创建时间</div>
	                  <div class="desk">${projectDetailed.createDate}</div>
	                </li>
	                <li>
	                  <div class="title">起止时间</div>
	                  <div class="desk">${projectDetailed.startDate}至${projectDetailed.endDate}</div>
	                </li>
	                <li>
	                  <div class="title">可用工作日</div>
	                  <div class="desk js-workday">${subDays}天</div>
	                </li>
	                <li>
	                  <div class="title">项目负责人</div>
	                  <div class="desk">${projectDetailed.projectResponsiblePeople}</div>
	                </li>
	                <li>
	                  <div class="title">产品负责人</div>
	                  <div class="desk">${projectDetailed.productPeople}</div>
	                </li>
	                <li>
	                  <div class="title">测试负责人</div>
	                  <div class="desk">${projectDetailed.testPeople}</div>
	                </li>
	                <li>
	                  <div class="title">发布负责人</div>
	                  <div class="desk">${projectDetailed.releasePeople}</div>
	                </li>
	                <li>
	                  <div class="title">项目状态</div>
	                  <div class="desk">${projectDetailed.state}</div>
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
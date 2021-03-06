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
    <title>需求介绍</title>

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
	var demandId = $(ele).attr('data-demandId');
	alert(state);
	alert(demandId);
	$.ajax({
		url:"${APP_PATH}/admin/demand/changeState",
		data:{
			'state':state,
			'demandId':demandId
		},
		type:"POST",
		success:function(result){
			$('#myModal').modal('show');
			ShowTips('.modal-title','执行结果','.modal-body','需求状态更改成功');
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
								<span class="om-title">需求管理</span>
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
	                    <h1>需求介绍</h1>
	                    <div class="content">${demandDetailed.descs}</div>
	                    <h1>验收标准</h1>
	                    <div class="content">${demandDetailed.acceptanceStand}</div>
	                    <h1>关联项目</h1>
	                    <div class="content">${demandDetailed.projectName}</div>
		                    <a class="btn btn-danger" href="${APP_PATH}/admin/demand/editorPage?editor=${demandDetailed.id}"> <i class="fa fa-check"></i> 编辑</a>&nbsp; 
		                    <a onclick="changeState(this);" class="btn p-follow-btn" data-demandId="${demandDetailed.id}" data-state="草稿" data-project-state="${demandDetailed.state}" data-status="1">草稿</a> 
		                    <a onclick="changeState(this);" class="btn p-follow-btn" data-demandId="${demandDetailed.id}" data-state="激活" data-project-state="${demandDetailed.state}" data-status="2">激活</a> 
		                    <a onclick="changeState(this);" class="btn p-follow-btn" data-demandId="${demandDetailed.id}" data-state="已变更" data-project-state="${demandDetailed.state}" data-status="3">已变更</a> 
		                    <a onclick="changeState(this);" class="btn p-follow-btn" data-demandId="${demandDetailed.id}" data-state="待关闭" data-project-state="${demandDetailed.state}" data-status="4">待关闭</a>
		                    <a onclick="changeState(this);" class="btn p-follow-btn" data-demandId="${demandDetailed.id}" data-state="已关闭" data-project-state="${demandDetailed.state}" data-status="5">已关闭</a>  
						</div>
					</div>
	              </div>
	            </div>
	          	
	          	<div class="col-md-12">
	          		<div class="panel">
	          			<div class="panel-body">
	          				<c:if test="${bugDetailed.fileName != null}">
	          				<div class="profile-desk">
		          				<h1>附件下载</h1>
				          		<p>
				          			<a href="${APP_PATH}/admin/demand/down/${demandDetailed.id}" style="color:#6bc5a4">${demandDetailed.fileName}</a>
				          		</p>
	          				</div>
	          				</c:if>
	          			<div class="profile-desk" style="margin-top: 15px;">
		          				<h1>历史记录</h1>
				          		<ul>
				          		<c:forEach items="${demandHistory}" var="history">
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
	                  <div class="title">需求名称</div>
	                  <div class="desk">${demandDetailed.demandName}</div>
	                </li>
	                <li>
	                  <div class="title">来源</div>
	                  <div class="desk">${demandDetailed.source}</div>
	                </li>
	                <li>
	                  <div class="title">优先级</div>
	                  <div class="desk">${demandDetailed.grade}</div>
	                </li>
	                <li>
	                  <div class="title">阶段</div>
	                  <div class="desk">${demandDetailed.stage}</div>
	                </li>
	                <li>
	                  <div class="title">状态</div>
	                  <div class="desk">${demandDetailed.state}</div>
	                </li>
	                <li>
	                  <div class="title">创建人</div>
	                  <div class="desk">${demandDetailed.createPeopele}</div>
	                </li>
	                <li>
	                  <div class="title">指派人</div>
	                  <div class="desk">${demandDetailed.assignor}</div>
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
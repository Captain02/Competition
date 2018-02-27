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
    <title>项目管理</title>

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

						<div class="om-header-left">
							<h3>
								<span class="om-title">测试管理</span>
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
	                    <h1>测试描述</h1>
	                    <div class="content">${bugDetailed.descs}</div>
	                    <h1>关联需求</h1>
	                    <div class="content">${bugDetailed.demandName}</div>
	                    <h1>关联项目</h1>
	                    <div class="content">${bugDetailed.projectTaskName}</div>
						<input type="hidden" value="">
		                    <a class="btn btn-danger" href="${APP_PATH}/admin/bug/editor?bugId=${bugDetailed.id}"> <i class="fa fa-check"></i> 编辑</a>&nbsp;
		                    <a onclick="" class="btn p-follow-btn"><i class="fa fa-times"></i>删除</a>  
		                    <a onclick="changeState(this);" class="btn p-follow-btn">设计如此</a> 
		                    <a onclick="changeState(this);" class="btn p-follow-btn">重复Bug</a> 
		                    <a onclick="changeState(this);" class="btn p-follow-btn">外部原因</a> 
		                    <a onclick="changeState(this);" class="btn p-follow-btn">无法重现</a>
		                    <a onclick="changeState(this);" class="btn p-follow-btn">延期处理</a>
		                    <a onclick="changeState(this);" class="btn p-follow-btn">不予解决</a> 
						</div>
					</div>
	              </div>
	            </div>
	          	<div class="col-md-12">
	          		<div class="panel">
	          			<div class="panel-body">
	          				<div class="profile-desk">
		          				<h1>附件下载</h1>
				          		<p>
				          			<a href="" style="color:#6bc5a4">${bugDetailed.fileName == null?'无附件':bugDetailed.fileName}</a>
				          		</p>
	          				</div>
		          			<div class="profile-desk" style="margin-top: 15px;">
		          				<h1>历史记录</h1>
				          		<ul>
                     			 <li>2018-02-25 15:37 李白创建了任务</li>
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
	                  <div class="title">Bug标题</div>
	                  <div class="desk">${bugDetailed.bugTitle}</div>
	                </li>
	                <li>
	                  <div class="title">优先级</div>
	                  <div class="desk">${bugDetailed.grade}</div>
	                </li>
	                <li>
	                  <div class="title">状态</div>
	                  <div class="desk">${bugDetailed.state}</div>
	                </li>
	                <li>
	                  <div class="title">创建人</div>
	                  <div class="desk">${bugDetailed.creatPeople}</div>
	                </li>
	                <li>
	                  <div class="title">指派人</div>
	                  <div class="desk">${bugDetailed.assginor}</div>
	                </li>
	                <li>
	                  <div class="title">完成者</div>
	                  <div class="desk">${bugDetailed.completPeople}</div>
	                </li>
	                <li>
	                  <div class="title">操作系统</div>
	                  <div class="desk">${bugDetailed.operatingSystem}</div>
	                </li>
	                <li>
	                  <div class="title">浏览器</div>
	                  <div class="desk">${bugDetailed.browser}</div>
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
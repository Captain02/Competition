<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加项目成员</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
</head>
<script type="text/javascript">
function save() {
	var ids=$('#ccid').val();
	$.ajax({
		url:"${APP_PATH}/admin/projectTeam/add",
		type:"POST",
		data:{
			'ids':ids
		},
		success : function(result) {
			
		}
	})
}
</script>

<body class="bg-common stickey-menu">
	<section>
		<!-- 页面模版，每页左侧区域固定不变 -->
		<jsp:include page="iniLeftMenu.jsp"></jsp:include>
		<div class="main-content">
			<!-- 页面模版，每页主体部分头部按需更改 -->
			<div class="content-head content-head-section">
				<a href="" class="toggle-btn"> <span
					class="glyphicon glyphicon-th-list"></span>
				</a>
				<jsp:include page="iniUserInfo.jsp"></jsp:include>
				<div class="clearfix"></div>

			</div>
			<div class="wrapper">
				 <div class="om-header">

						<div class="om-header-left">
							<h3>
								<span class="om-title">项目管理</span>
								<jsp:include page="projectLeftManagement.jsp"></jsp:include>
							</h3>
						</div>
                    </div>
				
				<div class="row">
				<div class="col-lg-12">
					<section class="panel">
						<header class="panel-heading">添加项目成员</header>
						<div class="panel-body">
						<form id="topicText" action="" method="post">
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>姓名</label>
								<div class="col-sm-10">
									<input class="form-control" id="cc-username" type="text" placeholder="点击添加成员"/>
								</div>
							</div>
							<div class="form-group">
			                  <label class="col-lg-2 col-sm-2 control-label"></label>
			                  <div class="col-lg-10">
			                    <button type="button" onclick="save()" class="btn btn-primary">添加成员</button>
			                    <input type="hidden" id="ccid"/>
			                  </div>
			                </div>
						</form>
						</div>
					</section>
				</div>
					
				</div>
				
			</div>
			
		</div>
		<!-- 模态框 -->
		 <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">成员名单</h4>
		      </div>
		      
		      <div class="modal-body">
		      	<ul class="white-name-list clearfix">
		      		<c:forEach items="${users}" var="user">
		      		 <li>
		      		 	<div class="form-group">
			      		 		<label class="checkbox-inline">
	     								<input class="resourceId" value="${user.name}" type="checkbox" data-userid="${user.id}" name="whiteListName">
	   									${user.name}
	  							</label>
		      		 	</div>
		      		 </li>
			       	</c:forEach>	
		    
		      	</ul>
		      
		      </div>
		      <div class="modal-footer">
		      
		      	<button type="button" class="btn btn-default no" data-dismiss="modal">取消</button>
		        <button type="button" class="btn btn-primary yes-add">确认</button>
		        
		      </div>
		    </div>
		  </div>
		</div>
		
	</section>
</body>
</html>
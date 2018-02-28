<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加新流程</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<script type="text/javascript">
	function saveDeploy() {
		var formData = new FormData($("#fileForm")[0]);
		$.ajax({
			url : "${APP_PATH}/admin/deploy/add",
			type : "POST",
			data : formData,
			processData : false,
			contentType : false,
			success : function(result) {
				console.log(result);
			}
		})
	}
	
</script>

</head>
	<body class="bg-common stickey-menu">
		<section>
	
		<!-- 页面模版，每页左侧区域固定不变 --> <!-- 页面模版，每页左侧区域固定不变 --> 
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
	
			<!-- 页面模版，按需更改 -->
			<div class="wrapper">
	
				<div class="row">
					<div class="om-header">
						<div class="om-header-left">
							<h3>
								<span class="om-title">流程管理</span> <span class="om-list">
									<a href="${APP_PATH}/admin/deploy/list">流程部署</a>
                                    <a href="${APP_PATH}/admin/processDefinition/list">流程定义</a>
	
								</span>
							</h3>
						</div>
						<div class="clearfix"></div>
					</div>
	
					<div class="om-wrapper">
						<div class="row">
							<div class="col-sm-12">
	
								<header class="om-wrapper-header">添加新流程</header>
	
								<div class="om-wrpper-body">
									<form action="" id="fileForm" enctype="multipart/form-data">
									<div class="form-group">
                                                    <div class="col-sm-2">
                                                        <label for="" class="control-label" style="text-align: left">
                                                           	 选择流程文件
                                                        </label>
                                                    </div>
                                                    <div class="col-sm-10">
                                                        <input id="file" name="file" type="file">
                                                    </div>

                                                </div>
                                                <div class="form-group">
                                                    <div class="col-sm-2">
                                                        <label for="" class="control-label" style="text-align: left">
                                                           	进行审批的总人数
                                                        </label>
                                                    </div>
                                                    <div class="col-sm-10">
                                                        <input name="num" type="number" class="form-control">
                                                    </div>

                                                </div>
                                                <div class="form-group">
                                                    <div class="col-sm-2">
                                                        <label for="" class="control-label" style="text-align: left">
                                                           	<input type="button" onclick="saveDeploy()" value="上传" class="btn btn-defult btn-success">
                                                        </label>
                                                    </div>
                                                </div>
									</form>
								</div>
	
							</div>
	
						</div>
	
	
	
					</div>
	
				</div>
	
			</div>
		</div>
		</section>
	
	</body>

</body>
</html>
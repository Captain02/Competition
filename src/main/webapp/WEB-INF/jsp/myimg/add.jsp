<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上传图片</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>

<link href="${APP_PATH}/static/bootstrap-fileinput/css/fileinput.min.css" rel="stylesheet">

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
				<div class="om-wrapper">
					<div class="row">
						<div class="col-sm-12">

							<header class="om-wrapper-header">
								上传相片
								<div class="pull-right">
									
									<a href="${APP_PATH}/admin/image/list" class="btn btn-success btn-sm">欣赏相片</a>
								</div>
							</header>
							<form id="uploadForm" action="" >
								<div class="om-wrpper-body">
								
							    	<div class="col-lg-12">
							    		<div class="panel">
							    			<div class="panel-body">
							    				<div class="text-center">
							    					<h2>请选择图片</h2>
							    					<input id="albumUpload" name="uploadFiles" multiple="" class="" accept="image/*" data-allowed-file-extensions="[&quot;jpg&quot;, &quot;jpeg&quot;, &quot;png&quot;, &quot;gif&quot;]" type="file" />
							    				</div>
							    			</div>
							    		</div>
							    	</div>
								
								</div>
							</form>

						</div>

					</div>



				</div>

			</div>

		</div>
	</section>
	
	<script src="${APP_PATH}/static/bootstrap-fileinput/js/plugins/sortable.min.js"></script>
	<script src="${APP_PATH}/static/bootstrap-fileinput/js/plugins/purify.min.js"></script>
	<script src="${APP_PATH}/static/bootstrap-fileinput/js/fileinput.min.js"></script>
	<script src="${APP_PATH}/static/bootstrap-fileinput/themes/fa/theme.min.js"></script>
	<script src="${APP_PATH}/static/bootstrap-fileinput/js/locales/zh.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#albumUpload").fileinput({ 
				language: 'zh', 
				showCaption: true,
				allowedFileExtensions: ['jpg', 'gif', 'png'],
				uploadUrl:"${APP_PATH}/admin/image/upImage",
				maxFileCount:10,
				msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
			    showUpload:true,
			    showRemove :true,
			    showPreview :true,
			    showCancel :true
			}).on("fileuploaded", function (event, data, previewId, index){
		});
		});
	</script>
	

</body>
</html>
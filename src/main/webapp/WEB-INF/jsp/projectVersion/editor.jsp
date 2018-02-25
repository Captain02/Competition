<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加需求</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>



<jsp:include page="iniCssHref.jsp"></jsp:include>
<link rel="stylesheet" href="${APP_PATH}/static/css/font-awesome.css">
<link rel="stylesheet" href="${APP_PATH}/static/kindeditor/themes/default/default.css">
<script src="${APP_PATH}/static/kindeditor/kindeditor-all-min.js"></script>
<script src="${APP_PATH}/static/kindeditor/lang/zh-CN.js"></script>

<!--初始化kindEditor配置 -->
<script type="text/javascript">
$(function(){
	var editor = KindEditor.create('textarea[name="descs"],textarea[name="acceptanceStand"]',{
		allowFileManager : true,
		filterMode:false,
		allowImageUpload : true,
		uploadJson:'${APP_PATH}/static/kindeditor/jsp/upload_json.jsp',
		fileManagerJson : '${APP_PATH}/static/kindeditor/jsp/file_manager_json.jsp',
		afterBlur:function(){
			this.sync();}
		});
	});
	$('.ke-container').css('width','100%');

function save() {
	var formData = new FormData($("#demandForm")[0]);
	//发送ajax请求
	  $.ajax({
		url:"${APP_PATH}/admin/version/editor",
		type:"POST",
		data:formData,
        contentType: false,  
        processData: false, 
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
								<span class="om-title">版本管理</span>
								<jsp:include page="projectLeftManagement.jsp"></jsp:include>
							</h3>
						</div>
                        <div class="clearfix"></div>
                    </div>
				
				<div class="row">
				<div class="col-lg-12">
					<section class="panel">
						<header class="panel-heading">添加版本</header>
						<div class="panel-body">
						<form id="demandForm" action="" method="post">
						<input type="hidden" value="${version.id}" name="id">
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>版本名称</label>
								<div class="col-sm-10">
									<input name="versionName" value="${version.versionName}" class="form-control" placeholder="填写版本名称" type="text">
								</div>
							</div>
							
							<div class="form-group">
								<label for="" class="col-sm-2 control-label">打包日期</label>
								<div class="col-sm-10">
									<input name="versionTime" value="${version.versionTime}" class="form-control" placeholder="打包日期" type="text">
								</div>
							</div>
							
							<div class="form-group">
								<label for="" class="col-sm-2 control-label">源代码地址</label>
								<div class="col-sm-10">
									<input name="sourceAddress" value="${version.sourceAddress}" class="form-control" placeholder="http://" type="text">
								</div>
							</div>
							
							<div class="form-group">
								<label for="" class="col-sm-2 control-label">下载地址</label>
								<div class="col-sm-10">
									<input name="downLoadAddress" value="${version.downLoadAddress}" class="form-control" placeholder="http://" type="text">
								</div>
							</div>
							
							<div class="form-group">
                                 <label class="col-sm-2 col-sm-2 control-label" style="padding-top: 2px;">上传发行包</label>
                                 <div class="col-sm-10">
                                     <input id="file" type="file" name="file">
                                 </div>
                              </div>
                              
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>描述</label>
								<div class="col-sm-10">
									<textarea id="editor_id" name="descs" class="form-control" style="height: 400px;" placeholder="请填写内容">${version.descs}</textarea>
								</div>
							</div>
							
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"></label>
								<div class="col-sm-10">
									<button type="button" onclick="save()"  class="btn btn-success">提交</button>
								</div>
						</div>
						</form>
						</div>
					</section>
				</div>
					
				</div>
				
			</div>
			
		</div>
	</section>
</body>
</html>
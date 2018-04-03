<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>项目管理</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>



<jsp:include page="iniCssHref.jsp"></jsp:include>
<link rel="stylesheet" href="${APP_PATH}/static/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" href="${APP_PATH}/static/css/font-awesome.css">
<link rel="stylesheet" href="${APP_PATH}/static/kindeditor/themes/default/default.css">
<script src="${APP_PATH}/static/kindeditor/kindeditor-all-min.js"></script>
<script src="${APP_PATH}/static/kindeditor/lang/zh-CN.js"></script>
<script src="${APP_PATH}/static/js/regAjax.js"></script>

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
	//判定页面上是否有错误信息
	ifErrorMessage();
	 if ($('.save-button').attr("ajax-va") == "error") {
	        return false;
	    }
	var formData = new FormData($("#versionForm")[0]);
	//发送ajax请求
	  $.ajax({
		url:"${APP_PATH}/admin/version/add",
		type:"POST",
		data:formData,
        contentType: false,  
        processData: false, 
		success:function(result){
			if (result.code == 100) {
				$('#myModal').modal('show');
				ShowTips('.modal-title','添加结果','.modal-body','成功添加一个新版本');
				setTimeout(function(){
					$('#myModal').modal('hide');
					window.location.href='${APP_PATH}/admin/version/list';
				},1000);
			}else{
				if (undefined != result.extend.errorFields.descs) {
	           		 $('#myModal').modal('show');
						ShowTips('.modal-title','错误的操作','.modal-body','描述不为空');
						setTimeout(function(){
							$('#myModal').modal('hide');
						},3000); 
				}
			}
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
						<form id="versionForm" action="" method="post">
						
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>版本名称</label>
								<div class="col-sm-10">
									<input name="versionName" value="" class="form-control" id="name" placeholder="填写版本名称" type="text">
									<span></span>
								</div>
							</div>
							
							<div class="form-group">
								<label for="" class="col-sm-2 control-label">打包日期</label>
								<div class="col-sm-10">
									<input name="versionTime" value="" class="form-control dpd1" placeholder="打包日期" type="text">
								</div>
							</div>
							
							<div class="form-group">
								<label for="" class="col-sm-2 control-label">源代码地址</label>
								<div class="col-sm-10">
									<input name="sourceAddress" value="" class="form-control" placeholder="http://" type="text">
								</div>
							</div>
							
							<div class="form-group">
								<label for="" class="col-sm-2 control-label">下载地址</label>
								<div class="col-sm-10">
									<input name="downLoadAddress" value="" class="form-control" placeholder="http://" type="text">
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
									<textarea id="editor_id" name="descs" class="form-control" style="height: 400px;" placeholder="请填写内容"></textarea>
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
					</section>
				</div>
					
				</div>
				
			</div>
			
		</div>
		<script src="${APP_PATH}/static/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
			 		<script src="${APP_PATH}/static/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
			 		<script type="text/javascript">
			 		 $(function(){
			 			 var checkin = $('.dpd1').datetimepicker({
			 				 format: 'yyyy-mm-dd',
			 				 maxView:'year',
			 				 minView:'month',
			 				 language:'zh-CN'
			 			 }).on('changeDate', function(ev) {
			 				$('.dpd1').datetimepicker('hide'); 
			 			 })
			 			
			 		 })
			 		</script>
	</section>
</body>
</html>
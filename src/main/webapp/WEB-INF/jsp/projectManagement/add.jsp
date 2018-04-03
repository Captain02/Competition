<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加项目</title>
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
	var editor = KindEditor.create('textarea[name="content"]', {
		allowFileManager : true,
		filterMode:false,
		allowImageUpload : true,
		uploadJson:'${APP_PATH}/static/kindeditor/jsp/upload_json.jsp',
		fileManagerJson : '${APP_PATH}/static/kindeditor/jsp/file_manager_json.jsp',
		afterBlur:function(){
			this.sync();
		}
	});
	$('.ke-container').css('width','100%');
})

function save() {
	ifErrorMessage();
	 if ($('.save-button').attr("ajax-va") == "error") {
	        return false;
	    }
	//获取项目名称
	var projectName = $('input[name="projectName"]').val();
	//获取项目别名
	var projectAlias = $('input[name="projectAlias"]').val();
	//开始日期
	var projectStartDate = $('input[name="startDate"]').val();
	//结束日期
	var projectEndDate = $('input[name="endDate"]').val();
	//获取描述
	var projectDesc = $('#editor_id').val();
	$.ajax({
		url:"${APP_PATH}/admin/project/add",
		type:"POST",
		data:{
			'projectName':projectName,
			'projectAlias':projectAlias,
			'projectStartDate':projectStartDate,
			'projectEndDate':projectEndDate,
			'projectDesc':projectDesc
		},
		success:function(result){
			if (result.code == 100) {
				$('#myModal').modal('show');
				$('.modal-footer').remove();
				ShowTips('.modal-title','添加结果','.modal-body','成功创建一个项目');
				setTimeout(function(){
					$('#myModal').modal('hide');
					window.location.href='${APP_PATH}/admin/project/list';
				},1000);
			}else{
				if (undefined != result.extend.errorFields) {
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
							<span class="om-title">项目管理</span> <span class="om-list"></span>
						</h3>
					</div>
					<div class="clearfix"></div>
				</div>
				
				<div class="row">
				<div class="col-lg-12">
					<section class="panel">
						<header class="panel-heading">添加项目</header>
						<div class="panel-body">
						<form id="topicText" action="" method="post">
						
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>项目名称</label>
								<div class="col-sm-10">
									<input class="form-control" id="name" name="projectName" value=""  placeholder="填写名称" type="text">
									<span></span>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>项目别名</label>
								<div class="col-sm-10">
									<input class="form-control" id="nameAlias" name="projectAlias" value=""  placeholder="取个别名" type="text">
									<span></span>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label">开始和结束日期</label>
								<div class="col-sm-10">
									<div class="input-group input-large" data-date-format="yyyy-mm-dd">
					                      <input value="${projectDetailed.startDate}" class="form-control dpd1" name="startDate" placeholder="开始日期"  type="text">
					                      <span class="input-group-addon">To</span>
					                      <input value="${projectDetailed.endDate}" class="form-control dpd2" name="endDate" placeholder="结束日期" type="text">
                    				</div>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>描述</label>
								<div class="col-sm-10">
									<textarea id="editor_id" name="content" class="form-control" style="height: 400px;" placeholder="请填写内容"></textarea>
									<span></span>
								</div>
							</div>
							
							
							<div class="form-group">
							<label for="" class="col-sm-2 control-label"></label>
							<div class="col-sm-10">
								<button type="button" onclick="save()"  class="btn btn-success save-button">提交</button>
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
			 	            $('.dpd2')[0].focus();
			 			 })
			 			
			            
			 			 var checkout = $('.dpd2').datetimepicker({
			 				 format: 'yyyy-mm-dd',
			 				 maxView:'year',
			 				 minView:'month',
			 			     language:'zh-CN'
			 			 }).on('changeDate', function(ev) {
				 				$('.dpd2').datetimepicker('hide');
				 			 })
			 		 })
			 		</script>
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
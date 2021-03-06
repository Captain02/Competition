<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>知识分享</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
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


//在这里发送ajax请求，保存添加的知识
function save() {
	//判定页面上是否有错误信息
	ifErrorMessage();
	 if ($('.save-button').attr("ajax-va") == "error") {
	        return false;
	}
	//获取标题内容
	var title = $("input[name='title']").val();
	//获取简介内容
	var sketch = $("textarea[name='sketch']").val();
	//获取文本编辑器中的内容
	var html = $('#editor_id').val();
	//获取勾选的复选框的值
	var order = '';
	var ifHavechecked = $('.checkbox label input[type="checkbox"]:checked');
	for(var i = 0;i<ifHavechecked.length; i++){
		if(i == ifHavechecked.length-1){
			order+=$(ifHavechecked[i]).val();
		}
		else{
			order+=$(ifHavechecked[i]).val() + '-';
		}
		
	}
	
	 $.ajax({
		url:"${APP_PATH}/admin/KnowledgeSharing/add",
		type:"POST",
		data:{
			'title':title,
			'sketch':sketch,
			'text':html,
			'order':order,
			'isUpdate':0
		},
		success:function(result){
			$('#myModal').modal('show');
			ShowTips('.modal-title','添加结果','.modal-body','成功分享一个知识');
			setTimeout(function(){
				$('#myModal').modal('hide');
				window.location.href='${APP_PATH}/admin/KnowledgeSharing/list';
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
							<span class="om-title">知识分享</span> <span class="om-list"></span>
						</h3>
					</div>
					<div class="clearfix"></div>
				</div>
				
				<div class="row">
				<div class="col-lg-12">
					<section class="panel">
						<header class="panel-heading"></header>
						<div class="panel-body">
						<form id="topicText" action="" method="post">
						
							<div class="form-group">
								<label for="" class="col-sm-2 control-label">标题</label>
								<div class="col-sm-10">
									<input name="title" value="" class="form-control notNull" placeholder="填写标签" type="text">
									<span></span>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label">简介</label>
								<div class="col-sm-10">
									<textarea name="sketch" placeholder="请填写简介" style="height:90px;" class="form-control notNull"></textarea>
									<span></span>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>内容</label>
								<div class="col-sm-10">
									<textarea id="editor_id" name="content" class="form-control" style="height: 400px;" placeholder="请填写内容"></textarea>
								</div>
							</div>
							
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>类别</label>
								<div class="col-sm-10">
									<div class="checkbox" style="margin-top: 5px;">
									
									<c:forEach items="${bbsLabel}" var="labels">
										<label class="checkbox-inline">
											<input value="${labels.id}"  type="checkbox">${labels.name}
										</label>
									</c:forEach>
									
      							
      								</div>
    								
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
</body>
</html>
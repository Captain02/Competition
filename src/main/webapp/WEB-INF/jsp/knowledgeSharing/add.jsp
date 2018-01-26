<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>知识分享</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<link rel="stylesheet" href="${APP_PATH}/static/css/font-awesome.css">
<link rel="stylesheet" href="${APP_PATH}/static/kindeditor/themes/default/default.css">
<script src="${APP_PATH}/static/kindeditor/kindeditor-all-min.js"></script>
<!--初始化kindEditor配置 -->
<script type="text/javascript">

$(function(){
	
	var editor = KindEditor.create('textarea[name="content"]', {
		allowFileManager : true,
		afterBlur:function(){
			this.sync();
			$('#content_value').html($('#editor_id').val());
		}
	});
})


//在这里发送ajax请求，保存添加的知识
function save() {
	var html = $('#content_value').html();
	var topicText = $("#topicText").serialize();
	console.log(topicText);
	
	$.ajax({
		url:"${APP_PATH}/admin/KnowledgeSharing/add",
		type:"POST",
		data:$("#topicText").serialize(),
		success:function(result){
			alert("添加成功");
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
								<label for="" class="col-sm-2 control-label"><span>*</span>类别</label>
								<div class="col-sm-10">
									<div class="checkbox" style="margin-top: 5px;">
									<label class="checkbox-inline">
										<input value="企业文化" checked="checked" type="checkbox">知识列表
									</label>
										<label class="checkbox-inline">
										<input value="管理知识" type="checkbox">管理知识
									</label>
									<label class="checkbox-inline">
										<input value="财务知识" type="checkbox">财务知识
									</label>
									<label class="checkbox-inline">
										<input value="技术分享" type="checkbox">技术分享
									</label>
									<label class="checkbox-inline">
										<input value="服务器" type="checkbox">服务器
									</label>
									<label class="checkbox-inline">
										<input value="市场营销" type="checkbox">市场营销
									</label>
									<label class="checkbox-inline">
										<input value="运营" type="checkbox">运营
									</label>
									<label class="checkbox-inline">
										<input value="随笔" type="checkbox">随笔
									</label>
									
									
									
									
      							
      								</div>
    								
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>标题</label>
								<div class="col-sm-10">
									<input name="title" value="" class="form-control" placeholder="请填写标题" type="text">
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label">标签</label>
								<div class="col-sm-10">
									<input name="tag" value="" class="form-control" placeholder="填写标签" type="text">
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label">简介</label>
								<div class="col-sm-10">
									<textarea name="sketch" placeholder="请填写简介" style="height:90px;" class="form-control"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>内容</label>
								<div class="col-sm-10">
									<textarea id="editor_id" name="content" class="form-control" style="height: 400px;" placeholder="请填写内容"></textarea>
								</div>
								
								<!--存放文本编辑器中的内容 -->
								<textarea  id="content_value" name="content_value"  style="height:90px; display: none;" class="form-control"></textarea>
								
								
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
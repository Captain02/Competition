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
var html = "";

$(function(){
	
	var editor = KindEditor.create('textarea[name="content"]', {
		allowFileManager : true,
		afterBlur:function(){
			this.sync();
			html = $('#editor_id').val();
			console.log(html);
		}
	});
})


//在这里发送ajax请求，保存添加的知识
function save() {
	var topicText = $("#topicText").serialize();
	console.log(topicText);
	
	$.ajax({
		url:"${APP_PATH}/admin/KnowledgeSharing/add",
		type:"POST",
		data:{'text':html,
			  'bbsTopic':topicText
		},
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
									<select name="" class="form-control">
					                      <option value="">请选择分类</option>                      
															
					                      <option value="1">企业文化</option> 
															
					                      <option value="2">管理知识</option> 
															
					                      <option value="3">财务知识</option> 
															
					                      <option value="4">技术分享</option> 
															
					                      <option value="5">服务器</option> 
															
					                      <option value="6">市场营销</option> 
															
					                      <option value="7">运营</option> 
															
					                      <option value="8">随笔</option> 
										
                    				</select>
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
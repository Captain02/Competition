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

<link rel="stylesheet" href="${APP_PATH}/static/js/Data/css/dcalendar.picker.css">
<link rel="stylesheet" href="${APP_PATH}/static/js/Data/css/zzsc.css">

<jsp:include page="iniCssHref.jsp"></jsp:include>
<link rel="stylesheet" href="${APP_PATH}/static/css/font-awesome.css">
<link rel="stylesheet" href="${APP_PATH}/static/kindeditor/themes/default/default.css">
<script src="${APP_PATH}/static/kindeditor/kindeditor-all-min.js"></script>
<script src="${APP_PATH}/static/kindeditor/lang/zh-CN.js"></script>

<!--初始化kindEditor配置 -->
<script type="text/javascript">
$(function(){
	var editor = KindEditor.create('textarea[name="descs"],textarea[name="acceptance"]',{
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
	//获取项目名称
	var projectName = $('input[name="projectName"]').val();
	//获取项目别名
	var projectAlias = $('input[name="projectAlias"]').val();
	//开始日期
	var projectStartDate = $('input[name="started"]').val();
	//结束日期
	var projectEndDate = $('input[name="ended"]').val();
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
                                <span class="om-title">项目管理</span>
                                <span class="om-list pro-href"> 
									<a class="btn btn-info btn-sm">团队</a> 
									<a class="btn btn-danger btn-sm">需求</a>
									<a class="btn btn-primary btn-sm">任务</a> 
									<a class="btn btn-warning btn-sm">Bug</a> 
									<a class="btn btn-success btn-sm">文档</a>
									<a class="btn btn-danger btn-sm">版本</a>
									<a class="btn btn-warning btn-sm">报表</a>
								</span>
                            </h3>
                        </div>
					<div class="clearfix"></div>
				</div>
				
				<div class="row">
				<div class="col-lg-12">
					<section class="panel">
						<header class="panel-heading">添加需求</header>
						<div class="panel-body">
						<form id="topicText" action="" method="post">
						
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>需求名称</label>
								<div class="col-sm-10">
									<input name="demandName" value="" class="form-control" placeholder="填写需求名称" type="text">
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>来源</label>
								<div class="col-sm-10">
									<select name="source" class="form-control">
					                      <option value="">请选择来源</option>
					                      <option value="1">客户</option>
					                      <option value="2">用户</option>
					                      <option value="3">产品经理</option>
					                      <option value="4">市场</option>
					                      <option value="5">客服</option>
					                      <option value="6">竞争对手</option>
					                      <option value="7">合作伙伴</option>
					                      <option value="8">开发人员</option>
					                      <option value="9">测试人员</option>
					                      <option value="10">其他</option>
                   					</select>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>优先级</label>
								<div class="col-sm-10">
									<select name="grade" class="form-control">
				                      <option value="">请选择优先级</option>
				                      <option value="1">1级</option>
				                      <option value="2">2级</option>
				                      <option value="3">3级</option>
				                      <option value="4">4级</option>	
                    				</select>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>阶段</label>
								<div class="col-sm-10">
								<select name="stage" class="form-control">
			                      <option value="">请选择阶段</option>
			                      <option value="1">未开始</option>
			                      <option value="2">已计划</option>
			                      <option value="3">已立项</option>
			                      <option value="4">研发中</option>
			                      <option value="5">研发完毕</option>
			                      <option value="6">测试中</option>
			                      <option value="7">测试完毕</option>
			                      <option value="8">已验收</option>
			                      <option value="9">已发布</option>
                    			</select>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>指派给</label>
								<div class="col-sm-10">
								<select name="assignor" class="form-control">
			                     
                    			</select>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label">预计工时</label>
								<div class="col-sm-10">
									<input name="wrokTime" value="" class="form-control" placeholder="预计工时" type="text">
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>描述</label>
								<div class="col-sm-10">
									<textarea id="editor_id" name="descs" class="form-control" style="height: 400px;" placeholder="请填写内容"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>验收标准</label>
								<div class="col-sm-10">
									<textarea id="editor_id" name="acceptance" class="form-control" style="height: 300px;" placeholder="请填写内容"></textarea>
								</div>
							</div>
							  <div class="form-group">
                                 <label class="col-sm-2 col-sm-2 control-label" style="padding-top: 2px;">上传附件</label>
                                 <div class="col-sm-10">
                                     <input id="file" type="file" name="fileName">
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
			 <script type="text/javascript" src="${APP_PATH}/static/js/Data/js/dcalendar.picker.js"></script>
                    <script type="text/javascript">
                        $('#mydatepicker').dcalendarpicker({
                            format: 'yyyy-mm-dd'
                        });
                        $('#mydatepicker2').dcalendarpicker({
                            format: 'yyyy-mm-dd'
                        });
                        $('#mycalendar').dcalendar();
                    </script>
		</div>
	</section>
</body>
</html>
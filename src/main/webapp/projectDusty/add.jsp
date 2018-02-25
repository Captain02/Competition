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
<script src="${APP_PATH}/static/js/activeShowProcessPerson.js"></script>
<script src="${APP_PATH}/static/js/addPerson.js"></script>
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
								<span class="om-title">任务管理</span>
								<jsp:include page="projectLeftManagement.jsp"></jsp:include>
							</h3>
						</div>
                    </div>
				
				<div class="row">
				<div class="col-lg-12">
					<section class="panel">
						<header class="panel-heading">添加任务</header>
						<div class="panel-body">
						<form id="demandForm" action="" method="post">
						
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>关联需求</label>
								<div class="col-sm-10">
									<select name="needsid" class="form-control">
				                      <option value="">请选择项目需求</option> 
		                    		</select>
								</div>
							</div>
							
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>任务类型</label>
								<div class="col-sm-10">
									<select name="taskType" class="form-control">
				                      <option value="">请选择任务类型</option>
				                    </select>
								</div>
							</div>
							
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>指派给</label>
								<div class="col-sm-10">
								<select name="assignor" class="form-control">
									<option value="">请选择指派人</option>
								</select>
								</div>
							</div>
							
							<div class="form-group">
								<label for="" class="col-sm-2 control-label">任务名称</label>
								<div class="col-sm-10">
									<input name="workTime" value="" class="form-control" placeholder="任务名称" type="text">
								</div>
							</div>
							
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>描述</label>
								<div class="col-sm-10">
									<textarea id="editor_id" name="descs" class="form-control" style="height: 400px;" placeholder="请填写内容"></textarea>
								</div>
							</div>
							
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>备注</label>
								<div class="col-sm-10">
									<textarea id="editor_id" name="acceptanceStand" class="form-control" style="height: 300px;" placeholder="请填写内容"></textarea>
								</div>
							</div>
							
							<div class="form-group">
			                  <label class="col-sm-2 col-sm-2 control-label">优先级</label>
			                  <div class="col-sm-10">
			                    <select name="level" class="form-control">
			                      <option value="">请选择优先级</option>
			                      <option value="1">1级</option>
			                      <option value="2">2级</option>
			                      <option value="3">3级</option>
			                      <option value="4">4级</option>
			                    </select>
			                  </div>
                		</div>
                		
                		<div class="form-group">
							<label for="" class="col-sm-2 control-label">预计工时</label>
							<div class="col-sm-10">
								<input name="workTime" value="" class="form-control" placeholder="任务名称" type="text">
							</div>
						</div>
						
						<div class="form-group">
							<label for="" class="col-sm-2 control-label">开始和结束日期</label>
							<div class="col-sm-10">
								<div class="input-group input-large" data-date-format="yyyy-mm-dd">
				                      <input value="" class="form-control dpd1" name="startDate" placeholder="开始日期"  type="text">
				                      <span class="input-group-addon">To</span>
				                      <input value="" class="form-control dpd2" name="endDate" placeholder="结束日期" type="text">
                   				</div>
							</div>
						</div>
						
						<div class="form-group">
                            <div class="col-sm-2">
                                <label for="" class="control-label">
                                   	 流程选择
                                </label>
                            </div>
                            
                            <div class="col-sm-10">
                                 <select name="processDefinitionKey" class="form-control selectProcessKey">
                                    <option value="tip" style="display: none;">请选择一个审批流程</option>
                                </select>
                                
                                <p class="processTips noProcessPerson">
                                	选择了<span class="processName"></span>流程，
                                	请添加<span class="processPersonNum"></span>位审批人
                                </p>
                            </div>
                          </div>
                          
                          <div class="form-group addprocessPerson noProcessPerson">
                              <div class="col-sm-2">
                                  <label for="" class="control-label text-center">
                                     	 审批人（点击可删除）
                                  </label>
                              </div>
                              <div class="col-sm-10">

                                  <!-- 填入点击的审批人信息 -->
                                  <div class="person-name-area person-name-list">

                                  </div>


                                  <span class="glyphicon glyphicon-plus-sign btn-person"></span>

                                  <div class="clearfix"></div>

                              </div>

                            </div>
							
						  <div class="form-group">
                                <label class="col-sm-2 col-sm-2 control-label" style="padding-top: 2px;">上传附件</label>
                                <div class="col-sm-10">
                                    <input id="file" type="file" name="file">
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
		</div>
	</section>
</body>
</html>
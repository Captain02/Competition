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
	var editor = KindEditor.create('textarea[name="descs"],textarea[name="remarks"]',{
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
	//抄送人id
	//var copyToUserId = $('#ccid')
	var formData = new FormData($("#DustyForm")[0]);
	//发送ajax请求
	  $.ajax({
		url:"${APP_PATH}/admin/dusty/add",
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
						<form id="DustyForm" action="" method="post">
						
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>关联需求</label>
								<div class="col-sm-10">
									<select name="demandId" class="form-control">
										<option value="${singleDemand.id}">${singleDemand.demandName}</option>
				                      <c:forEach items="${demands}" var="demand">
										<option value="${demand.id}">${demand.demandName}</option>
									</c:forEach>
		                    		</select>
								</div>
							</div>
							
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>任务类型</label>
								<div class="col-sm-10">
									<select name="taskType" class="form-control">
				                      <option value="${dustyDetailed.taskType}" >${dustyDetailed.taskType}</option>
				                      <option value="设计" >设计</option>
							          <option value="开发" >开发</option>
							          <option value="测试" >测试</option>
							          <option value="研究" >研究</option>
							          <option value="讨论" >讨论</option>
							          <option value="界面" >界面</option>
							          <option value="事务" >事务</option>
							          <option value="其他" >其他</option>
				                    </select>
								</div>
							</div>
							
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>指派给</label>
								<div class="col-sm-10">
								<select name="assignor" class="form-control">
									<c:forEach items="${team}" var="user">
										<option value="${user.id}">${user.name}</option>
									</c:forEach>
								</select>
								</div>
							</div>
							
							<div class="form-group">
								<label for="" class="col-sm-2 control-label">任务名称</label>
								<div class="col-sm-10">
									<input name="taskName" value="${dustyDetailed.taskName}" class="form-control" placeholder="任务名称" type="text">
								</div>
							</div>
							
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>描述</label>
								<div class="col-sm-10">
									<textarea id="editor_id" name="descs" class="form-control" style="height: 400px;" placeholder="请填写内容">${dustyDetailed.descs}</textarea>
								</div>
							</div>
							
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>备注</label>
								<div class="col-sm-10">
									<textarea id="editor_id" name="remarks" class="form-control" style="height: 300px;" placeholder="请填写内容">${dustyDetailed.remarks}</textarea>
								</div>
							</div>
							
							<div class="form-group">
			                  <label class="col-sm-2 col-sm-2 control-label">优先级</label>
			                  <div class="col-sm-10">
			                    <select name="grade" class="form-control">
			                      <option value="${dustyDetailed.grade}">${dustyDetailed.grade}</option>
			                      <option value="1级">1级</option>
			                      <option value="2级">2级</option>
			                      <option value="3级">3级</option>
			                      <option value="4级">4级</option>
			                    </select>
			                  </div>
                		</div>
                		
                		<div class="form-group">
							<label for="" class="col-sm-2 control-label">预计工时</label>
							<div class="col-sm-10">
								<input name="workTime" value="${dustyDetailed.workTime}" class="form-control" placeholder="预计工时" type="text">
							</div>
						</div>
						
						<div class="form-group">
							<label for="" class="col-sm-2 control-label">开始和结束日期</label>
							<div class="col-sm-10">
								<div class="input-group input-large" data-date-format="yyyy-mm-dd">
				                      <input value="${dustyDetailed.startTime}" class="form-control dpd1" name="startTime" placeholder="开始日期"  type="text">
				                      <span class="input-group-addon">To</span>
				                      <input value="${dustyDetailed.endTime}" class="form-control dpd2" name="endTime" placeholder="结束日期" type="text">
                   				</div>
							</div>
						</div>
						
						<div class="form-group">
							<label for="" class="col-sm-2 control-label">抄送给</label>
							<div class="col-sm-10">
								<input name="" value="" class="form-control" id="cc-username" placeholder="点击选择抄送人" type="text">
								<input name="ccid" id="ccid" value="" type="hidden">
							</div>
						</div>
                          
						  <div class="form-group">
                                <label class="col-sm-2 col-sm-2 control-label" style="padding-top: 2px;">上传附件</label>
                                <div class="col-sm-10">
                                    <input id="file" type="file" name="file">
                                </div>
                          </div>
							<c:if test="${dustyDetailed.fileName != null}">
								<input type="hidden" value="${dustyDetailed.enclosure}" name="enclosure" >
								<input type="hidden" value="${dustyDetailed.fileName}" name="fileName" >
							</c:if>
							
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
				
				<!-- 模态框 -->
				 <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				        <h4 class="modal-title" id="myModalLabel">抄送给？</h4>
				      </div>
				      <div class="modal-body">
				      	<ul class="white-name-list clearfix">
				      		 <c:forEach items="${team}" var="people">
				      		 <li>
				      		 	<div class="form-group">
				      		 		<label class="checkbox-inline">
       								<input class="resourceId" value="${people.id}" type="checkbox" data-userid="${people.id}" name="whiteListName">
     									${people.name}
    									</label>
				      		 	</div>
				      		 </li>
					       		
				      </c:forEach>
				      	</ul>
				      
				      </div>
				      <div class="modal-footer">
				      
				      	<button type="button" class="btn btn-default no" data-dismiss="modal">取消</button>
				        <button type="button" class="btn btn-primary yes-add">确认</button>
				        
				      </div>
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
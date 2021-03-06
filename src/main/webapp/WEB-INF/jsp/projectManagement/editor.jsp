<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>项目编辑</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<link rel="stylesheet" href="${APP_PATH}/static/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" href="${APP_PATH}/static/css/font-awesome.css">
<link rel="stylesheet" href="${APP_PATH}/static/kindeditor/themes/default/default.css">
<script src="${APP_PATH}/static/kindeditor/kindeditor-all-min.js"></script>
<script src="${APP_PATH}/static/kindeditor/lang/zh-CN.js"></script>

<!--初始化kindEditor配置 -->
<script type="text/javascript">
$(function(){
	var editor = KindEditor.create('textarea[name="descs"]', {
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
	//获取描述
	var descs = $('#editor_id').val();
	//获取自定义id
	var whiteNameId = $('#ccid').val();
	$.ajax({
        url: "${APP_PATH}/admin/project/editor",
        data: $("#projectForm2").serialize()+"&whiteNameId="+whiteNameId,
        type: "POST",
        success: function (result) {
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
    });
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
						<header class="panel-heading">编辑项目</header>
						<div class="panel-body">
						<form id="projectForm2" action="" method="post">
							<input type="hidden" value="${projectDetailed.id}" name="id">
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>项目名称</label>
								<div class="col-sm-10">
									<input name="projectName" value="${projectDetailed.projectName}" class="form-control" placeholder="填写名称" type="text">
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>项目别名</label>
								<div class="col-sm-10">
									<input name="projectAliasName" value="${projectDetailed.projectAliasName}" class="form-control" placeholder="取个别名" type="text">
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
									<textarea id="editor_id" name="descs" class="form-control" style="height: 400px;" placeholder="请填写内容">${projectDetailed.descs}</textarea>
								</div>
							</div>
							<div class="form-group">
				                  <label class="col-sm-2 control-label">项目负责人</label>
				                  <div class="col-sm-10">
				                    <select name="projectResponsiblePeople" class="form-control">
				                    	<option value="${projectDetailed.projectResponsiblePeopleId}">${projectDetailed.projectResponsiblePeople}</option>
				                    	<c:forEach items="${team}" var="people">
				                    		<option value="${people.id}">${people.name}</option>
				                    	</c:forEach>
				                    </select>
				                  </div>
               				 </div>
               				 <div class="form-group">
				                  <label class="col-sm-2 control-label">产品负责人</label>
				                  <div class="col-sm-10">
				                    <select name="productPeople" class="form-control">
				                    	<option value="${projectDetailed.productPeopleId}" style="display: none;">${projectDetailed.productPeople}</option>
				                    	<c:forEach items="${team}" var="people">
				                    		<option value="${people.id}">${people.name}</option>
				                    	</c:forEach>
				                    </select>
				                  </div>
               				 </div>
							<div class="form-group">
				                  <label class="col-sm-2 control-label">测试负责人</label>
				                  <div class="col-sm-10">
				                    <select name="testPeople" class="form-control">
				                    	<option value="${projectDetailed.testPeopleId}" style="display: none;">${projectDetailed.testPeople}</option>
				                    	<c:forEach items="${team}" var="people">
				                    		<option value="${people.id}">${people.name}</option>
				                    	</c:forEach>
				                    </select>
				                  </div>
               				 </div>
               				 <div class="form-group">
				                  <label class="col-sm-2 control-label">发布负责人</label>
				                  <div class="col-sm-10">
				                    <select name="releasePeople" class="form-control">
				                    	<option value="${projectDetailed.releasePeopleId}" style="display: none;">${projectDetailed.releasePeople}</option>
				                    	<c:forEach items="${team}" var="people">
				                    		<option value="${people.id}">${people.name}</option>
				                    	</c:forEach>
				                    </select>
				                  </div>
               				 </div>
               				 <div class="form-group">
				                  <label class="col-sm-2 col-sm-2 control-label">访问控制</label>
				                  <div class="col-sm-10">
									<label class="radio-inline">
									  <input name="releaseControl" value="公开（所有人）" type="radio" data-control-value="0" data-releaseControl="${projectDetailed.releaseControl}">公开（所有人）
									</label>
									<label class="radio-inline">
									  <input name="releaseControl" value="自定义（团队成员和白名单的成员可以访问）" data-control-value="1" type="radio" data-releaseControl="${projectDetailed.releaseControl}">自定义（团队成员和白名单的成员可以访问）
									</label>
									<label class="radio-inline">
									  <input name="releaseControl" value="私有（只有项目团队成员才能访问）" data-control-value="2" type="radio" data-releaseControl="${projectDetailed.releaseControl}">私有（只有项目团队成员才能访问）
									</label>
									</div>
							</div>
							<div class="form-group" id="whitename">
			                  <label class="col-sm-2 col-sm-2 control-label">白名单</label>
			                  <div class="col-sm-10">
								<input name="username" id="cc-username" value="" class="form-control" placeholder="点击选择白名单" type="text">
			                    <input name="ccid" id="ccid" value="" type="hidden">
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
		
							<!-- 模态框 -->
							 <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
							  <div class="modal-dialog" role="document">
							    <div class="modal-content">
							      <div class="modal-header">
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							        <h4 class="modal-title" id="myModalLabel">白名单</h4>
							      </div>
							      <c:forEach items="${MyWhite}" var="MyWhitePeople">
							      <input type="hidden" value="${MyWhitePeople.id}" class="hasResourceId">
							      </c:forEach>
							      <div class="modal-body">
							      	<ul class="white-name-list clearfix">
							      		 <c:forEach items="${white}" var="people">
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
							
							<script type="text/javascript">
								$(function(){
									
									var resourceArray = new Array();
									
									$('.hasResourceId').each(function(){
										var hashasResourceId = $(this);
										resourceArray.push(hashasResourceId.val());
										
									})
									

									
									$('.resourceId').each(function(){
										var resourceId = $(this);
										if( $.inArray(resourceId.val(),resourceArray) >= 0 ){
											resourceId.attr('checked','checked');
										}
									});
								})
							</script>
                            
	</section>
</body>
</html>
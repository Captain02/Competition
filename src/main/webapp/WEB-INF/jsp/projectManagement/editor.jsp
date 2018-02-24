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
									<input name="projectName" value="${projectDetailed.projectName}" class="form-control" placeholder="填写名称" type="text">
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>项目别名</label>
								<div class="col-sm-10">
									<input name="projectAlias" value="${projectDetailed.projectAliasName}" class="form-control" placeholder="取个别名" type="text">
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label">开始和结束日期</label>
								<div class="col-sm-10">
									<div class="input-group input-large custom-date-range" data-date-format="yyyy-mm-dd">
					                      <input value="${projectDetailed.startDate}" class="form-control dpd1" id="mydatepicker2" name="started" placeholder="开始日期"  type="text">
					                      <span class="input-group-addon">To</span>
					                      <input value="${projectDetailed.endDate}" class="form-control dpd2" id="mydatepicker" name="ended" placeholder="结束日期" type="text">
                    				</div>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>描述</label>
								<div class="col-sm-10">
									<textarea id="editor_id" name="content" class="form-control" style="height: 400px;" placeholder="请填写内容">${projectDetailed.descs}</textarea>
								</div>
							</div>
							<div class="form-group">
				                  <label class="col-sm-2 control-label">项目负责人</label>
				                  <div class="col-sm-10">
				                    <select name="projuserid" class="form-control">
				                    	<option value="${projectDetailed.projectResponsiblePeopleId}">${projectDetailed.projectResponsiblePeople}</option>
				                    </select>
				                  </div>
               				 </div>
               				 <div class="form-group">
				                  <label class="col-sm-2 control-label">产品负责人</label>
				                  <div class="col-sm-10">
				                    <select name="produserid" class="form-control">
				                    	<option value="${projectDetailed.productPeopleId}" style="display: none;">${projectDetailed.productPeople}</option>
				                    </select>
				                  </div>
               				 </div>
							<div class="form-group">
				                  <label class="col-sm-2 control-label">测试负责人</label>
				                  <div class="col-sm-10">
				                    <select name="testserid" class="form-control">
				                    	<option value="${projectDetailed.testPeople}" style="display: none;">${projectDetailed.testPeople}</option>
				                    </select>
				                  </div>
               				 </div>
               				 <div class="form-group">
				                  <label class="col-sm-2 control-label">发布负责人</label>
				                  <div class="col-sm-10">
				                    <select name="testserid" class="form-control">
				                    	<option value="${projectDetailed.releasePeopleId}" style="display: none;">${projectDetailed.releasePeople}</option>
				                    </select>
				                  </div>
               				 </div>
               				 <div class="form-group">
				                  <label class="col-sm-2 col-sm-2 control-label">访问控制</label>
				                  <div class="col-sm-10">
									<label class="radio-inline">
									  <input name="pertype" value="${projectDetailed.releaseControl}" <c:if test="${projectDetailed.releaseControl== '公开（所有人）'}">checked="checked"</c:if> type="radio">公开（所有人）
									</label>
									<label class="radio-inline">
									  <input name="pertype" value="${projectDetailed.releaseControl}" <c:if test="${projectDetailed.releaseControl== '自定义（团队成员和白名单的成员可以访问）'}">checked="checked"</c:if> type="radio">自定义（团队成员和白名单的成员可以访问）
									</label>
									<label class="radio-inline">
									  <input name="pertype" value="${projectDetailed.releaseControl}" <c:if test="${projectDetailed.releaseControl== '私有（只有项目团队成员才能访问）'}">checked="checked"</c:if> type="radio">私有（只有项目团队成员才能访问）
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
                    
                    <script type="text/javascript">
                	$('#cc-username').click(function(){
                 		$('#myModal').modal('show');
                 	})
                 	
                    $(function(){
                    	$('input[name="pertype"]:checked').each(function(){
                    		if($(this).val() == 1){
                    			$('#whitename').show();
                    		}
                    		else{
                    			$('#whitename').hide();
                    		}
                    	});
                    	
                    	  $('input[name="pertype"]').on('click', function(){
                      		var obj = $(this);
                      		if (obj.val() == 1) {
                      			$('#whitename').show();
                      		} else {
                      			$('#whitename').hide();
                      		}
                      	});
                    	
                    	var idArray = new Array(),
                    		nameArray = new Array();
                    	$('.yes').click(function(){
                    		idArray.length = 0;
                    		nameArray.length = 0;
                    		$('.modal-body input[name="whiteListName"]:checked').each(function(){
                    			idArray.push($(this).attr('data-userid'));
                    			nameArray.push($(this).val());
                    		});
                    		
                    		var idStr = idArray.join(',');
                    		var nameStr = nameArray.join(',');
                    		$('#ccid').val(idStr);
                    		$('#cc-username').val(nameStr);
                    		$('#myModal').modal('hide');
                    		
                    		var ccidArr = $('#ccid').val().split(',');
                    		$('.modal-body input[name="whiteListName"]').each(function(){
                    			if($.inArray($(this).attr('data-userid'),ccidArr) >=0){
                    				$(this).prop('checked', true);
                    			}
                    		})
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
							      <div class="modal-body">
							      <c:forEach items="${team}" var="people">
							        <label class="checkbox-inline">
        								<input value="${people.id}" type="checkbox" data-userid="${people.id}" name="whiteListName">
      									${people.name}
      								</label>
							      </c:forEach>
							      </div>
							      <div class="modal-footer">
							      
							      	<button type="button" class="btn btn-default no" data-dismiss="modal">取消</button>
							        <button type="button" class="btn btn-primary yes">确认</button>
							        
							      </div>
							    </div>
							  </div>
							</div>
                            
	</section>
</body>
</html>
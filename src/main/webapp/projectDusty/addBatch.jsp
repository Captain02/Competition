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
						<header class="panel-heading">批量添加任务</header>
						<div class="panel-body">
							<section id="unseen">
                <form id="taskbatch-form" method="Post" novalidate="novalidate">
                  <table class="table table-bordered table-striped table-condensed">
                    <thead>
                      <tr>
						<th style="width:14%;">相关需求</th>
                        <th>任务名称</th>
                        <th style="width:100px;">类型</th>
                        <th style="width:100px;">指派给</th>
                        <th style="width:70px;">预工时</th>
                        <th style="width:25%;">描述</th>
                        <th style="width:66px;">级别</th>
                      </tr>
                    </thead>
                    <tbody>
                    
                   
                    <tr class="js-clone">
					  <td>
					  	<select name="needsid" class="form-control">
                      		<option value="">相关需求</option>
						</select>
					  </td>
                      <td><input name="name" class="form-control" type="text"></td>
                      <td>
                      	<select name="type" class="form-control">
	                      <option value="">任务类型</option>
	                      <option value="1">设计</option>
	                      <option value="2">开发</option>
	                      <option value="3">测试</option>
	                      <option value="4">研究</option>
	                      <option value="5">讨论</option>
	                      <option value="6">界面</option>
	                      <option value="7">事务</option>
	                      <option value="8">其他</option>
                    	</select>
                    </td>
                      <td>
                      	<select name="acceptid" class="form-control">
              				<option value="">指派给</option>
            			</select>
            		</td>
                      <td><input name="tasktime" class="form-control" type="number"></td>
                      <td><input name="desc" class="form-control" type="text"></td>
                      <td><select name="level" class="form-control">
                      <option value="1">1级</option>
                      <option value="2">2级</option>
                      <option value="3">3级</option>
                      <option value="4">4级</option>
                    </select></td>
                    </tr>
                    </tbody>
                    
                  </table>
				<div class="form-group">
                  <div class="text-center">
                    <button type="submit" class="btn btn-success">提交保存</button>
                  </div>
                </div>
                </form>
				 </section>
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
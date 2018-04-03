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
	var formData = new FormData($("#demandForm")[0]);
	//发送ajax请求
	  $.ajax({
		url:"${APP_PATH}/admin/demand/editor",
		type:"POST",
		data:formData,
        contentType: false,  
        processData: false, 
		success:function(result){
			if (result.code == 100) {
				 $('#myModal').modal('show');
				ShowTips('.modal-title','添加结果','.modal-body','成功添加一个新需求');
				setTimeout(function(){
					$('#myModal').modal('hide');
					window.location.href="${APP_PATH}/admin/demand/list";
				},1000); 
			}else{
				//后端校验失败信息
           	if (undefined != result.extend.errorFields.descs) {
           		 $('#myModal').modal('show');
					ShowTips('.modal-title','错误的操作','.modal-body','描述不为空');
					setTimeout(function(){
						$('#myModal').modal('hide');
					},3000); 
				}
           	if (undefined != result.extend.errorFields.acceptanceStand) {
           		 $('#myModal').modal('show');
					ShowTips('.modal-title','错误的操作','.modal-body','验收标准不为空');
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
				<div class="om-header-left">
							<h3>
								<span class="om-title">需求管理</span>
								<jsp:include page="projectLeftManagement.jsp"></jsp:include>
							</h3>
						</div>
				
				<div class="row">
				<div class="col-lg-12">
					<section class="panel">
						<header class="panel-heading">编辑需求</header>
						<div class="panel-body">
						<form id="demandForm" action="" method="post">
						<input type="hidden" value="${demandDetailed.id}" name="id">
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>需求名称</label>
								<div class="col-sm-10">
									<input name="demandName" value="${demandDetailed.demandName}" class="form-control" placeholder="填写需求名称" type="text">
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>来源</label>
								<div class="col-sm-10">
									<select name="source" class="form-control">
									<c:if test="${demandDetailed.source!=''}">
					                      <option value="${demandDetailed.source}">${demandDetailed.source}</option>
									</c:if>
					                      <option value="">请选择来源</option>
					                      <option value="客户">客户</option>
					                      <option value="用户">用户</option>
					                      <option value="产品经理">产品经理</option>
					                      <option value="市场">市场</option>
					                      <option value="客服">客服</option>
					                      <option value="竞争对手">竞争对手</option>
					                      <option value="合作伙伴">合作伙伴</option>
					                      <option value="开发人员">开发人员</option>
					                      <option value="测试人员">测试人员</option>
					                      <option value="其他">其他</option>
                   					</select>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>优先级</label>
								<div class="col-sm-10">
									<select name="grade" class="form-control">
				                      <c:if test="${demandDetailed.grade!=''}">
					                      <option value="${demandDetailed.grade}">${demandDetailed.grade}</option>
									  </c:if>
				                      <option value="">请选择优先级</option>
				                      <option value="1级">1级</option>
				                      <option value="2级">2级</option>
				                      <option value="3级">3级</option>
				                      <option value="4级">4级</option>	
                    				</select>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>阶段</label>
								<div class="col-sm-10">
								<select name="stage" class="form-control">
								<c:if test="${demandDetailed.stage!=''}">
			                      <option value="${demandDetailed.stage}">${demandDetailed.stage}</option>
							  	</c:if>
			                      <option value="请选择阶段">请选择阶段</option>
			                      <option value="未开始">未开始</option>
			                      <option value="已计划">已计划</option>
			                      <option value="已立项">已立项</option>
			                      <option value="研发中">研发中</option>
			                      <option value="研发完毕">研发完毕</option>
			                      <option value="测试中">测试中</option>
			                      <option value="测试完毕">测试完毕</option>
			                      <option value="已验收">已验收</option>
			                      <option value="已发布">已发布</option>
                    			</select>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>指派给</label>
								<div class="col-sm-10">
								<select name="assignor" class="form-control">
			                     <c:if test="${demandDetailed.assignor!=''}">
			                      <option value="">${demandDetailed.assignor}</option>
							  	</c:if>
							  	<c:forEach items="${team}" var="people">
			                      <option value="${people.id}">${people.name}</option>
							  	</c:forEach>
                    			</select>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label">预计工时</label>
								<div class="col-sm-10">
									<input name="workTime" value="${demandDetailed.workTime}" class="form-control" placeholder="预计工时" type="text">
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>描述</label>
								<div class="col-sm-10">
									<textarea id="editor_id" name="descs" class="form-control" style="height: 400px;" placeholder="请填写内容">${demandDetailed.descs}</textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>验收标准</label>
								<div class="col-sm-10">
									<textarea id="editor_id" name="acceptanceStand" class="form-control" style="height: 300px;" placeholder="请填写内容">${demandDetailed.acceptanceStand}</textarea>
								</div>
							</div>
							  <div class="form-group">
                                 <label class="col-sm-2 col-sm-2 control-label" style="padding-top: 2px;">上传附件</label>
                                 <div class="col-sm-10">
                                     <input id="file" type="file" name="file" value="${demandDetailed.fileName}">
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
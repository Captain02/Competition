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
	var formData = new FormData($("#bugFrom")[0]);
	//发送ajax请求
	  $.ajax({
		url:"${APP_PATH}/admin/bug/add",
		type:"POST",
		data:formData,
        contentType: false,  
        processData: false, 
		success:function(result){
			$('#myModal').modal('show');
			$('.modal-footer').remove();
			ShowTips('.modal-title','添加结果','.modal-body','成功添加一个测试');
			setTimeout(function(){
				$('#myModal').modal('hide');
				window.location.href='${APP_PATH}/admin/bug/list';
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
								<span class="om-title">测试管理</span>
								<jsp:include page="projectLeftManagement.jsp"></jsp:include>
							</h3>
						</div>
                        <div class="clearfix"></div>
                    </div>
				
				<div class="row">
				<div class="col-lg-12">
					<section class="panel">
						<header class="panel-heading">添加BUG</header>
						<div class="panel-body">
						<form id="bugFrom" action="" method="post">
							<div class="form-group">
								<label for="" class="col-sm-2 control-label">关联需求</label>
								<div class="col-sm-10">
									<select name="demandId" class="form-control">
					                      <option value="">项目需求</option>
					                      <c:forEach items="${DemandDisplay}" var="DemandDisplay">
					                      <option value="${DemandDisplay.id}">${DemandDisplay.demandName}</option>
					                      </c:forEach>
                   					</select>
								</div>
							</div>
							
							<div class="form-group">
								<label for="" class="col-sm-2 control-label">关联任务</label>
								<div class="col-sm-10">
									<select name="projectTaskId" class="form-control">
				                      <option value="">项目任务</option>
				                       <c:forEach items="${DustyDisplay}" var="DustyDisplay">
				                      <option value="${DustyDisplay.id}">${DustyDisplay.taskName}</option>
				                      </c:forEach>
                    				</select>
								</div>
							</div>
							
							<div class="form-group">
								<label for="" class="col-sm-2 control-label">指派给</label>
								<div class="col-sm-10">
								<select name="assginor" class="form-control">
			                     <c:forEach items="${team}" var="people">
			                      <option value="${people.id}">${people.name}</option>
			                     </c:forEach>
                    			</select>
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
								<label for="" class="col-sm-2 control-label"><span>*</span>Bug标题</label>
								<div class="col-sm-10">
									<input name="bugTitle" value="" class="form-control" placeholder="输入测试名称" type="text">
								</div>
							</div>
							
							<div class="form-group">
								<label for="" class="col-sm-2 control-label"><span>*</span>描述</label>
								<div class="col-sm-10">
									<textarea id="editor_id" name="descs" class="form-control" style="height: 400px;" placeholder="请填写内容"></textarea>
								</div>
							</div>
							
							<div class="form-group">
			                  <label class="col-sm-2 col-sm-2 control-label">优先级</label>
			                  <div class="col-sm-10">
			                    <select name="grade" class="form-control">
			                      <option value="">Bug优先级</option>
			                      <option value="1级">1级</option>
			                      <option value="2级">2级</option>
			                      <option value="3级">3级</option>
			                      <option value="4级">4级</option>
			                    </select>
			                  </div>
                			</div>
							
					<div class="form-group">
		                  <label class="col-sm-2 col-sm-2 control-label">操作系统/浏览器</label>
		                  <div class="col-sm-10">
		                    <select name="operatingSystem" class="form-control" style="width: 50%;float:left">
		                      <option value="全部">全部</option>
		                      <option value="windows">Windows</option>
		                      <option value="Windows 8">Windows 8</option>
		                      <option value="Windows 7">Windows 7</option>
		                      <option value="Windows Vista">Windows Vista</option>
		                      <option value="Windows XP">Windows XP</option>
		                      <option value="Windows 2012">Windows 2012</option>
		                      <option value="Windows 2008">Windows 2008</option>
		                      <option value="Windows 2003">Windows 2003</option>
		                      <option value="Windows 2000">Windows 2000</option>
		                      <option value="Android">Android</option>
		                      <option value="IOS">IOS</option>
		                      <option value="WP8">WP8</option>
		                      <option value="WP7">WP7</option>
		                      <option value="Symbian">Symbian</option>
		                      <option value="Linux">Linux</option>
		                      <option value="FreeBSD">FreeBSD</option>
		                      <option value="OS X">OS X</option>
		                      <option value="Unix">Unix</option>
		                      <option value="其他">其他</option>
		                    </select>
		                    <select name="browser" class="form-control" style="width: 50%">
		                      <option value="全部">全部</option>
		                      <option value="IE系列">IE系列</option>
		                      <option value="IE11">IE11</option>
		                      <option value="IE10">IE10</option>
		                      <option value="IE9">IE9</option>
		                      <option value="IE8">IE8</option>
		                      <option value="IE7">IE7</option>
		                      <option value="IE6">IE6</option>
		                      <option value="chrome">chrome</option>
		                      <option value="chrome">firefox</option>
		                      <option value="opera">opera</option>
		                      <option value="safari">safari</option>
		                      <option value="傲游">傲游</option>
		                      <option value="UC">UC</option>
		                      <option value=">其他">其他</option>
		                    </select>
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
			
		</div>
	</section>
</body>
</html>
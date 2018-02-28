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
<script type="text/javascript">
(function($){
    $.fn.serializeJson = function(){
        var jsonData1 = {};
        var serializeArray = this.serializeArray();
        // 先转换成{"id": ["12","14"], "name": ["aaa","bbb"], "pwd":["pwd1","pwd2"]}这种形式
        $(serializeArray).each(function () {
            if (jsonData1[this.name]) {
                if ($.isArray(jsonData1[this.name])) {
                    jsonData1[this.name].push(this.value);
                } else {
                    jsonData1[this.name] = [jsonData1[this.name], this.value];
                }
            } else {
                jsonData1[this.name] = this.value;
            }
        });
        // 再转成[{"id": "12", "name": "aaa", "pwd":"pwd1"},{"id": "14", "name": "bb", "pwd":"pwd2"}]的形式
        var vCount = 0;
        // 计算json内部的数组最大长度
        for(var item in jsonData1){
            var tmp = $.isArray(jsonData1[item]) ? jsonData1[item].length : 1;
            vCount = (tmp > vCount) ? tmp : vCount;
        }

        if(vCount > 1) {
            var jsonData2 = new Array();
            for(var i = 0; i < vCount; i++){
                var jsonObj = {};
                for(var item in jsonData1) {
                    jsonObj[item] = jsonData1[item][i];
                }
                jsonData2.push(jsonObj);
            }
            return JSON.stringify(jsonData2);
        }else{
            return "[" + JSON.stringify(jsonData1) + "]";
        }
    };
})(jQuery);


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
	//发送ajax请求
	alert($("#taskbatch-form").serializeJson());
	  $.ajax({
		url:"${APP_PATH}/admin/dusty/addBatch",
		type:"POST",
		contentType : 'application/json;charset=utf-8', //设置请求头信息
        dataType:"json",
		data:$("#taskbatch-form").serializeJson(),
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
				<div class="om-header-right">
                       		
							<div class="tools pull-left" style="margin-right: 3px;">
								<a href="${APP_PATH}/admin/dusty/list?herfPage=0" class="btn btn-default btn-sm">显示全部</a>
								<a href="${APP_PATH}/admin/dusty/list?herfPage=1" class="btn btn-default btn-sm active">指派给我</a>
								<a href="${APP_PATH}/admin/dusty/list?herfPage=2" class="btn btn-default btn-sm">由我创建</a>
								<a href="${APP_PATH}/admin/dusty/list?herfPage=3" class="btn btn-default btn-sm">由我解决</a>
								<a href="${APP_PATH}/admin/dusty/list?herfPage=4" class="btn btn-default btn-sm">由我关闭</a>
								<a href="${APP_PATH}/admin/dusty/list?herfPage=5" class="btn btn-default btn-sm">由我取消</a>
							</div>
							
                            <a id="addButton" type="button" class="btn btn-success btn-sm" onclick="window.location.href='${APP_PATH}/admin/dusty/addPage'">
                                <i>+</i>新任务
                            </a>
                            <a id="addButton" type="button" class="btn btn-warning btn-sm" onclick="window.location.href='${APP_PATH}/admin/dusty/addBatch'">
                                <i>+</i>批量添加
                            </a>
                        </div>
				<div class="clearfix"></div>
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
                    
                   
                <c:forEach items="${counts}">
                    <tr class="js-clone">
					  <td>
					  	<select name="demandId" class="form-control">
                      		<option value="">相关需求</option>
                      		 <c:forEach items="${demands}" var="demand">
								<option value="${demand.id}">${demand.demandName}</option>
							</c:forEach>
						</select>
					  </td>
                      <td><input name="taskName" class="form-control" type="text"></td>
                      <td>
                      	<select name="taskType" class="form-control">
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
                      	<select name="assignor" class="form-control">
              				<option value="">指派给</option>
              				<c:forEach items="${team}" var="user">
								<option value="${user.id}">${user.name}</option>
							</c:forEach>
            			</select>
            		</td>
                      <td><input name="workTime" class="form-control" type="number"></td>
                      <td><input name="descs" class="form-control" type="text"></td>
                      <td><select name="grade" class="form-control">
                      <option value="1级">1级</option>
                      <option value="2级">2级</option>
                      <option value="3级">3级</option>
                      <option value="4级">4级</option>
                    </select></td>
                    </tr>
                  </c:forEach>
                    </tbody>
                  </table>
                    
				<div class="form-group">
                  <div class="text-center">
                    <button type="button" onclick="save()" class="btn btn-success">提交保存</button>
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
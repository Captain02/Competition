<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>我要请假</title>
<%
pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<jsp:include page="iniCssHref.jsp"></jsp:include>
<link rel="stylesheet" href="${APP_PATH}/static/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css">
<!-- 动态显示流程审批人数量 -->
<script src="${APP_PATH}/static/js/activeShowProcessPerson.js"></script>
<script src="${APP_PATH}/static/js/regAjax.js"></script>

<script type="text/javascript">
$(function(){
	ShowEle('.yes','hide');
	
	//根据流程的不同，动态显示可添加的审批人数量
	$('.selectProcessKey').change(function(){
		var selectProcessKeyName = $(this).val();
		$.ajax({
			url:"${APP_PATH}/admin/holiday/selectProcessKeyName",
			type:"GET",
			data:"selectProcessKeyName="+selectProcessKeyName,
			success:function(result){
				activeShowProcessPerson(selectProcessKeyName,result);
			}
		})
	})
	
	
});

function addHoliday() {
	//判定页面上是否有错误信息
	ifErrorMessage();
	 if ($('.save-button').attr("ajax-va") == "error") {
	        return false;
	}
	var persons = "";
	$.each($(".addPerson"),function(){
		persons += $(this).text()+"-";
	})
	 var formData = new FormData($("#addHolidayPage")[0]);
	formData.append('persons', persons);
	//发送ajax请求
	  $.ajax({
		url:"${APP_PATH}/admin/holiday/add",
		type:"POST",
		data:formData,
        contentType: false,  
        processData: false, 
		success:function(result){
			if (result.code==100) {
				$('#myModal').modal('show');
				ShowTips('.modal-title','操作结果','.modal-body', '<b style = "color:#5cb85c;">已成功提交请假申请！</b>');
				ShowEle('.yes','show');
			}else{
				if(undefined != result.extend.errorFields.endday){
            		show_validate_msg("#endday", "error", "结束时间不为空");
            	}
				if(undefined != result.extend.errorFields.holidaydays){
            		show_validate_msg("#holidaydays", "error", "请假天数不为空");
            	}
				if(undefined != result.extend.errorFields.reason){
            		show_validate_msg("#reason", "error", "描述不为空");
            	}
				if(undefined != result.extend.errorFields.startday){
            		show_validate_msg("#startday", "error", "开始时间不为空");
            	}
			}
		}
	})  
}
</script>
<!-- 添加审批人 -->
<script src="${APP_PATH}/static/js/addPerson.js"></script>
</head>

        <body class="bg-common stickey-menu">
            <section>

                <!-- 页面模版，每页左侧区域固定不变 -->
            	<jsp:include page="iniLeftMenu.jsp"></jsp:include>

                <div class="main-content">

                    <!-- 页面模版，每页主体部分头部按需更改 -->
                    <div class="content-head content-head-section">

                        <a href="" class="toggle-btn">
                            <span class="glyphicon glyphicon-th-list"></span>
                        </a>



                        <div class="content-head-right"></div>

                        <div class="clearfix"></div>

                    </div>

                    <!-- 页面模版，按需更改 -->
                    <div class="wrapper">

                        
                            <div class="om-header">
                            
                                <jsp:include page="iniHolidayManagementHref.jsp"></jsp:include>
                                
                                <div class="clearfix"></div>
                            </div>

                            <div class="om-wrapper">
                                <div class="row">
                                    <div class="col-sm-12">

                                        <header class="om-wrapper-header">我要请假</header>

                                        <div class="om-wrpper-body">
                                            <form action="" id="addHolidayPage" class="form-horizontal adminex-form">

                                                <!-- 类型填写区域 -->
                                                <div class="form-group">
                                                    <div class="col-sm-2">
                                                        <label for="" class="control-label">
                                                            <span>*</span>
                                                         	   类　　型
                                                        </label>
                                                    </div>

                                                    <div class="col-sm-10">
                                                        <select name="type" class="form-control">
                                                            <option value="事假">事假</option>
                                                            <option value="病假">病假</option>
                                                            <option value="年假">年假</option>
                                                            <option value="调休">调休</option>
                                                            <option value="婚假">婚假</option>
                                                            <option value="产假">产假</option>
                                                            <option value="陪产假">陪产假</option>
                                                            <option value="路途假">路途假</option>
                                                            <option value="其他">其他</option>
                                                        </select>
                                                    </div>
                                                </div>

                                                <!--日期填写区域 -->
                                                <div class="form-group">

                                                    <div class="col-sm-2">
                                                        <label for="" class="control-label">
                                                            <span>*</span>
                                                           	 请假日期
                                                        </label>
                                                    </div>

                                                    <div class="col-sm-10">

                                                        <div class="input-group input-large">
                                                            <!-- 起始日期 -->
                                                            <input id="startday" class="form-control dpd1" name="startday" placeholder="开始日期" value="" type="text">
                                                            <span></span>

                                                            <span class="input-group-addon">To</span>

                                                            <!-- 结束日期 -->
                                                            <input id="endday" class="form-control dpd2" name="endday" placeholder="结束日期" value="" type="text">
                                                            
                                                            <span></span>
                                                        </div>
                                                    </div>


                                                </div>

                                                <!-- 天数 -->
                                                <div class="form-group">


                                                    <div class="col-sm-2">
                                                        <label for="" class="control-label">
                                                            <span>*</span>
                                                            	请假天数
                                                        </label>
                                                    </div>
                                                    <div class="col-sm-10">
                                                        <input id="holidaydays" name="holidaydays" type="text" placeholder="请输入请假天数" value="" class="form-control notNull onlyNumber">
                                                        <span></span>
                                                    </div>

                                                </div>

                                                <!-- 事由填写区域 -->
                                                <div class="form-group">
                                                    <div class="col-sm-2">
                                                        <label for="" class="control-label">
                                                            <span>*</span>
                                                            	请假事由
                                                        </label>
                                                    </div>
                                                    <div class="col-sm-10">
                                                        <textarea id="reason" name="reason" placeholder="请假事由，如世界很大，我想出去走一走" style="height:200px;" class="form-control notNull"></textarea>
                                                        <span></span>
                                                    </div>
                                                </div>

                                                <!-- 凭证填写区域 -->
                                                <div class="form-group">
                                                    <div class="col-sm-2">
                                                        <label for="" class="control-label">
                                                            	凭　证
                                                        </label>
                                                    </div>
                                                    <div class="col-sm-10">
                                                        <input id="file" type="file" name="file">
                                                    </div>

                                                </div>
                                                
 											 	<!-- 流程选择区域 -->
                                                <div class="form-group">
                                                    <div class="col-sm-2">
                                                        <label for="" class="control-label">
                                                           	 流程选择
                                                        </label>
                                                    </div>
                                                    <div class="col-sm-10">
                                                         <select name="processDefinitionKey" class="form-control selectProcessKey">
                                                            <option value="tip" style="display: none;">请选择一个审批流程</option>
                                                         	<c:forEach items="${processKey}" var="key">
                                                            	<option value="${key}">${key}</option>
                                                         	</c:forEach>
                                                        </select>
                                                        
                                                        <p class="processTips noProcessPerson">
                                                        	选择了<span class="processName"></span>流程，
                                                        	请添加<span class="processPersonNum"></span>位审批人
                                                        </p>
                                                        
                                                    </div>

                                                </div>

                                                <!-- 审批人填写区域 -->
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

                                            </form>

                                        </div>


                                    </div>

                                    <!-- 提交按钮 -->
                                    <div class="form-group">
                                        <label class="col-lg-2 col-sm-2 control-label"></label>
                                        <div class="col-lg-10">
                                            <button type="button" onclick="addHoliday()" class="btn btn-success save-button">提交保存</button>
                                            <span class="add-error-ms" style="color:red;"></span>
                                        </div>
                                    </div>


                                    <div class="clearfix"></div>


                                </div>

                            </div>

                            <!-- 模态框 -->
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">

                                        <!-- 标题 -->
                                        <div class="modal-header serach-person-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                            <h4 class="modal-title" id="myModalLabel">
                                            	审批人
                                            	（当前审批流程：<span class="processName"></span>
                                            	请添加<span class="processPersonNum"></span>位审批人）
                                            </h4>
                                        </div>

                                        <!-- 主体 -->
                                        <div class="modal-body">
                                            <ul class="person-List">

                                                <!-- 在此遍历出审核人员 -->
                                                <c:forEach items="${user}" var="user">
	                                                <li>
	                                                    <a>${user.username}</a>:${user.name }:${user.role.name}
	                                                </li>
                                                </c:forEach>
                                                
                                            </ul>
                                        </div>

                                        <!-- 底部按钮 -->
	                                     <form action="${APP_PATH}/admin/holiday/list" method="get">
	                                        <div class="modal-footer serach-person-footer">
		                                        	<input name="pn" type="hidden" value="${pn==null?100000:pn}">
		    										<button type="submit" class="btn btn-default btn-success yes">确认</button>
	                                        </div>
	    								</form>
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
            </section>
        </body>

        </html>
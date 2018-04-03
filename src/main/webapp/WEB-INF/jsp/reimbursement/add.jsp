<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>我要报销</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<!-- 添加审批人 -->
<script src="${APP_PATH}/static/js/addPerson.js"></script>
<!-- 动态显示流程审批人数量 -->
<script src="${APP_PATH}/static/js/activeShowProcessPerson.js"></script>
<script src="${APP_PATH}/static/js/regAjax.js"></script>
<script type="text/javascript">


$(function(){
	ShowEle('.yes','hide');
	
	//根据所选流程的不同，动态显示可添加的审批人数量
	$('.selectProcessKey').change(function(){
		var selectProcessKeyName = $(this).val();
		$.ajax({
			url:"${APP_PATH}/admin/reimbursement/selectProcessKeyName",
			type:"GET",
			data:"selectProcessKeyName="+selectProcessKeyName,
			success:function(result){
				activeShowProcessPerson(selectProcessKeyName,result);
			}
		})
	})
	

});



function addReimbursement() {
	//判定页面上是否有错误信息
	ifErrorMessage();
	 if ($('.save-button').attr("ajax-va") == "error") {
	        return false;
	    }
	var persons = "";
	$.each($(".addPerson"), function() {
		persons += $(this).text() + "-";
	})
	var formData = new FormData($("#addReimbursement")[0]);
	formData.append('persons', persons);
	//发送ajax请求
	$.ajax({
		url : "${APP_PATH}/admin/reimbursement/add",
		type : "POST",
		data : formData,
		contentType : false,
		processData : false,
		success : function(result) {
			if (result.code == 100) {
				$('#myModal').modal('show');
				ShowTips('.modal-title','操作结果','.modal-body','<b style = "color:#5cb85c;">' + '已成功提交报销申请' + '</b>');
				ShowEle('.yes','show');
			}else{
				if(undefined != result.extend.errorFields.money){
            		show_validate_msg("#money", "error", "结束时间不为空");
            	}
				if(undefined != result.extend.errorFields.type){
            		show_validate_msg("#type", "error", "请假天数不为空");
            	}
				if(undefined != result.extend.errorFields.detailed){
            		show_validate_msg("#detailed", "error", "描述不为空");
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
							<div class="col-lg-12">
								<section class="panel">
									<div class="panel-body">
										<div class="alert alert-block alert-danger fade in">
											<button type="button" class="close close-sm"
												data-dismiss="alert">
												<i class="glyphicon glyphicon-remove"></i>
											</button>
											<strong>注意!</strong> 报销单状态为审批中后，就不能再编辑！后续流程等待审批人操作。
										</div>
										<form class="form-horizontal adminex-form"
											id="addReimbursement" novalidate="novalidate">

											<div class="js-expenseBox">
												<div class="alert alert-info fade in">报销明细</div>
												<div class="form-group">
													<label class="col-sm-2 col-sm-2 control-label"> <span>*</span>报销金额
													</label>
													<div class="col-sm-10">
														<input id="money" name="money" class="form-control onlyNumber"
															placeholder="请输入金额" type="number">
														<span></span>
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 col-sm-2 control-label"> <span>*</span>报销类型
													</label>
													<div class="col-sm-10">
														<input id="type" name="type" class="form-control notNull"
															placeholder="请输入报销类型，如采购经费、活动经费" type="text">
														<span></span>
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 col-sm-2 control-label"> <span>*</span>报销明细
													</label>
													<div class="col-sm-10">
														<textarea id="detailed" name="detailed" placeholder="报销明细"
															style="height: 94px;" class="form-control notNull"></textarea>
														<span></span>
													</div>
												</div>
											</div>
											

											<div class="form-group">
												<label class="col-sm-2 col-sm-2 control-label"
													style="padding-top: 2px;">图片</label>
												<div class="col-sm-10">
													<input id="file" type="file" name="file">
												</div>
											</div>
											
											<div class="form-group">
												<label class="col-sm-2 col-sm-2 control-label">流程选择</label>
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

											<div class="form-group addprocessPerson noProcessPerson">
												<label class="col-sm-2 col-sm-2 control-label">审批人(点击可删除)</label>
												<div class="col-sm-10">
													<!-- 填入点击的审批人信息 -->
													<div class="person-name-area person-name-list"></div>
													<span class="glyphicon glyphicon-plus-sign btn-person"></span>
												</div>
											</div>

											<div class="form-group">
												<label class="col-lg-2 col-sm-2 control-label"></label>
												<div class="col-lg-10">
													<button type="button" onclick="addReimbursement()"
														class="btn btn-primary btn-success save-button">提交保存</button>
														<span class="add-error-ms" style="color:red;"></span>
												</div>
											</div>
										</form>
									</div>
								</section>
							</div>
						</div>


						<!-- row -->
					</div>

				</div>

			</div>
	</section>
	<!-- 模态框 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<!-- 标题 -->
				<div class="modal-header serach-person-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
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
							<li><a>${user.username}</a>:${user.name }:${user.role.name}
							</li>
						</c:forEach>


					</ul>
				</div>

				<!-- 底部按钮 -->
				 <form action="${APP_PATH}/admin/reimbursement/list" method="get">
					<div class="modal-footer serach-person-footer">
						<button type="submit" class="btn btn-default btn-success yes">确认</button>
					</div>
				</form>

			</div>
		</div>
	</div>
	
	
</body>

</html>
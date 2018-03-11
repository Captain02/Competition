<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>我要领用</title>

<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<jsp:include page="iniCssHref.jsp"></jsp:include>

<!-- 添加审批人 -->
<script src="${APP_PATH}/static/js/addPerson.js"></script>
<!-- 动态显示流程审批人数量 -->
<script src="${APP_PATH}/static/js/activeShowProcessPerson.js"></script>

<script type="text/javascript">

$(function () {
    ShowEle('.yes', 'hide');
    //根据流程的不同，动态显示可添加的审批人数量
    $('.selectProcessKey').change(function(){
    	var selectProcessKeyName = $(this).val();
		//返回人数的ajax
		$.ajax({
			url:"${APP_PATH}/admin/things/selectProcessKeyName",
			type:"GET",
			data:"selectProcessKeyName="+selectProcessKeyName,
			success:function(result){
				activeShowProcessPerson(selectProcessKeyName,result);
			}
		})
    })
    
});

function addthingsForm() {
    var persons = "";
    $.each($(".addPerson"), function () {
        persons += $(this).text() + "-";
    })
    var formData = new FormData($("#thingsForm")[0]);
    formData.append('persons', persons);
    //发送ajax请求
    $.ajax({
        url: "${APP_PATH}/admin/things/add",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        success: function (result) {
            if (result.code == 100) {
                $('#myModal').modal('show');
                ShowTips('.modal-title', '操作结果', '.modal-body', '<b style = "color:#5cb85c;">' +
                    '已成功提交报销申请' + '</b>');
                ShowEle('.yes', 'show');
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

                <a href="" class="toggle-btn">
                    <span class="glyphicon glyphicon-th-list"></span>
                </a>

                <form action="" class="serach-form">

                    <select class="form-control">
                        <option>用户状态</option>
                        <option>占个位置</option>
                        <option>占个位置</option>
                        <option>占个位置</option>
                        <option>占个位置</option>
                    </select>
                    <input type="text" placeholder="请输入用户名、姓名" value="" class="form-control">

                    <button type="button" class="btn btn-primary">搜索</button>


                    <div class="clearfix"></div>
                </form>


                <div class="content-head-right"></div>

                <div class="clearfix"></div>

            </div>

            <!-- 页面模版，按需更改 -->
            <div class="wrapper">

                <div class="row">
                    <div class="om-header">
                        <jsp:include page="iniHolidayManagementHref.jsp"></jsp:include>
                        <div class="clearfix"></div>
                    </div>

                    <div class="om-wrapper">
                        <div class="row">
                            <div class="col-lg-12">
                                <section class="panel">
                                    <header class="panel-heading"> </header>
                                    <div class="panel-body">
                                        <div class="alert alert-block alert-danger fade in">
                                            <button type="button" class="close close-sm" data-dismiss="alert">
                                                <i class="glyphicon glyphicon-remove"></i>
                                            </button>
                                            <strong>注意!</strong> 领用单状态为正常后(可在列表操作中设置为“正常”)，就不能再编辑！后续流程等待审批人操作。
                                        </div>
                                        <form class="form-horizontal adminex-form" id="thingsForm" novalidate="novalidate">
                                            <div class="form-group">
                                                <label class="col-sm-2 col-sm-2 control-label">
                                                    <span>*</span>物品用途
                                                </label>
                                                <div class="col-sm-10">
                                                    <input name="purpose" class="form-control" placeholder="如办公用品 必填" type="text">
                                                </div>
                                            </div>
                                            <!-- 此处以后可以动态的添加明细 -->
                                            <div class="js-expenseBox">
                                                <div class="alert alert-info fade in">领用明细(1)</div>
                                                <div class="form-group">
                                                    <label class="col-sm-2 col-sm-2 control-label">
                                                        <span>*</span>物品名称
                                                    </label>
                                                    <div class="col-sm-10">
                                                        <input name="name" class="form-control" placeholder="请输入物品名称" type="text">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-sm-2 col-sm-2 control-label">
                                                        <span>*</span>领用数量
                                                    </label>
                                                    <div class="col-sm-10">
                                                        <input name="number" class="form-control" placeholder="请输入物品数量" type="number">
                                                    </div>
                                                </div>
                                              
                                               
                                            </div>
                                            
                                            <div class="form-group">
												<label for="" class="col-md-2"></label>
												<div class="col-md-10 text-center">
													<a class="add-details">
														<i class="glyphicon glyphicon-plus-sign" style="font-size: 15px;"></i>
														添加明细
													</a>
												</div>
											</div>
											
                                              <div class="form-group">
                                                    <label class="col-sm-2 col-sm-2 control-label">
                                                        <span>*</span>领用详情
                                                    </label>
                                                    <div class="col-sm-10">
                                                        <textarea name="details" placeholder="领用详情" style="height: 94px;" class="form-control"></textarea>
                                                    </div>
                                                </div>
												
											

                                            <div class="form-group">
                                                <label class="col-sm-2 col-sm-2 control-label" style="padding-top: 2px;">上传附件</label>
                                                <div class="col-sm-10">
                                                    <input id="file" type="file" name="file">
                                                </div>
                                            </div>
                                            
                                            <div class="form-group ">
												<label class="col-sm-2 col-sm-2 control-label" >流程选择</label>
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
                                                    <button type="button" onclick="addthingsForm()" class="btn btn-primary btn-success">提交保存</button>
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
        </div>
    </section>
    <!-- 模态框 -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">

                <!-- 标题 -->
                <div class="modal-header serach-person-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">审批人
                                                                （当前审批流程：<span class="processName"></span>
                                                                 请添加<span class="processPersonNum"></span>位审批人）</h4>
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
                <form action="/OA02/admin/things/list" method="get">
                    <div class="modal-footer serach-person-footer">
                        <button type="submit" class="btn btn-default btn-success yes">确认</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
    
    <script type="text/javascript">
		$('.add-details').click(function(){
			var detailsLength = $('.js-expenseBox').length;
			var html =	$(
							"<div class='js-expenseBox'>"+
				          	"<div class='alert alert-info fade in'>领用明细("+(detailsLength+1)+")</div>"+
							"<div class='form-group'>"+
							"<label class='col-sm-2 col-sm-2 control-label'> <span>*</span>物品名称</label>"+
							"<div class='col-sm-10'>"+
							"<input name='name' class='form-control' placeholder='请输入物品名称' type='number'>"+
							"</div>"+
							"</div>"+
							"<div class='form-group'>"+
							"<label class='col-sm-2 col-sm-2 control-label'> <span>*</span>领用数量</label>"+
							"<div class='col-sm-10'>"+
							"<input name='number' class='form-control' placeholder='请输入物品数量' type='text'>"+
							"</div>"+
							"</div>"+
							"</div>"+
							"</div>"
						);
			$('.js-expenseBox:eq('+(detailsLength-1)+')').after(html);
		})
	</script>
    
</body>

</html>
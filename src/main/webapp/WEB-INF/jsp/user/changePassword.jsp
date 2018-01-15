<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>修改密码</title>
    

   <%
	      pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    

<jsp:include page="iniCssHref.jsp"></jsp:include>
<!-- 用于前端正则校验和后端Ajax校验的脚本 -->
<script src="${APP_PATH}/static/js/regAjax.js"></script>
<!-- 控制按钮的状态以及模态框展示的信息 -->
<script src="${APP_PATH}/static/js/ctrolButton.js"></script>
<script type="text/javascript">
function changePassword() {
	//判定页面上是否有错误信息
	ifErrorMessage();
	 if ($('.save-button').attr("ajax-va") == "error") {
	        return false;
	    }
	$.ajax({
		url:"${APP_PATH}/admin/user/changePassword",
		data:$("#changePasswordForm").serialize(),
		type:"POST",
		success:function(result){
			console.log(result);
			if (result.code==100) {
				 $('#myModal').modal('show');
                 ShowTips('.modal-title','执行结果','.modal-body','<b style = "color:#5cb85c;">' + '密码修改成功，请重新登陆！' + '</b>');
			}else{
				
				if (undefined != result.extend.errorFields.newPassword) {
					show_validate_msg("#newPassword", "error", "密码不能为空");
				}
				if (undefined != result.extend.errorFields.truePassowrd) {
					show_validate_msg("#truePassword", "error", "两次密码不一致或存在非法字符");
				}
			}
		}
	})
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

                <a href="" class="toggle-btn">
                    <span class="glyphicon glyphicon-th-list"></span>
                </a>

                	<jsp:include page="iniUserInfo.jsp"></jsp:include>

                <div class="clearfix"></div>

            </div>

            <!-- 页面模版，按需更改 -->
            <div class="wrapper">

                <div class="row">
                    <div class="om-header">
                         <jsp:include page="iniOrganizationManagementHref.jsp"></jsp:include>

                        <div class="clearfix"></div>
                    </div>

                    <div class="om-wrapper">
                        <div class="row">
                            <div class="col-sm-12">

                                <header class="om-wrapper-header">修改密码</header>

                                <div class="om-wrpper-body">
                                    <form action="" id="changePasswordForm">
                                        <header>基本信息（带*号的为必填项）</header>

                                        <!-- 用户名填写区域 -->
                                        <div class="form-group">
                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    <span>*</span>
                                                    新的密码
                                                </label>
                                            </div>

                                            <div class="col-sm-10">
                                                <input type="text" id="newPassword" name="newPassword" class="form-control" value="" placeholder="请填写新密码">
                                                <span></span>
                                            </div>
                                        </div>

                                        <!-- 密码填写区域 -->
                                        <div class="form-group">

                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    <span>*</span>
                                                    确认密码
                                                </label>
                                            </div>

                                            <div class="col-sm-10">
                                                <input type="text" id="truePassword" name="truePassword" class="form-control" value="" placeholder="请确认密码">
                                                <span></span>
                                            </div>


                                        </div>


                                        <!-- 提交按钮 -->
                                        <div class="form-group">
                                            <label class="col-lg-2 col-sm-2 control-label"></label>
                                            <div class="col-lg-10">
                                                <input name="id" value="${id }" type="hidden">
                                                <button type="button" class="btn btn-success save-button" onclick="changePassword()">确认修改</button>
                                            </div>
                                        </div>

                                        <div class="clearfix"></div>
                                    </form>

                                </div>

                            </div>

                        </div>

                    </div>

                </div>

            </div>
        </div>
    </section>
      <!-- 模态框 -->
 <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel"></h4>
      </div>
      <div class="modal-body">
        
      </div>
      <div class="modal-footer">
      <form action="${APP_PATH}/logout" method="get">
        <button type="submit" class="btn btn-success yes">确认</button>
      </form>
      </div>
    </div>
  </div>
</div>
</body>

</html>
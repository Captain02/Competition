<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>权限的编辑</title>
    
    
   <%
	      pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
   <jsp:include page="iniCssHref.jsp"></jsp:include>
	<!-- 控制按钮的状态以及模态框展示的信息 -->
    <script src="${APP_PATH}/static/js/ctrolButton.js"></script>
    <!-- 用于前端正则校验和后端Ajax校验的脚本 -->
    <script src="${APP_PATH}/static/js/regAjax.js"></script>
	
	<script type="text/javascript">
	function update() {
		ifErrorMessage();
		
		if ($('.save-button').attr("ajax-va") == "error") {
	        return false;
	    }
	
		$.ajax({
			url:"${APP_PATH}/admin/resource/update",
			data:$("#updateResourceInfo").serialize(),
			type:"POST",
			success:function(result){
				console.log(result);
				if (result.code==100) {
					$('#myModal').modal('show');
					ShowTips('.modal-title','执行结果','.modal-body','<b style = "color:#5cb85c;">' + '权限信息修改成功！' + '</b>');
				} else {
					if(undefined != result.extend.errorFields.name){
	            		show_validate_msg("#resource-name", "error", "用户名不为空且不能含有中文或特殊字符");
					}
					if(undefined != result.extend.errorFields.column){
	            		show_validate_msg("#column", "error", "用户名不为空且不能含有中文或特殊字符");
					}
					if(undefined != result.extend.errorFields.permission){
	            		show_validate_msg("#resource-desc", "error", "用户名不为空且不能含有中文或特殊字符");
					}
					if(undefined != result.extend.errorFields.url){
	            		show_validate_msg("#resource-href", "error", "用户名不为空且不能含有中文或特殊字符");
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

                                <header class="om-wrapper-header">权限的编辑</header>

                                <div class="om-wrpper-body">
                                    <sf:form action="" id="updateResourceInfo" modelAttribute="resource">

                                        <!-- 栏目填写区域 -->
                                        <div class="form-group">
                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    栏　　目
                                                </label>
                                            </div>

                                            <div class="col-sm-10">
                                                <sf:input path="column" type="text" id="column" class="form-control" value="" placeholder="请填写用户名" />
                                                <span></span>
                                            </div>
                                        </div>

                                        <!-- 名称填写区域 -->
                                        <div class="form-group">

                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    名　　称
                                                </label>
                                            </div>

                                            <div class="col-sm-10">
                                                <sf:input path="name" type="text" class="form-control" id="resource-name" value="" placeholder="请填写密码" />
                                                <span></span>
                                            </div>


                                        </div>

                                        <!-- 描述填写区域 -->
                                        <div class="form-group">


                                            <div class="col-sm-2">
                                                <label for="" class="control-label">

                                                    描　　述
                                                </label>
                                            </div>


                                            <div class="col-sm-10">
                                                <sf:input path="permission" type="text" id="resource-desc" class="form-control" name="username" value="" placeholder="请填写描述" />
                                                <span></span>
                                            </div>

                                        </div>

                                        <!-- 拦截链接填写区域 -->
                                        <div class="form-group">
                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    拦截链接
                                                </label>
                                            </div>
                                            <div class="col-sm-10">
                                                <sf:input path="url" type="text" id="resource-href" class="form-control" name="username" value="" placeholder="请填写链接" />
                                                <span></span>
                                            </div>
                                        </div>

                                        <!-- 提交按钮 -->
                                        <div class="form-group">
                                            <label class="col-lg-2 col-sm-2 control-label"></label>
                                            <div class="col-lg-10">
                                                <input name="id" value="${resource.id }" type="hidden">
                                                <button onclick="update()" type="button" class="btn btn-success save-button" >提 交</button>
                                            </div>
                                        </div>


                                        <div class="clearfix"></div>
                                    </sf:form>

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
      
        
        <!-- 用于页面跳转的按钮 -->
       <form action="${APP_PATH}/admin/resource/list" method="get">
        	<input type="hidden" value="${pn}" name="pn">
        	<button type="submit" class="btn btn-success">确认</button>
       </form>
       
        
      </div>
    </div>
  </div>
</div>
</body>

</html>
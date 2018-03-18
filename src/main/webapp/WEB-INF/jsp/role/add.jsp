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
    <title>职称添加</title>

        <%
	       pageContext.setAttribute("APP_PATH", request.getContextPath());
        %>

<jsp:include page="iniCssHref.jsp"></jsp:include>
<!-- 用于前端正则校验和后端Ajax校验的脚本 -->
<script src="${APP_PATH}/static/js/regAjax.js"></script>

<script type="text/javascript">
function save() {
	ifErrorMessage();
	 if ($('.save-button').attr("ajax-va") == "error") {
	        return false;
	    }
	$.ajax({
		url:"${APP_PATH}/admin/role/add",
		data:$("#addRoleInfo").serialize(),
		type:"POST",
		success:function(result){
			if (result.code==100) {
				$('#myModal').modal('show');
				ShowTips('.modal-title','执行结果','.modal-body','职称信息添加成功!');
			}else{
				if(undefined != result.extend.errorFields.name){
            		show_validate_msg("#rolename", "error", "职位名称不为空且");
				}
			}
		}
	})
}

function update() {
	
	ifErrorMessage();
	 if ($('.save-button').attr("ajax-va") == "error") {
	        return false;
	    }
	 
	$.ajax({
		url:"${APP_PATH}/admin/role/update",
		data:$("#addRoleInfo").serialize(),
		type:"POST",
		success:function(result){
			if(result.code==100){
				$('#myModal').modal('show');
				ShowTips('.modal-title','执行结果','.modal-body','职称信息修改成功!');
			}else{
				if(undefined != result.extend.errorFields.name){
            		show_validate_msg("#rolename", "error", "职位名称不为空且");
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

                <a href="" class="toggle-btn">
                    <span class="glyphicon glyphicon-th-list"></span>
                </a>



                <jsp:include page="iniUserInfo.jsp"></jsp:include>

                <div class="clearfix"></div>

            </div>

            <!-- 页面模版，按需更改 -->
            <div class="wrapper">

               
                    <div class="om-header">
                        <jsp:include page="iniOrganizationManagementHref.jsp"></jsp:include>
                        <div class="clearfix"></div>
                    </div>

                    <div class="om-wrapper">
                        <div class="row">
                            <div class="col-sm-12">

                                <header class="om-wrapper-header">添加新职称</header>

                                <div class="om-wrpper-body">
                                    <sf:form action="" id="addRoleInfo" modelAttribute="role">

                                        <!-- 用户名填写区域 -->
                                        <div class="form-group">
                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    <span>*</span>
                                                    名　称
                                                </label>
                                            </div>

                                            <div class="col-sm-10">
                                                <sf:input path="name" type="text" class="form-control" id="rolename" name="rolename" value="" placeholder="请填写名称" />
                                                <span></span>
                                            </div>
                                        </div>

                                        <!-- 密码填写区域 -->
                                        <div class="form-group">

                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    描　述
                                                </label>
                                            </div>
											
		                                            <div class="col-sm-10">
		                                                <sf:textarea path="sn" name="roledesc" placeholder="请填写描述" style="height:200px;" class="form-control"></sf:textarea>
		                                            </div>


                                        </div>

										<c:choose>
											<c:when test="${role.id==null}">
		                                        <!-- 提交按钮 -->
		                                        <div class="form-group">
		                                            <label class="col-lg-2 col-sm-2 control-label"></label>
		                                            <div class="col-lg-10">
		                                                <button type="button" onclick="save()" class="btn btn-success">提 交</button>
		                                            </div>
		                                        </div>
											</c:when>
											<c:when test="${role.id!=null}">
		                                        <div class="form-group">
		                                            <label class="col-lg-2 col-sm-2 control-label"></label>
		                                            <div class="col-lg-10">
		                                                <input name="id" value="${role.id }" type="hidden">
		                                                <button type="button" onclick="update()" class="btn btn-success save-button">提 交</button>
		                                            </div>
		                                        </div>
											</c:when>
										
										</c:choose>


                                        <div class="clearfix"></div>
                                    </sf:form>

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
      <form action="${APP_PATH}/admin/role/list" method="get">
      	<input name="pn" type="hidden" value="${pn==null?100000:pn}">
        <button type="submit" class="btn btn-success ">确认</button>
      </form>
      </div>
    </div>
  </div>
  </div>
  
</body>

</html>
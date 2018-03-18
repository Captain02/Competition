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
    <title>添加部门</title>
	<%
	      pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
   <jsp:include page="iniCssHref.jsp"></jsp:include>
<!-- 用于前端正则校验和后端Ajax校验的脚本 -->
<script src="${APP_PATH}/static/js/regAjax.js"></script>
<script type="text/javascript">

		//部门添加
		function add(){
			ifErrorMessage();
			if ($('.save-button').attr("ajax-va") == "error") {
		        return false;
		    }
			
			$.ajax({
				url : "${APP_PATH}/admin/department/add",
				data : $("#addDepartmentInfo").serialize(),
				type : "POST",
				success : function(result){
					console.log(result);
					if (result.code==100) {
						$('#myModal').modal('show');
						ShowTips('.modal-title','执行结果','.modal-body','<b style = "color:#5cb85c;">' + '部门信息添加成功！' + '</b>');
					}else{
						if(undefined != result.extend.errorFields.name){
							ShowTips('.modal-title','执行结果','.modal-body','<b style = "color:#c9302c;">' + '部门信息修改失败！' + '</b>');
							show_validate_msg("#departmentname", "error", "部门名不能为空");
						}
						if(undefined != result.extend.errorFields.address){
							ShowTips('.modal-title','执行结果','.modal-body','<b style = "color:#c9302c;">' + '部门信息修改失败！' + '</b>');
							show_validate_msg("#departmentaddress", "error", "部门地址不能为空");
						}
					}
				}
				
			})
		}
		
		//部门更改
		function update() {
			
			$.ajax({
				url : "${APP_PATH}/admin/department/update/",
				data : $("#addDepartmentInfo").serialize(),
				type : "POST",
				success : function(result){
					if (result.code==100) {
						$('#myModal').modal('show');
						ShowTips('.modal-title','执行结果','.modal-body','<b style = "color:#5cb85c;">' + '部门信息修改成功!' + '</b>');
					}else{
						if(undefined != result.extend.errorFields.name){
							ShowTips('.modal-title','执行结果','.modal-body','<b style = "color:#c9302c;">' + '部门信息修改失败！' + '</b>');
							show_validate_msg("#departmentname", "error", "部门名不能为空");
						}
						if(undefined != result.extend.errorFields.address){
							ShowTips('.modal-title','执行结果','.modal-body','<b style = "color:#c9302c;">' + '部门信息修改失败！' + '</b>');
							show_validate_msg("#departmentaddress", "error", "部门地址不能为空");
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

                                <header class="om-wrapper-header">添加新部门</header>

                                <div class="om-wrpper-body">
                                    <sf:form action="${APP_PATH}/admin/department/add" id="addDepartmentInfo" method="post" modelAttribute="department">
                                       

                                        <!-- 部门名填写区域 -->
                                        <div class="form-group">
                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    <span>*</span>
                                                    部门名
                                                </label>
                                            </div>

                                            <div class="col-sm-10">
                                                <sf:input path="name" id="departmentname" type="text" class="form-control" name="departmentname" value="" placeholder="请填写部门名" />
                                                <span></span>
                                            
                                            </div>
                                        </div>

                                        <!-- 部门描述填写区域 -->
                                        <div class="form-group">

                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    描　述
                                                </label>
                                            </div>

                                            <div class="col-sm-10">
                                                <sf:textarea id="description" path="description" name="departmentdesc" placeholder="请填写描述，例如：研发部，GO组，PHP组，UI组研发部，GO组，PHP组，UI组" style="height:200px;" class="form-control"></sf:textarea>
                                                <span></span>
                                            </div>


                                        </div>

                                        <!-- 部门地址填写区域 -->
                                        <div class="form-group">
                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    <span>*</span>
                                                    部门地址
                                                </label>
                                            </div>

                                            <div class="col-sm-10">
                                                <sf:input id="departmentaddress" path="address" type="text" class="form-control" name="departmentaddr" value="" placeholder="请填写部门地址" />
                                                <span></span>
                                            </div>
                                        </div>

										<c:choose>
											<c:when test="${department.id==null }">
		                                        <!-- 提交按钮 -->
		                                        <div class="form-group">
		                                            <label class="col-lg-2 col-sm-2 control-label"></label>
		                                            <div class="col-lg-10">
		                                                <button type="button" class="btn btn-success save-button" onclick="add()">保 存</button>
		                                            </div>
		                                            
		                                           
		                                        </div>
											</c:when>
											<c:when test="${department.id!=null }">
		                                        <!-- 提交按钮 -->
		                                        <div class="form-group">
		                                            <label class="col-lg-2 col-sm-2 control-label"></label>
		                                            <div class="col-lg-10">
		                                                <input id="id" name="id" value="${department.id }" type="hidden">
		                                                <button type="button" class="btn btn-success save-button" onclick="update()">保 存</button>
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
      
        <!-- 需要在这里加连接 -->
        <form action="${APP_PATH}/admin/department/list/" method="get">
        	<input name="pn" type="hidden" value="${pn==null?1000000:pn}">
        	<button type="submit" class="btn btn-danger">关闭</button>
        </form>
      </div>
    </div>
  </div>
</div>

</body>

</html>
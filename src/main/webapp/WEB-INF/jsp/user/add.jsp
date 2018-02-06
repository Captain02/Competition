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
    <title>添加员工</title>
 	<%
	      pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

<jsp:include page="iniCssHref.jsp"></jsp:include>


<!-- 用于前端正则校验和后端Ajax校验的脚本 -->
<script src="${APP_PATH}/static/js/regAjax.js"></script>

<script>
$(function(){
	ShowEle('.result','hide','.result2','hide');
	$(".down").click(function(){
		$('#myModal').modal('hide');
	});
	
	//用户名的前端校验
	$("#username").change(function () {
	    var username = $("#username").val();
	    //用户名不为空
	    if (ifNull(username)) {
	    	show_validate_msg("#username", "error", "用户名不能为空")
	    }
	    
	    //用户名不能有中文或特殊字符
	    else if (!ifSpecialStr(username)) {
	    	show_validate_msg("#username", "error", "用户名不能含有中文或特殊字符");
	    }
	   
	    //用户名不能重复
	    else {
	        $.ajax({
	            url: "${APP_PATH}/admin/user/duplicateChecking",
	            data: "username=" + username,
	            type: "POST",
	            success: function (result) {
	                if (result.code == 100) {
	                    show_validate_msg("#username", "success", "用户名可用");
	                } else {
	                    show_validate_msg("#username", "error", "用户名已存在！");
	                }
	            }
	        });
	    }
	});
	
})


//保存按钮
function save() {
	//判定页面上是否有错误信息
	ifErrorMessage();
	 if ($('.save-button').attr("ajax-va") == "error") {
	        return false;
	    }
    $.ajax({
        url: "${APP_PATH}/admin/user/add",
        data: $("#addUserInfo").serialize(),
        type: "POST",
        success: function (result) {
        	
            if (result.code == 100) {
            	$('#myModal').modal('show');
            	ShowTips('.modal-title','执行结果','.modal-body','人员信息添加成功');
				ShowEle('.yes','show','.no','hide','.down','hide');
            }else{
            	//后端校验失败信息
            	if (undefined != result.extend.errorFields.username) {
            		show_validate_msg("#username", "error", "用户名不为空且不能含有中文或特殊字符");
				}
            	if(undefined != result.extend.errorFields.password){
            		show_validate_msg("#password", "error", "密码不为空");
            	}
            	if(undefined != result.extend.errorFields.phone){
            		show_validate_msg("#phone", "error", "手机号不为空且不能含有中文或特殊字符");
            	}
            	if(undefined != result.extend.errorFields.name){
            		show_validate_msg("#name", "error", "姓名不为空");
            	}
            }
        }
    });
}

//修改时的更新按钮
function update() {

	//判定页面上是否有错误信息
	ifErrorMessage();
	 if ($('.save-button').attr("ajax-va") == "error") {
	        return false;
	    }
    // ajax请求
    $.ajax({
        url: "${APP_PATH}/admin/user/update",
        data: $("#addUserInfo").serialize(),
        type: "POST",
        success: function (result) {
        	console.log(result);
            if (result.code == 100) {
            	 $('#myModal').modal('show');
                 ShowTips('.modal-title','执行结果','.modal-body','<b style = "color:#5cb85c;">' + '人员信息修改成功!' + '</b>');
                 ShowEle('.yes','show','.no','hide','.down','hide');
            } else{
            	//后端校验失败信息
            	if (undefined != result.extend.errorFields.username) {
            		show_validate_msg("#username", "error", "用户名不为空且不能含有中文或特殊字符");
				}
            	if(undefined != result.extend.errorFields.password){
            		show_validate_msg("#password", "error", "密码不为空");
            	}
            	if(undefined != result.extend.errorFields.phone){
            		show_validate_msg("#phone", "error", "手机号不为空且不能含有中文或特殊字符");
            	}
            	if(undefined != result.extend.errorFields.name){
            		show_validate_msg("#name", "error", "姓名不为空");
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
                        
                        <div class="clearfix">
                        
                        </div>
                    </div>

                    <div class="om-wrapper">
                        <div class="row">
                            <div class="col-sm-12">

                                <header class="om-wrapper-header">添加新员工</header>

                                <div class="om-wrpper-body">
                                    <sf:form id="addUserInfo" method="post" modelAttribute="user">
                                        <header>基本信息（带*号的为必填项）</header>

                                        <!-- 用户名填写区域 -->
                                        <div class="form-group">
                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    <span>*</span>
                                                                                                                                                                             用户名
                                                </label>
                                            </div>

                                            <div class="col-sm-10">
                                                <sf:input id="username" type="text" class="form-control user-message" path="username" value="" placeholder="请填写用户名" />
                                                <span></span>
                                            </div>
                                        </div>

                                        <!-- 密码填写区域 -->
                                        <c:if test="${user.id!=null}">
	                                    	<sf:input id="password" type="hidden" class="form-control user-message" path="password" value="" placeholder="请填写密码" />
                                        </c:if>
                                        <c:if test="${user.id==null}">
                                        <div class="form-group">
                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                <span>*</span>
                                              密　码
                                                </label>
                                            </div>
	                                            <div class="col-sm-10">
	                                                <sf:input id="password" type="text" class="form-control user-message" path="password" value="" placeholder="请填写密码" />
	                                                <span></span>
	                                            </div>
                                        </div>
                                        </c:if>
                                        <!-- 部门填写区域 -->
                                        <div class="form-group">


                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                   
                                                    部　门
                                                </label>
                                            </div>


                                            <div class="col-sm-10">
                                            <!-- 隐藏域，用来暂存后端传来的值 -->
                                            <a class = "result">${userDepartment.id }</a>
                                                <select id="departmentId" class="form-control form-control-active" name="departmentId" id="departmentSelect">
                                                
                                                	<c:if test="${userDepartment!=null}">
                                                	
                                                		<option value="${userDepartment.id }">${userDepartment.name}</option>
                                                	</c:if>
                                                	<c:forEach items="${department}" var="department">
                                                    	<option name="notDefault" value="${department.id }">${department.name}</option>
                                                	</c:forEach>
                                                </select>
                                                
                                                

                                            </div>
                                        <script>
                                       var result = $('.result').html();
                                       var option = $('#departmentId > option');
                                       
                                       for(var i = 0; i<option.length; i++){
                                    	   
                                    	   if( $(option[i]).val() == result && $(option[i]).attr('name') == 'notDefault' ){
                                    		   $(option[i]).remove();
                                    	   }
                                       }
                                       
                                        </script>

                                        </div>

                                        <!-- 职位填写区域 -->
                                        <div class="form-group">
                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    
                                                    职　位
                                                </label>
                                            </div>
                                            <div class="col-sm-10">
                                             <!-- 隐藏域，用来暂存后端传来的值 -->
                                            <a class = "result2">${userRole.id }</a>
                                                <select id="roleId" class="form-control form-control-active" name="roleId" >
                                                	<c:if test="${userRole!=null}">
                                                		<option value="${userRole.id }">${userRole.name}</option>
                                                	</c:if>
                                                   <c:forEach items="${role}" var="role">
                                                   		<option  name="notDefault" value="${role.id }">${role.name}</option>
                                                   </c:forEach>
                                                    
                                                </select>
                                                <script>
                                       var result = $('.result2').html();
                                       var option = $('#roleId > option');
                                       
                                       for(var i = 0; i<option.length; i++){
                                    	   
                                    	   if( $(option[i]).val() == result && $(option[i]).attr('name') == 'notDefault' ){
                                    		   $(option[i]).remove();
                                    	   }
                                       }
                                       
                                       
                                        </script>
                                            </div>
                                           
                                        </div>

                                        <header>帐号信息（带*号的为必填项）</header>

                                        <!-- 姓名填写区域 -->
                                        <div class="form-group">


                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    <span>*</span>
                                                                                                                                                                             姓　名
                                                </label>
                                            </div>


                                            <div class="col-sm-10">
                                                <sf:input type="text" class="form-control user-message" path="name" value="" placeholder="请填写姓名" />
                                                 <span></span>
                                            </div>

                                        </div>

                                        <!-- 性别填写区 -->

                                        <div class="form-group">


                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    
                                                    性　别
                                                </label>
                                            </div>


                                            <div class="col-sm-10">
                                                <label for="" class="radio-inline">
                                                    <sf:radiobutton path="sex" value="男" checked="true" />男
                                                </label>
                                                <label for="" class="radio-inline">
                                                	<sf:radiobutton path="sex" value="女" />女
                                                    <%-- <sf:input type="radio" path="sex" value="女" checked="" /> 女 --%>
                                                </label>
                                            </div>

                                        </div>

<!-- 联系方式填写区 -->
<div class="form-group">

                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    <span>*</span>
                                                    手　机
                                                </label>
                                            </div>


                                            <div class="col-sm-10">
                                                <sf:input type="text" class="form-control user-message" path="phone" value="" placeholder="请填写手机号" />
                                                <span></span>
                                            </div>

                                        </div>



                                        <!-- QQ填写区 -->
                                        <div class="form-group">


                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    <span></span>
                                                    Q　Q
                                                </label>
                                            </div>


                                            <div class="col-sm-10">
                                                <sf:input type="text" class="form-control" path="qq" value="" placeholder="请填写QQ" />
                                            </div>

                                        </div>

                                        <!-- 学历填写区 -->
                                        <div class="form-group">
                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    学　历
                                                </label>
                                            </div>
                                            <div class="col-sm-10">
                                                <sf:select class="form-control" path="edu">
                                                    <sf:option value="高中">高中</sf:option>
                                                    <sf:option value="中专">中专</sf:option>
                                                    <sf:option value="本科">本科</sf:option>
                                                    <sf:option value="大专">大专</sf:option>
                                                    <sf:option value="研究生">研究生</sf:option>
                                                    <sf:option value="硕士">硕士</sf:option>
                                                    <sf:option value="博士">博士</sf:option>
                                                </sf:select>
                                            </div>
                                        </div>

                                        
                                        <c:choose>  
										   <c:when test="${user.id==null}">
										     	<!-- 保存按钮 -->
										     	<div class="form-group">
		                                            <label class="col-lg-2 col-sm-2 control-label"></label>
		                                            <div class="col-lg-10">
		                                                <button type="button" onclick="save()" class="btn btn-success save-button">保 存</button>
		                                            </div>
		                                        </div>
										   </c:when>
										   
										   <c:when test="${user.id!=null}">
										     	<!-- 修改按钮 -->
										     	<div class="form-group">
		                                            <label class="col-lg-2 col-sm-2 control-label"></label>
		                                            <div class="col-lg-10">
		                                            	<input id="id" name="id" value="${user.id }" type="hidden">
		                                                <button type="button" class="btn btn-success save-button" onclick="update()">修改</button>
		                                            </div>
		                                        </div>
										   </c:when>
										   
										</c:choose>
                                        


                                        <div class="clearfix"></div>
                                    </sf:form>
                                    <sf:form></sf:form>

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
      <form action="${APP_PATH}/admin/user/list" method="get">
      	<input name="pn" type="hidden" value="${pn==null?100000:pn}">
        <button type="submit" class="btn btn-warning yes">确认</button>
        <button type="button" class="btn btn-success no">取消</button>
        <button type="button" class="btn btn-danger down">关闭</button>
      </form>
      </div>
    </div>
  </div>
</div>
</body>

</html>
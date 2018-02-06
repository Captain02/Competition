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
    <title>成员编辑</title>

     <%
         pageContext.setAttribute("APP_PATH", request.getContextPath());
     %>
     

    <jsp:include page="iniCssHref.jsp"></jsp:include>
    <script type="text/javascript">
    	function update(){
    		var userId = $("#userId").val();
    		var roleId = $("#roleId").val();
    		$.ajax({
    			url:"${APP_PATH}/admin/member/update",
        		data:"userId="+userId+"&roleId="+roleId,
        		type:"POST",
        		success : function(result) {
    				if (result.code==100) {
    					$('.modal-title').html('执行结果');
						$('.modal-body').html('成员信息修改成功');
						ShowTips('.modal-title','执行结果','.modal-body','<b style = "color:#c9302c;">' + '成员信息修改成功！' + '</b>');
    				}
    			}
    		})
    	}
    
    </script>
    
    <script type="text/javascript">
    $(function(){
    	$('.member-username').attr("disabled","disabled");
    	$('.member-name').attr("disabled","disabled");
    })
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

                                <header class="om-wrapper-header">编辑成员信息</header>

                                <div class="om-wrpper-body">
                                    <sf:form action="" id="addMemberInfo" modelAttribute="user">

 										<!--  用户名填写区域 -->
                                        <div class="form-group">
                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    用户名
                                                </label>
                                            </div>

                                            <div class="col-sm-10">
                                                <sf:input path="username" type="text" class="form-control member-username" />
                                            </div>
                                        </div>


                                        <!-- 成员名填写区域 -->
                                        <div class="form-group">
                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    成员姓名
                                                </label>
                                            </div>

                                            <div class="col-sm-10">
                                                <sf:input path="name" type="text" class="form-control member-name" />
                                            </div>
                                        </div>




                                        <!-- 职位选择区域 -->
                                        <div class="form-group">
                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    <span>*</span>
                                                    职　　位
                                                </label>
                                            </div>
                                            <div class="col-sm-10">
                                                <select class="form-control" id="roleId">
                                                   <c:if test="${user.id!=null}">
                                                		<option value="${user.role.id }">${user.role.name}</option>
                                                	</c:if>
                                                   <c:forEach items="${role}" var="role">
                                                   		<option  name="notDefault" value="${role.id }">${role.name}</option>
                                                   </c:forEach>
                                                </select>
                                            </div>
                                        </div>



                                        <!-- 提交按钮 -->
                                        <div class="form-group">
                                            <label class="col-lg-2 col-sm-2 control-label"></label>
                                            <div class="col-lg-10">
                                            	<input id="userId" value="${user.id }" type="hidden">
                                                <button type="button" onclick="update()" class="btn btn-success" data-toggle="modal" data-target="#myModal">保存修改</button>
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
      
      	<form action="${APP_PATH}/admin/member/list/${user.role.id}" method="get">
	        <input type="hidden" name="pn" value="${pn}">
	        <button type="submit" class="btn btn-success">确认</button>
      	</form>
        
      </div>
    </div>
  </div>
  </div>
  
</body>

</html>
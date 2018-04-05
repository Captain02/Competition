<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <style>
        .resource-name li {
            float: left;
            width: 130px;
        }

        .form-group label {
            font-weight: normal;
            font-size: 14px;
            cursor: pointer;
        }

        .resource-list h4 {
            cursor: pointer;
            margin-bottom: 15px;
        }
        .om-wrapper-header{
        	border-bottom: none;
        }
    </style>
    
<script type="text/javascript">
$(function(){
	var resourceArray = new Array();
	
	$('.hasResourceId').each(function(){
		var hashasResourceId = $(this);
		resourceArray.push(hashasResourceId.val());
	})

	$('.resourceId').each(function(){
		var resourceId = $(this);
		if( $.inArray(resourceId.val(),resourceArray) >= 0 ){
			resourceId.attr('checked','checked');
		}
	});
	
	$(".resourceId").on("click",function(){
		var c = 0;
		var ifChecked = this.checked;
		var roleId = "${roleId}";
        var resourceId = $(this).val();
        
		if (ifChecked) {
			c = 1;
		}
		
		 $.ajax({
			url:"${APP_PATH}/admin/role/updateResource",
			data:"roleId="+roleId+"&resourceId="+resourceId+"&check="+c,
			type:"GET",
			success:function(result){
				if (result.code==200) {
					alert("修改失败");
				}
			}
		}) 
	})
	
})
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
	                    	<header class="om-wrapper-header">权限的编辑</header>
                            <form action="" id="resource-form" name="resource-form" class="resource-form">
                            
	                           <c:forEach items="${roleHasResourceList}" var="roleHasResourceList">
	                            <input type="hidden" class="hasResourceId" value="${roleHasResourceList.id }"/>
	                           </c:forEach>
	
								<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
								  <!-- 系统管理 -->
								  <div class="panel panel-default">
								    <div class="panel-heading" role="tab" id="headingOne">
								      <h4 class="panel-title">
								        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#system" href="#SystemManagement" aria-expanded="false" aria-controls="SystemManagement">
								          	权限：系统管理
								        </a>
								      </h4>
								    </div>
								    <div id="SystemManagement" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
								      <div class="panel-body">
								       <ul id="resource-list" name="resource-list" class="list-unstyled resource-list clearfix">
	                               <li>
	                                   <ul class="resource-name clearfix">
	                                       <c:forEach items="${system}" var="system">
	                                         <li>
	                                            <div class="form-group">
	                                                <label for="${system.id}" class="checkbox-inline ">
	                                                    <input type="checkbox" name="id" class="resourceId" value="${system.id}" id="${system.id}"> ${system.name }
	                                                </label>
	                                            </div>
	                                        </li>
	                                        </c:forEach>
	                                   </ul>
	                               </li>
	                           </ul>
								      </div>
								   </div>
								  </div>
								  <!-- 权限：日程管理 -->
								  <div class="panel panel-default">
								    <div class="panel-heading" role="tab" id="headingNine">
								      <h4 class="panel-title">
								        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#ScheduleManagement" href="#ScheduleManagement" aria-expanded="false" aria-controls="ScheduleManagement">
								          	权限：日程管理
								        </a>
								      </h4>
								    </div>
								    <div id="ScheduleManagement" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingNine">
								      <div class="panel-body">
								       <ul id="resource-list" name="resource-list" class="list-unstyled resource-list clearfix">
	                               <li>
	                                   <ul class="resource-name clearfix">
	                                       <c:forEach items="${schedule}" var="schedule">
	                                         <li>
	                                            <div class="form-group">
	                                                <label for="${schedule.id}" class="checkbox-inline ">
	                                                    <input type="checkbox" name="id" class="resourceId" value="${schedule.id}" id="${schedule.id}"> ${schedule.name }
	                                                </label>
	                                            </div>
	                                        </li>
	                                        </c:forEach>
	                                   </ul>
	                               </li>
	                           </ul>
								      </div>
								   </div>
								  </div>
								  
								  <!-- 权限：项目管理 -->
								  <div class="panel panel-default">
								    <div class="panel-heading" role="tab" id="headingTwo">
								      <h4 class="panel-title">
								        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#ProjectManagement" aria-expanded="false" aria-controls="ProjectManagement">
								          	权限：项目管理
								        </a>
								      </h4>
								    </div>
								    <div id="ProjectManagement" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
								      <div class="panel-body">
								       <ul id="resource-list" name="resource-list" class="list-unstyled resource-list clearfix">
	                               <li>
	                                   <ul class="resource-name clearfix">
	                                       <c:forEach items="${project}" var="project">
	                                         <li>
	                                            <div class="form-group">
	                                                <label for="${project.id}" class="checkbox-inline ">
	                                                    <input type="checkbox" name="id" class="resourceId" value="${project.id}" id="${project.id}"> ${project.name }
	                                                </label>
	                                            </div>
	                                        </li>
	                                        </c:forEach>
	                                   </ul>
	                               </li>
	                           </ul>
								      </div>
								    </div>
								  </div>
								 
								 <!-- 权限：考勤管理 -->
								 <div class="panel panel-default">
								    <div class="panel-heading" role="tab" id="headingThree">
								      <h4 class="panel-title">
								        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#AttendanceManagement" aria-expanded="false" aria-controls="AttendanceManagement">
								          	权限：考勤管理
								        </a>
								      </h4>
								    </div>
								    <div id="AttendanceManagement" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
								      <div class="panel-body">
								       <ul id="resource-list" name="resource-list" class="list-unstyled resource-list clearfix">
	                               <li>
	                                   <ul class="resource-name clearfix">
	                                       <c:forEach items="${workAttendence}" var="workAttendence">
	                                         <li>
	                                            <div class="form-group">
	                                                <label for="${workAttendence.id}" class="checkbox-inline ">
	                                                    <input type="checkbox" name="id" class="resourceId" value="${workAttendence.id}" id="${workAttendence.id}"> ${workAttendence.name }
	                                                </label>
	                                            </div>
	                                        </li>
	                                        </c:forEach>
	                                   </ul>
	                               </li>
	                           </ul>
								      </div>
								    </div>
								  </div>
								 
								 <!-- 权限：审批管理 -->
								  <div class="panel panel-default">
								    <div class="panel-heading" role="tab" id="headingFour">
								      <h4 class="panel-title">
								        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#ApprovalManagement" aria-expanded="false" aria-controls="ApprovalManagement">
								          	权限：审批管理
								        </a>
								      </h4>
								    </div>
								    <div id="ApprovalManagement" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
								      <div class="panel-body">
								       <ul id="resource-list" name="resource-list" class="list-unstyled resource-list clearfix">
	                               <li>
	                                   <ul class="resource-name clearfix">
	                                       <c:forEach items="${examination}" var="examination">
	                                         <li>
	                                            <div class="form-group">
	                                                <label for="${examination.id}" class="checkbox-inline ">
	                                                    <input type="checkbox" name="id" class="resourceId" value="${examination.id}" id="${examination.id}"> ${examination.name }
	                                                </label>
	                                            </div>
	                                        </li>
	                                        </c:forEach>
	                                   </ul>
	                               </li>
	                           </ul>
								      </div>
								    </div>
								  </div>
								 
								 <!-- 权限：组织管理 -->
								 <div class="panel panel-default">
								    <div class="panel-heading" role="tab" id="headingFive">
								      <h4 class="panel-title">
								        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#OrganizationManagement" aria-expanded="true" aria-controls="OrganizationManagement">
								          	权限：组织管理
								        </a>
								      </h4>
								    </div>
								    <div id="OrganizationManagement" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingFive">
								      <div class="panel-body">
								        <ul id="resource-list" name="resource-list" class="list-unstyled resource-list clearfix">
	                               <li>
	                                   <ul class="resource-name clearfix">
	                                       <c:forEach items="${resources}" var="resources">
	                                         <li>
	                                            <div class="form-group">
	                                                <label for="${resources.id}" class="checkbox-inline ">
	                                                    <input type="checkbox" name="id" class="resourceId" value="${resources.id}" id="${resources.id}"> ${resources.name }
	                                                </label>
	                                            </div>
	                                        </li>
	                                        </c:forEach>
	                                   </ul>
	                               </li>
	                           </ul>
								      </div>
								    </div>
								</div>
								 
								 <!-- 权限：流程管理 --> 
								 <div class="panel panel-default">
								    <div class="panel-heading" role="tab" id="headingSix">
								      <h4 class="panel-title">
								        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
								          	权限：流程管理
								        </a>
								      </h4>
								    </div>
								    <div id="collapseSix" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingSix">
								      <div class="panel-body">
								        <ul id="resource-list" name="resource-list" class="list-unstyled resource-list clearfix">
	                               <li>
	                                   <ul class="resource-name clearfix">
	                                       <c:forEach items="${processDefinition}" var="processDefinition">
	                                         <li>
	                                            <div class="form-group">
	                                                <label for="${processDefinition.id}" class="checkbox-inline ">
	                                                    <input type="checkbox" name="id" class="resourceId" value="${processDefinition.id}" id="${processDefinition.id}"> ${processDefinition.name }
	                                                </label>
	                                            </div>
	                                        </li>
	                                        </c:forEach>
	                                   </ul>
	                               </li>
	                           </ul>
								      </div>
								    </div>
								  </div>
								
								<!--权限：知识分享 -->
								<div class="panel panel-default">
								    <div class="panel-heading" role="tab" id="headingSeven">
								      <h4 class="panel-title">
								        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#ProcessManagement" aria-expanded="false" aria-controls="collapseThree">
								          	权限：知识分享
								        </a>
								      </h4>
								    </div>
								    <div id="ProcessManagement" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingSeven">
								      <div class="panel-body">
								        <ul id="resource-list" name="resource-list" class="list-unstyled resource-list clearfix">
	                               <li>
	                                   <ul class="resource-name clearfix">
	                                       <c:forEach items="${knowlege}" var="knowlege">
	                                         <li>
	                                            <div class="form-group">
	                                                <label for="${knowlege.id}" class="checkbox-inline ">
	                                                    <input type="checkbox" name="id" class="resourceId" value="${knowlege.id}" id="${knowlege.id}"> ${knowlege.name }
	                                                </label>
	                                            </div>
	                                        </li>
	                                        </c:forEach>
	                                   </ul>
	                               </li>
	                           </ul>
								      </div>
								    </div>
								  </div>
								
								<!-- 权限：员工相册 -->
								<div class="panel panel-default">
								    <div class="panel-heading" role="tab" id="headingEight">
								      <h4 class="panel-title">
								        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#StaffPhoto" aria-expanded="false" aria-controls="headingEight">
								          	权限：员工相册
								        </a>
								      </h4>
								    </div>
								    <div id="StaffPhoto" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingEight">
								      <div class="panel-body">
								        <ul id="resource-list" name="resource-list" class="list-unstyled resource-list clearfix">
	                               <li>
	                                   <ul class="resource-name clearfix">
	                                       <c:forEach items="${image}" var="image">
	                                         <li>
	                                            <div class="form-group">
	                                                <label for="${image.id}" class="checkbox-inline ">
	                                                    <input type="checkbox" name="id" class="resourceId" value="${image.id}" id="${image.id}"> ${image.name }
	                                                </label>
	                                            </div>
	                                        </li>
	                                        </c:forEach>
	                                   </ul>
	                               </li>
	                           </ul>
								      </div>
								    </div>
								  </div>
								
								
								</div>
									                       
                            </form>
                            
                           
	                    </div>
		           </div>
		      </div>        
	               
               </div>



        </div>
   
   
    </section>
</body>

</html>
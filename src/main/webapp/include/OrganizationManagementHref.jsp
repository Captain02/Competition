<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%
	      pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
<div class="om-header-left">
	<h3>
		<span class="om-title">组织管理</span> 
			<span class="om-list"> 
				<a href="${APP_PATH}/admin/user/list">员工</a> 
				<a href="${APP_PATH}/admin/department/list">部门</a>
				<a href="${APP_PATH}/admin/role/list">职称</a> 
				<a href="">公告</a> 
				<a href="${APP_PATH}/admin/resource/list">权限</a>
			</span>
	</h3>
</div>
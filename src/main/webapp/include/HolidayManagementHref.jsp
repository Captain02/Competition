<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%
	      pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
<div class="om-header-left">
	<h3>
		<span class="om-title">审批管理</span> <span class="om-list"> <a
			href="${APP_PATH}/admin/holiday/list">请假</a> <a
			href="${APP_PATH}/admin/reimbursement/list">报销</a> <a
			href="${APP_PATH}/admin/role/list">物品</a>
		</span>
	</h3>
</div>
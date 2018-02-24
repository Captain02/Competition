<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
		 <span class="om-list pro-href">
			<a href="" class="btn btn-info btn-sm">团队</a>
			<a href="${APP_PATH}/admin/demand/list" class="btn btn-danger btn-sm">需求</a> 
			<a class="btn btn-primary btn-sm">任务</a>
			 <a	class="btn btn-warning btn-sm">Bug</a>
			 <a	class="btn btn-success btn-sm">文档</a>
			 <a	class="btn btn-danger btn-sm">版本</a>
			 <a	class="btn btn-warning btn-sm">报表</a>
		</span>
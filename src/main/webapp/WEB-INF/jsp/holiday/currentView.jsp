<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看当前流程图</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
</head>
<body>
<img style="position: absolute;top: 0px;left: 0px"  src="${APP_PATH}/admin/processDefinition/showView/${deploymentId}/${diagramResourceName}">

<div style="position: absolute;border: 1px solid red;top:${y-3}px;left:${x-3}px;width:${width+3}px;height:${height+3}px"></div>
</body>
</html>
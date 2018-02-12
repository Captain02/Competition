<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>历史消息页</title>
</head>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<body>
	<ul>
		<li class="message-history-list">
			<div class="user-info-username">admin</div>
			<div class="user-info-datetime">2017-01-01 12:00:00</div>
			<div></div>
		</li>
	</ul>
</body>
</html>
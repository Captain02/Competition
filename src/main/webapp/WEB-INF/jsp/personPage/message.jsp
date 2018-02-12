<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<c:forEach items="${listMessage}" var="message">
		<li class="message-history-list">
			<!-- 我的id -->
			<input type="hidden" value="${myId}">
			<!-- 消息的发送人id -->
			<input type="hidden" value="${message.user.id}">
			<div class="user-info-username">${message.user.name}</div>
			<div class="user-info-datetime">${message.date}</div>
			<div>${message.text}</div>
		</li>
		</c:forEach>
	</ul>
</body>
</html>
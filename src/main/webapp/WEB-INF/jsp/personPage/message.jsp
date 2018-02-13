<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>历史消息页</title>
</head>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<body>
	
	<ul class="message-history-area">
		<c:forEach items="${pageInfo.list}" var="message">
		<li class="message-history-list clearfix" data-myid="${myId}" data-userid="${message.user.id}">
			<div class="user-info-nametime clearfix">
				<span class="user-info-username">${message.user.name}</span>
				<span class="user-info-datetime">${message.date}</span>
			</div>
			<div class="user-info-mestext">
				<span class="user-info-text">${message.text}</span>
			</div>
		</li>
		</c:forEach>
	</ul>
	
	
</body>

</html>
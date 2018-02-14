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
<style>
	html{
		height: 100%;
	}
	ul.message-history-area{
		height: 90%;
		overflow-y:auto;
	}
	div.page-nav{
		position:fixed;
		bottom:0;
		left:0;
		width:100%;
		height: 10%;
		background-color:#fff;
		z-index: 999;
	}
	ul.pagination{
		margin: 0;
		height: 100%;
	}
	div.page-nav nav{
		height: 100%;
	}
	div.page-nav nav li{
		float: left;
		position: relative;
      	top: 25%;
	}
	div.page-nav nav li a{
		padding: 0;
		display:inline-block;
		margin-right: 10px;
		padding: 5px;
	}
</style>
<body>
	
	<ul class="message-history-area clearfix">
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
	
	<div class="page-nav clearfix">
		<nav aria-label="..." class="pull-right">
		  <ul class="pagination pagination-sm clearfix">
		   <li data-info-control="start">
			     <a href="#" aria-label="Previous">
			       <span aria-hidden="true">首页</span>
			     </a>
			   </li>
			    <li data-info-control="prev"><a href="#">上一页</a></li>
			   <li data-info-control="next"><a href="#">下一页</a></li>
			   <li data-info-control="end">
			     <a href="#" aria-label="Next">
			       <span aria-hidden="true">末页</span>
			     </a>
			   </li>
		  </ul>
		</nav>
	</div>
	

</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工相册</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
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
				<div class="om-wrapper">
					<div class="row">
						<div class="col-sm-12">

							<header class="om-wrapper-header">
								精彩相片
								<div class="pull-right">
									<a href="" class="btn btn-warning btn-sm">我的相片</a>
									<a href="" class="btn btn-success btn-sm">全部相片</a>
									<a href="" class="btn btn-success btn-sm">+上传相片</a>
								</div>
							</header>

							<div class="om-wrpper-body"></div>

						</div>

					</div>



				</div>

			</div>

		</div>
	</section>

</body>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
				
					<div class="row">
						<div class="col-lg-12">

							<section class="panel">
								<header class="om-wrapper-header" style="padding-left:15px;">
								精彩相片
								<div class="pull-right">
									<a href="" class="btn btn-warning btn-sm">我的相片</a>
									<a href="" class="btn btn-success btn-sm">全部相片</a>
									<a href="${APP_PATH}/admin/image/add" class="btn btn-success btn-sm">+上传相片</a>
								</div>
							</header>
								<div class="panel-body">
									<div id="gallery" class="media-gal">
									<c:forEach items="${MyImageDispaly}" var="MyImageDispaly">
										<div class="images item ">
											<a href="">
												<img src="${APP_PATH}/myImage/${MyImageDispaly.imageName}" alt="" />
											</a>
											<p><a href="${APP_PATH}/admin/KnowledgeSharing/detailedTopic?topicId=${MyImageDispaly.topicId}">${fn:substring(MyImageDispaly.title,0, 10)}</a> </p>
											<p>${MyImageDispaly.sketch}</p>
											<p>${MyImageDispaly.userName}${fn:substring(MyImageDispaly.date, 0, 10)}上传</p>
											<p>
												<a href=""><i class="glyphicon glyphicon-edit"></i></a>
												<a href=""><i class="glyphicon glyphicon-trash"></i></a>
											</p>
										</div>
									</c:forEach>
									</div>
								</div>
							</section>
						</div>

					</div>



				

			</div>

		</div>
	</section>

</body>

</body>
</html>
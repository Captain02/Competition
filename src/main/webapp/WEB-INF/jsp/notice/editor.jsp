<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>发布新公告</title>
	<%
	      pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
	<jsp:include page="iniCssHref.jsp"></jsp:include>
<script type="text/javascript">
function update() {
	$.ajax({
		url:"${APP_PATH}/admin/notice/update",
		type:"POST",
		data:$("#noticeForm").serialize(),
		success:function(){
			//类似删除贴吧，弹出模态款直接跳转一下连接
			//${APP_PATH}/admin/notice/list
		}
	})
}
</script>

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

                    <div class="om-header">

                        <jsp:include page="iniOrganizationManagementHref.jsp"></jsp:include>
                        <div class="clearfix"></div>
                    </div>

                    <div class="om-wrapper">
                        <div class="row">
                            <div class="col-sm-12">

                                <header class="om-wrapper-header">添加新公告</header>

                                <div class="om-wrpper-body">
								<div class="row">
									<div class="col-lg-12">
										<section class="panel">
											<div class="panel-body">
												<sf:form modelAttribute="notice" id="noticeForm" class="form-horizontal" method="post" action="">
													<sf:hidden path="id" name="id"/>
													<div class="form-group">
														<label class="col-sm-2 col-sm-2 control-label"><span>*</span>标题</label>
														<div class="col-sm-10">
															<sf:input path="title" name="title" value="" class="form-control" placeholder="请填写公告标题" type="text" />
														</div>
													</div>
													<div class="form-group">
														<label class="col-sm-2 col-sm-2 control-label"><span>*</span>内容</label>
														<div class="col-sm-10">
															<sf:textarea path="text" name="text" placeholder="请填写公告内容" style="height: 90px;" class="form-control"></sf:textarea>
														</div>
													</div>
													<div class="form-group">
														<label class="col-lg-2 col-sm-2 control-label"></label>
														<div class="col-lg-10">
															<button type="button" onclick="update()" class="btn btn-primary btn-success">提交</button>
														</div>
													</div>
												</sf:form>
											</div>
										</section>
									</div>
								</div>
							</div>

                            </div>

                        </div>

                      
                       

                    </div>
                </div>
            </div>

        </section>
        
        <!-- 模态框 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
<div class="modal-dialog" role="document">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <h4 class="modal-title" id="myModalLabel"></h4>
    </div>
    <div class="modal-body">
      
    </div>
    <div class="modal-footer">
    
      <button type="button" class="btn btn-warning yes">确认</button>
      <button type="button" class="btn btn-success no">取消</button>
     </div>
   </div>
 </div>
</div>

 </body>

</html>
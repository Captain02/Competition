<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>添加模块</title>

<%
   pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<script src="${APP_PATH}/static/js/selectAll.js"></script>
</head>
    <body class="bg-common stickey-menu">

        <section>

            <!-- 页面模版，每页左侧区域固定不变 -->
             <jsp:include page="iniLeftMenu.jsp"></jsp:include>


            <div class="main-content">

                <!-- 页面模版，每页主体部分头部按需更改 -->
                <div class="content-head content-head-section">

                    <a href="" class="toggle-btn">
                        <span class="glyphicon glyphicon-th-list"></span>
                    </a>

                    <form action="${APP_PATH}/admin/deploy/list" class="serach-form" method="get">

                        

                        <input type="text" placeholder="输入流程部署名称" value="${name}" class="form-control" name="name">

                        <button type="submit" class="btn btn-primary">搜索</button>


                        <div class="clearfix"></div>
                    </form>


                     <jsp:include page="iniUserInfo.jsp"></jsp:include>

                    <div class="clearfix"></div>

                </div>

                <!-- 页面模版，按需更改 -->
                <div class="wrapper">

                    <div class="om-header">

                        <div class="om-header-left">
                            <h3>
                                <span class="om-title">流程管理</span>
                                <span class="om-list">
                                    <a href="${APP_PATH}/admin/deploy/list">流程部署</a>
                                    <a href="${APP_PATH}/admin/processDefinition/list">流程定义</a>
									 <a href="${APP_PATH}/admin/processDefinition/list">模块管理</a>
                                </span>
                            </h3>
                        </div>



                        <div class="clearfix"></div>
                    </div>

                    <div class="om-wrapper">
                        <div class="row">
                            <div class="col-sm-12">

                                <header class="om-wrapper-header">添加模块 </header>

                                <div class="om-wrpper-body">
                                    <form action="${APP_PATH}/admin/model/create" id="modelAdd" class="model-add" method="get">
                                        
                                         <div class="form-group">
										    <label class="col-md-2 control-label" for="modelName">模型名称</label>
										    <div class="col-md-10">
										    	<input type="text" class="form-control" name="modelName" id="modelName" placeholder="请输入模型名称">
										    </div>
						 				 </div>
						 				 
										  <div class="form-group">
										    <label class="col-md-2 control-label" for="modelId">模型唯一标识</label>
										    <div class="col-md-10"><input type="text" name="modelKey" class="form-control" id="modelId" placeholder="请输入模型标识"></div>
										  </div>
										  
										   <div class="form-group">
										    <label class="col-md-2 control-label" for="modelDesc">描述</label>
										    <div class="col-md-10"><input type="text" name="modelDescription" class="form-control" id="modelDesc" placeholder="请输入模型唯一描述"></div>
										  </div>
						  
						  				<div class="form-group">
						  					<label class="col-md-2 control-label" for=""></label>
						  					<div class="col-md-10">
					  						 	<button type="reset" class="btn btn-default btn-warning">重置</button>
					  							<button type="submit" class="btn btn-default btn-success">保存</button>
						  					</div>
						  				</div>
                                        
                                    </form>
                                </div>

                            </div>

                        </div>

                    </div>
                </div>
            </div>

        </section>
    </body>

</html>
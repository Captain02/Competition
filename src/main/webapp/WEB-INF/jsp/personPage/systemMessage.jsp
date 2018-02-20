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
    <title>消息管理</title>

<%
   pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<!-- 控制按钮的状态以及模态框展示的信息 -->
<script src="${APP_PATH}/static/js/selectAll.js"></script>
</head>

<body>

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
                                <span class="om-title">消息管理</span>
                               
                            </h3>
                        </div>

                        


                        <div class="clearfix"></div>
                    </div>

                    <div class="om-wrapper">
                        <div class="row">
                            <div class="col-sm-12">

                                <header class="om-wrapper-header">消息管理 / 总数：</header>

                                <div class="om-wrpper-body">
                                    <form action="" id="user-list" class="user-list">
                                        <table class="table table-info">

                                            <thead>
                                                <tr>
                                                <th colspan="1">
                                                	<input type="checkbox" name="selectAll" class="selectAll pull-left" id="selectAll">
                                                	<button class="btn btn-danger btn-sm pull-left" style="margin-left: 20px;">删除</button>
                                                </th>
                                                  
                                                </tr>
                                            </thead>

                                            <tbody>
												
	                                                <tr>
	                                                <td colspan="1">
	                                                   <input type="checkbox" name="selectItem" class="selectItem pull-left">
	                                                   <div class="info-desc" style="margin-left: 20px;">
		                                                   <a href="这里加个人主页链接" class="pull-left info-img">
		                                                   	<img src="${APP_PATH}/static/em.jpg" alt="" />
		                                                   </a>
		                                                   <a href="这里加知识链接" class="pull-left info-user">
		                                                   	<strong>李白</strong>
		                                                   	<span>　赞了知识　服务器</span>
		                                                   </a>
		                                                   <a href="" class="pull-right text-muted info-time">
		                                                   	<small>2017-01-01 12:00</small>
		                                                   </a>
	                                                   </div>
	                                                </td>
	                                                   
	                                                </tr>
	                                                
	                                                <tr>
	                                                <td colspan="1">
	                                                   <input type="checkbox" name="selectItem" class="selectItem pull-left">
	                                                   <div class="info-desc" style="margin-left: 20px;">
		                                                   <a href=""这里加个人主页链接 class="pull-left info-img">
		                                                   	<img src="${APP_PATH}/static/em.jpg" alt="" />
		                                                   </a>
		                                                   <a href="这里加知识链接" class="pull-left info-user">
		                                                   	<strong>李白</strong>
		                                                   	<span>　赞了知识　服务器</span>
		                                                   </a>
		                                                   <a href="" class="pull-right text-muted info-time">
		                                                   	<small>2017-01-01 12:00</small>
		                                                   </a>
	                                                   </div>
	                                                </td>
	                                                   
	                                                </tr>
													
                                            </tbody>

                                        </table>
                                    </form>
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
        
        <!-- 用于页面跳转的按钮 -->
        <form action="${APP_PATH}/admin/deploy/list">
        	<input type="hidden" value="${pageInfo.pageNum}" name="pn">
        	<button type="submit" class="btn btn-danger down">关闭</button>
        </form>
        
      </div>
    </div>
  </div>
</div>

    </body>

</html>
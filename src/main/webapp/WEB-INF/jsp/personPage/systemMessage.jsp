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

                        

                       <select class="form-control" name="type" value="类型">
                            <option>状态</option>
                        </select>
                        <select class="form-control" name="type" value="类型">
                            <option>类型</option>
                        </select>

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

                                <header class="om-wrapper-header">消息管理 / 总数：${pageInfo.total}</header>

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
												<c:forEach items="${pageInfo.list}" var="systemMessage">
	                                                <tr>
	                                                <td colspan="1">
	                                                   <input type="checkbox" name="selectItem" class="selectItem pull-left">
	                                                   <div class="info-desc" style="margin-left: 20px;">
		                                                   <a href="这里加个人主页链接" class="pull-left info-img">
		                                                   	<img src="${APP_PATH}/personHeadFile/${systemMessage.headFile}" alt="" />
		                                                   </a>
		                                                   <a href="${APP_PATH}/admin/KnowledgeSharing/detailedTopic?topicId=${systemMessage.topicId}" class="pull-left info-user">
		                                                   	<strong>${systemMessage.userName}</strong>
		                                                   	<span>${systemMessage.action}  ${systemMessage.text}  ${systemMessage.title}</span>
		                                                   </a>
		                                                   <a href="" class="pull-right text-muted info-time">
		                                                   	<small>${systemMessage.date}</small>
		                                                   </a>
	                                                   </div>
	                                                </td>
	                                                   
	                                                </tr>
												</c:forEach>
	                                                
													
                                            </tbody>

                                        </table>
                                    </form>
                                </div>
                                
                                <nav aria-label="Page navigation" class="pull-right">
									  <ul class="pagination pagination-sm">
									    <li>
									      <a href="#" aria-label="Previous">
									        <span aria-hidden="true">&laquo;</span>
									      </a>
									    </li>
									    <li class="active"><a href="#">1</a></li>
									    <li><a href="#">2</a></li>
									    <li><a href="#">3</a></li>
									    <li><a href="#">4</a></li>
									    <li><a href="#">5</a></li>
									    <li>
									      <a href="#" aria-label="Next">
									        <span aria-hidden="true">&raquo;</span>
									      </a>
									    </li>
									  </ul>
								</nav>

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
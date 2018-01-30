<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>公告</title>
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

                    <div class="om-header">

                        <jsp:include page="iniOrganizationManagementHref.jsp"></jsp:include>

                        <div class="om-header-right">
                            <button id="addButton" type="button" class="btn btn-success" onclick="window.location.href='${APP_PATH}/admin/department/add'">
                                <i>+</i>发布新公告</button>
                        </div>


                        <div class="clearfix"></div>
                    </div>

                    <div class="om-wrapper">
                        <div class="row">
                            <div class="col-sm-12">

                                <header class="om-wrapper-header">公告管理 / 总数：</header>

                                <div class="om-wrpper-body">
                                    <form action="" id="user-list" class="user-list">
                                        <table class="table table-bordered table-striped">

                                            <thead>
                                                <tr>
                                                    <th>公告标题</th>
                                                    <th>公告内容</th>
                                                    <th>发布时间</th>
                                                    <th>操作</th>
                                                </tr>
                                            </thead>

                                            <tbody>
												<c:forEach items="${Notices}" var="Notice">
	                                                <tr>
	                                                    <td>${Notice.title}</td>
	                                                    <td>${Notice.text}</td>
	                                                    <td>${Notice.date}</td>
	                                                    <td>
	                                                        <div class="btn-group">
	                                                            <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                                                                	操作
	                                                                <span class="caret"></span>
	                                                            </button>
	                                                            <ul class="dropdown-menu">
	                                                             <li>
	                                                                    <a href="">查看</a>
	                                                                </li>
	                                                                <li role="separator" class="divider"></li>
	                                                                <li>
	                                                                    <a href="">编辑</a>
	                                                                </li>
	                                                                <li role="separator" class="divider"></li>
	                                                                 <li>
	                                                                    <a href="">删除</a>
	                                                                </li>
	                                                               
	                                                            </ul>
	                                                        </div>
	                                                    </td>
	                                                </tr>
												</c:forEach>
												
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
     </div>
   </div>
 </div>
</div>

 </body>

</html>
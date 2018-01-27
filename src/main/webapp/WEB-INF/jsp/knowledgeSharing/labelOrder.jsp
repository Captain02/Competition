<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sh" uri="http://shiro.apache.org/tags" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>

    <%
	      pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <meta http-equiv="X-UA-Compatible" content="ie=edge">
                <title>标签管理</title>

                <jsp:include page="iniCssHref.jsp"></jsp:include>
                <!-- 控制按钮的状态以及模态框展示的信息 -->
                <script src="${APP_PATH}/static/js/ctrolButton.js"></script>
              
        </head>

        <body class="bg-common">

            <section>

                <!-- 页面模版，每页左侧区域固定不变 -->
                <jsp:include page="iniLeftMenu.jsp"></jsp:include>
                <!-- 页面模版，每页主体部分头部按需更改 -->
                <div class="content-head content-head-section">

                    <a href="" class="toggle-btn">
                        <span class="glyphicon glyphicon-th-list"></span>
                    </a>

                   

                    <jsp:include page="iniUserInfo.jsp"></jsp:include>

                    <div class="clearfix"></div>

                </div>
                <div class="main-content">

                    <!-- 页面模版，按需更改 -->
                    <div class="wrapper">

                        <div class="om-header">
                            <div class="clearfix"></div>
                        </div>

                        <div class="om-wrapper">
                            <div class="row">
                                <div class="col-sm-12">

                                    <header class="om-wrapper-header">标签管理 / 总数：</header>

                                    <div class="om-wrpper-body">
                                        <form action="" id="user-list" class="user-list">
                                            <table class="table table-bordered table-striped">

                                                <thead>
                                                    <tr>
                                                        <th>标签名</th>
                                                        <th>操作</th>
                                                    </tr>
                                                </thead>

                                                <tbody>
                                                   
                                                        <tr>
                                                            <td>服务器</td>
                                                           
                                                            <td>
                                                                <div class="btn-group">
                                                                    <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                       	 操作
                                                                        <span class="caret"></span>
                                                                    </button>
                                                                    <ul class="dropdown-menu">
                                                                        <li>
                                                                            <a class="dele" value="${user.id }" data-toggle="modal" data-target="#myModal">删除</a>
                                                                        </li>

                                                                    </ul>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                 

                                                </tbody>

                                            </table>
                                        </form>
                                    </div>

                                </div>

                            </div>

                            <!-- 分页 -->
                            

                        </div>



                    </div>
                </div>

            </section>
            <!-- 模态框 -->
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title" id="myModalLabel"></h4>
                        </div>
                        <div class="modal-body">

                        </div>
                        <div class="modal-footer">

                            <button type="button" class="btn btn-warning yes">确认</button>
                            <button type="button" class="btn btn-success no">取消</button>

                            <!-- 用于页面跳转的按钮 -->
                            <form action="${APP_PATH}/admin/user/list">
                                <input type="hidden" name="pn" value="${pageInfo.pageNum}">
                                <button type="submit" class="btn btn-danger down">关闭</button>
                            </form>


                        </div>
                    </div>
                </div>
            </div>


        </body>

        </html>
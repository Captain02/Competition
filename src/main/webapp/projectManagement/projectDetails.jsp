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
    <title>项目介绍</title>

<%
   pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<link rel="stylesheet" href="${APP_PATH}/static/css/font-awesome.css">
<!-- 控制按钮的状态以及模态框展示的信息 -->
<script src="${APP_PATH}/static/js/selectAll.js"></script>
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

                        <div class="om-header-left">
                            <h3>
                                <span class="om-title">项目管理</span>
                                <span class="om-list pro-href"> 
									<a class="btn btn-info btn-sm">团队</a> 
									<a class="btn btn-danger btn-sm">需求</a>
									<a class="btn btn-primary btn-sm">任务</a> 
									<a class="btn btn-warning btn-sm">Bug</a> 
									<a class="btn btn-success btn-sm">文档</a>
									<a class="btn btn-danger btn-sm">版本</a>
									<a class="btn btn-warning btn-sm">报表</a>
								</span>
                            </h3>
                        </div>

                        <div class="om-header-right">
                           <span>
	                           <a href="" class="btn btn-info btn-sm">团队</a> 
	                           <a href="" class="btn btn-danger btn-sm">需求</a> 
	                           <a href="" class="btn btn-primary btn-sm">任务</a> 
	                           <a href="" class="btn btn-warning btn-sm">Bug</a> 
	                           <a href="" class="btn btn-success btn-sm">文档</a> 
	                           <a href="" class="btn btn-danger btn-sm">版本</a> 
	                           <a href="" class="btn btn-warning btn-sm">报表</a>
                           </span>
                        </div>


                        <div class="clearfix"></div>
                    </div>
					
					
	      <div class="row">
	        <div class="col-md-8">
	          <div class="row">
	            <div class="col-md-12">
	              <div class="panel">
	                <div class="panel-body">
	                  <div class="profile-desk">
	                    <h1>项目介绍</h1>
	                    <span class="designation">00</span>
	                    <div class="content"> 0000 </div>
						
	                    <a class="btn btn-danger" href=""> <i class="fa fa-check"></i> 编辑</a>&nbsp; 
	                    <a href="" class="btn p-follow-btn" data-status="1">挂起</a> 
	                    <a href="" class="btn p-follow-btn" data-status="2">延期</a> 
	                    <a href="" class="btn p-follow-btn" data-status="3">进行</a> 
	                    <a href="" class="btn p-follow-btn" data-status="4">结束</a> 
	                	
						</div>
					</div>
	              </div>
	            </div>
	          </div>
	        </div>
	        <div class="col-md-4">
	          <div class="panel">
	            <div class="panel-body">
	              <ul class="p-info">
	                <li>
	                  <div class="title">项目名称</div>
	                  <div class="desk">dgf </div>
	                </li>
	                <li>
	                  <div class="title">代号</div>
	                  <div class="desk">00</div>
	                </li>
	                <li>
	                  <div class="title">起止时间</div>
	                  <div class="desk">2018-02-21至2018-02-21</div>
	                </li>
	                <li>
	                  <div class="title">可用工作日</div>
	                  <div class="desk js-workday">1天</div>
	                </li>
	                <li>
	                  <div class="title">项目负责人</div>
	                  <div class="desk"></div>
	                </li>
	                <li>
	                  <div class="title">产品负责人</div>
	                  <div class="desk">李白</div>
	                </li>
	                <li>
	                  <div class="title">测试负责人</div>
	                  <div class="desk"></div>
	                </li>
	                <li>
	                  <div class="title">发布负责人</div>
	                  <div class="desk"></div>
	                </li>
	                <li>
	                  <div class="title">项目状态</div>
	                  <div class="desk">延期</div>
	                </li>
	              </ul>
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
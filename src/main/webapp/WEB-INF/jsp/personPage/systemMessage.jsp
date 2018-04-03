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
<script type="text/javascript">
	function dele(ele){
		//执行此方法，得到所选择的id
		selectAllTips();
	}
	
	$(function(){
		var ids = $('.ids').val();
		$('.yes').click(function(){
			alert(ids);
		})
	})
</script>
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

                    <form action="${APP_PATH}/admin/systemMessage/list" class="serach-form" method="get">

                        

                       <select class="form-control" name="type" data-type="${type}">
                            <option>类型</option>
                            <option>点赞</option>
                            <option>评论</option>
                            <option>收藏</option>
                        </select>
                        <select class="form-control" name="state" data-type="${state}">
                            <option>状态</option>
                            <option>已读</option>
                            <option>未读</option>
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
                                   
                                        <table class="table table-info">

                                            <thead>
                                                <tr>
                                                <th colspan="1">
                                                	<input type="checkbox" name="selectAll" class="selectAll pull-left" id="selectAll">
                                                	<button class="btn btn-danger pull-left" style="margin-left: 20px;" onclick="dele();">删除</button>
                                                	<input type="hidden" value=""  class="ids"/>
                                                </th>
                                                  
                                                </tr>
                                            </thead>

                                            <tbody>
												<c:forEach items="${pageInfo.list}" var="systemMessage">
	                                                <tr>
	                                                <td colspan="1">
	                                                   <input type="checkbox" name="selectItem" class="selectItem pull-left">
	                                                   <input type="hidden" value="${systemMessage.id}">
	                                                   <div class="info-desc" style="margin-left: 20px;">
		                                                   <a href="这里加个人主页链接" class="pull-left info-img">
		                                                   	<img src="${APP_PATH}/personHeadFile/${systemMessage.headFile}" alt="" />
		                                                   </a>
		                                                   <a href="${APP_PATH}/admin/KnowledgeSharing/detailedTopic?topicId=${systemMessage.topicId}&isCancel=${systemMessage.id}" class="pull-left info-user">
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
                                    
                                </div>
                                
                                <nav aria-label="Page navigation" class="pull-right">
									  <ul class="pagination pagination-sm">
									    <li>
                                                <a href="${APP_PATH}/admin/systemMessage/list?pn=1&type=${type}&state=${state}">首页</a>
                                            </li>
                                            <c:if test="${pageInfo.hasPreviousPage}">
                                                <li>
                                                    <a href="${APP_PATH}/admin/systemMessage/list?pn=${pageInfo.pageNum-1}&type=${type}&state=${state}" aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                    </a>
                                                </li>
                                            </c:if>
                                            <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                                                <c:if test="${pageNum==pageInfo.pageNum}">
                                                    <li class="active">
                                                        <a href="#">${pageNum}</a>
                                                    </li>
                                                </c:if>
                                                <c:if test="${pageNum!=pageInfo.pageNum}">
                                                    <li>
                                                        <a href="${APP_PATH}/admin/systemMessage/list?pn=${pageNum}&type=${type}&state=${state}">${pageNum}</a>
                                                    </li>
                                                </c:if>
                                            </c:forEach>

                                            <c:if test="${pageInfo.hasNextPage }">
                                                <li>
                                                    <a href="${APP_PATH}/admin/systemMessage/list?pn=${pageInfo.pageNum+1}&type=${type}&state=${state}" aria-label="Next">
                                                        <span aria-hidden="true">&raquo;</span>
                                                    </a>
                                                </li>
                                            </c:if>

                                            <li>
                                                <a href="${APP_PATH}/admin/systemMessage/list?pn=${pageInfo.pages}&type=${type}&state=${state}" aria-label="Next">
                                                    <span aria-hidden="true">末页</span>
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
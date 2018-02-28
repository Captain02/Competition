<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>请假管理</title>

    <%
	      pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    
	<jsp:include page="iniCssHref.jsp"></jsp:include>
	<script src="${APP_PATH}/static/js/selectAll.js"></script>
	
	<script type="text/javascript">
		//单个删除
		
		//批量删除
		function deleAll() {
			//执行此方法，得到所选择的id
			selectAllTips();
			var ids = $('.ids').val();
			
			$('.yes').click(function(){
				$.ajax({
					url:"${APP_PATH}/admin/holiday/dele/"+ids,
					type:"GET",
					success:function(result) {
					}
				})
			})
		}
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

                    <form action="${APP_PATH}/admin/holiday/list" class="serach-form" method="get">
						<input type="hidden" name="approved" value="${approved}">

                        <select class="form-control" name="type" value="${type}">
                            <option>类型</option>
                            <option>事假</option>
                            <option>病假</option>
                            <option>年假</option>
                            <option>调休</option>
                            <option>婚假</option>
                            <option>产假</option>
                            <option>陪产假</option>
                            <option>路途假</option>
                            <option>其它</option>
                        </select>

                         <select class="form-control" name="state">
                            <option>状态</option>
                            <option>已通过</option>
							<option>未通过</option>
							<option>审核中</option>
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

                        <jsp:include page="iniHolidayManagementHref.jsp"></jsp:include>
                        
                        <div class="om-header-right ">
                        
                            <button id="addButton" onclick="window.location.href='${APP_PATH}/admin/holiday/add'" type="button" class="btn btn-success btn-sm">
                                <i>+</i>我要请假
                            </button>
                            
                            <c:if test="${approved == '全部'}">
	                            <button id="delButton" type="button" class="btn btn-success fnish-process" onclick="window.location.href='${APP_PATH}/admin/holiday/list?approved=已审批'">
	                                <i class="glyphicon glyphicon-check"></i>已审批
	                            </button>
                            </c:if>
                            
                            <c:if test="${approved != '全部'}">
                            <button id="delButton" type="button" class="btn btn-warning do-process" onclick="window.location.href='${APP_PATH}/admin/holiday/list?approved=全部'">
                                <i class="glyphicon glyphicon-time"></i>全部
                            </button>
                            </c:if>
                            
                            <c:if test="${approved != '全部'}">
	                            <button id="delButton" type="button" class="btn btn-danger " onclick="deleAll()">
	                                <i>-</i>批量删除
	                            </button>
                            </c:if>
                            
                          	   
                           
                            
                            <input type="hidden" value=""  class="ids"/>
                        </div>


                        <div class="clearfix "></div>
                    </div>

                    <div class="om-wrapper ">
                        <div class="row ">
                            <div class="col-sm-12 ">

                                <header class="om-wrapper-header ">请假 / 总数：${pageInfo.total}</header>

                                <div class="om-wrpper-body ">
                                    <table class="table table-hover holiday-table">
                                        <thead>
                                            <tr>
                                            	<c:if test="${approved != '全部'}">
	                                            	<th><input type="checkbox" name="selectAll" class="selectAll" id="selectAll"></th>
                                            	</c:if>
                                                <th>类型</th>
                                                <th class="hidden-phone hidden-xs">请假日期</th>
                                                <th>天数</th>
                                                <th>原因</th>
                                                <th>状态</th>
                                                <th>操作</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${pageInfo.list }" var="holiday">
	                                            <tr>
	                                            	<c:if test="${approved != '全部'}">
		                                            	<td>
		                                                   <input type="checkbox" name="selectItem" class="selectItem">
		                                                </td>
	                                            	</c:if>
	                                                <td>${holiday.type} <input type="hidden" value="${holiday.processinstanceid}" /></td>
	                                                <td>${holiday.date}</td>
	                                                <td>${holiday.holidaydays}</td>
	                                                <td>${holiday.reason}</td>
	                                                <td><span class="label label-success">${holiday.test}</span></td>
	                                                <td>
		                                                <div class="btn-group">
	                                                       <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
	                                                                                                                                                                                                                                         操作
	                                                            <span class="caret"></span>
	                                                        </button>
	                                                        <ul class="dropdown-menu">
	                                                            <li>
	                                                                <a href="${APP_PATH}/admin/holiday/holidayNote/${holiday.id}">查看假条</a>
	                                                            </li>
	                                                            <li role="separator" class="divider"></li>
	                                                            <li>
	                                                                <a href="${APP_PATH}/admin/holiday/showCurrentView/${holiday.processinstanceid}">查看进度</a>
	                                                            </li>
	                                                              <c:if test="${approved != '全部'}">
			                                                        <li role="separator" class="divider"></li>
			                                                        <li>
			                                                            <a href="${APP_PATH}/admin/holiday/dele/${holiday.processinstanceid}">删除</a>
			                                                        </li>
	                                                              </c:if>
	                                                        </ul>
	                                                    </div>
	                                                </td>
	                                            </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                            </div>

                        </div>
                        <!-- 分页 -->
                        <div class="page-area ">
                            <div class="container page-possiton ">
                            
                                <nav aria-label="Page navigation">
                                    <ul class="pagination pagination-control">
                                        <li>
                                            <a href="${APP_PATH}/admin/holiday/list?pn=1&type=${type}&state=${state}&approved=${approved}">首页</a>
                                        </li>
                                        <c:if test="${pageInfo.hasPreviousPage}">
                                            <li>
                                                <a href="${APP_PATH}/admin/holiday/list?pn=${pageInfo.pageNum-1}&type=${type}&state=${state}&approved=${approved}" aria-label="Previous">
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
                                                    <a href="${APP_PATH}/admin/holiday/list?pn=${pageNum}&type=${type}&state=${state}&approved=${approved}">${pageNum}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>

                                        <c:if test="${pageInfo.hasNextPage }">
                                            <li>
                                                <a href="${APP_PATH}/admin/holiday/list?pn=${pageInfo.pageNum+1}&type=${type}&state=${state}&approved=${approved}" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li
                                            >
                                        </c:if>

                                        <li>
                                            <a href="${APP_PATH}/admin/holiday/list?pn=${pageInfo.pages}&type=${type}&state=${state}&approved=${approved}" aria-label="Next">
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
        	<input type="hidden" value="${approved}" name="approved">
        	<input type="hidden" value="${pageInfo.pageNum}" name="pn">
        	<button type="submit" class="btn btn-danger down">关闭</button>
        </form>
        
      </div>
    </div>
  </div>
</div>
        
    </body>

</html>
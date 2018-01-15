<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>请假审批</title>

<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<script src="${APP_PATH}/static/js/ctrolButton.js"></script>
<script type="text/javascript">
$(function(){
	$('.not-change').attr('disabled','diasbled');
})
function examination(state) {
	$.ajax({
		url:"${APP_PATH}/admin/myTask/agreeExamination",
		data:"state="+state+"&"+$("#examinationFrom").serialize(),
		type:"POST",
		success:function(result){
			if (result.code==100) {
				$('#myModal').modal('show');
				ShowTips('.modal-title','执行结果','.modal-body','<b style = "color:#5cb85c;">成功批准该申请人的申请</b>');
			}
		}
	})
}

</script>
</head>

<body class="bg-common approve">
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
                    <div class="om-header">
                        <div class="clearfix"></div>
                    </div>

                    <div class="om-wrapper">
                        <div class="row">
                            <div class="col-sm-12">
                                <header class="om-wrapper-header">审批</header>

                                <div class="om-wrpper-body">
                                    <sf:form id="examinationFrom" modelAttribute="userReimbursementByReimbursementId">
                                        <sf:hidden path="processinstanceid" />
                                        <sf:hidden path="id" />
                                        <!-- 报销申请人填写区域 -->
                                        <div class="form-group">
                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    报销申请人：
                                                </label>
                                            </div>

                                            <div class="col-sm-4">
                                                <sf:input path="name" type="text" class="form-control not-change" />
                                            </div>

                                            <div class="col-sm-2">
                                                <label for="" class="control-label right">
                                                    报销日期：
                                                </label>
                                            </div>

                                            <div class="col-sm-4">
                                                <sf:input path="date" type="text" class="form-control not-change" />
                                            </div>
                                        </div>

                                        <!-- 报销金额填写区域 -->
                                        <div class="form-group">
                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                  报销金额：
                                                </label>
                                            </div>
                                            <div class="col-sm-10">
                                                <sf:textarea path="money" style="height:90px;" class="form-control not-change"></sf:textarea>
                                            </div>

                                        </div>

                                        <!-- 批注填写区域 -->
                                        <div class="form-group">
                                            <div class="col-sm-2">
                                                <label for="" class="control-label">
                                                    批注：
                                                </label>
                                            </div>
                                            <div class="col-sm-10">
                                                <textarea name="nowComment" style="height:90px;" class="form-control"></textarea>
                                            </div>
                                        </div>
									 </sf:form>
                                        <!--结果选择 -->
                                        <div class="form-group">
                                            <div class="col-sm-2">
                                                <label for="" class="control-label"> </label>
                                                 </div>
                                                 <div class="col-sm-10 approve-result">
                                                     <button type="button" onclick="examination(0)" class="btn btn-default btn-success" id="0">
                                                         <span class="glyphicon glyphicon-ok"></span>批准</button>
                                                     <button type="button" onclick="examination(1)" class="btn btn-default btn-danger" id="1">
                                                         <span class="glyphicon glyphicon-remove"></span>驳回</button>
                                                     <button type="button" onclick="examination(2)" class="btn btn-default btn-warning" id="2">
                                                         <span class="glyphicon glyphicon-arrow-up"></span>提交给上一级</button>
                                                 </div>
                                             </div>
                                             <!--查看附件 -->
                                             <div class="form-group">
                                                 <div class="col-sm-2">
                                                     <label for="" class="control-label">
                                                         附件:
                                                     </label>
                                                 </div>
                                                 <div class="col-sm-10 approve-result">
                                                 <span class="enclosureName">${enclosureName}</span>
                                                     <button type="button" class="btn btn-default">
                                                         <span class="glyphicon glyphicon-arrow-down"></span>下载附件</button>
                                                 </div>
                                             </div>

                                <header class="om-wrapper-header">批注列表</header>

                                <div class="om-wrpper-body">
                                    <form action="">
                                        <table class="table table-striped table-hover text-center">
                                            <thead>
                                                <tr>
                                                    <th>批注时间</th>
                                                    <th>批注人</th>
                                                    <th>批注信息</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            	<c:forEach items="${comment}" var="comment">
	                                                <tr>
	                                                    <td><fmt:formatDate value="${comment.time }" pattern="yyyy-mm-dd hh:dd:ss"/></td>
	                                                    <td>${comment.userId }</td>
	                                                    <td>${comment.fullMessage }</td>
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
        </div>
        </div>
    </section>
   <!-- 确认审批的模态框 --> 
   <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel"></h4>
      </div>
      <form action="${APP_PATH}/admin/myTask/myHolidayTask" method="get">
      <div class="modal-body">
      </div>
	      <div class="modal-footer">
	      	<input name="pn" type="hidden" value="${pn==null?100000:pn}">
	        <button type="submit" class="btn btn-default btn-success">确认</button>
	      </div>
      </form>
    </div>
  </div>
</div>
</body>

</html>
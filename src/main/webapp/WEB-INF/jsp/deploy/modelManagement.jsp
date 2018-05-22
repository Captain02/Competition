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
    <title>模块管理</title>

<%
   pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<script src="${APP_PATH}/static/js/selectAll.js"></script>
<script type="text/javascript">
	function deployModel(ele){
// 		var modelId = $(ele).attr('data-modelId');
// 		$.ajax({
// 			url:'${APP_PATH}/admin/model/deployModel',
// 			data:{
// 				'modelId':modelId
// 			},
// 			type:'POST',
// 			success:function(result){
// 				if (result.code==100) {
// 					$('#DeployModal').modal('show');
// 				}
// 			}
// 		})
		$('#DeployModal').modal('show');
		$('#DeployModal').find('input[name="modelId"]').val($(ele).attr('data-modelId'));
		
	}
	function deleModel(ele){
		var modelId = $(ele).attr('data-modelId');
		$.ajax({
			url:'${APP_PATH}/admin/model/deleModel',
			data:{
				'modelId':modelId
			},
			type:'POST',
			success:function(result){
				console.log(result);
				if (result.code==100) {
					console.log(result);
					$('#DelModal').modal('show');
					ShowTips('.modal-title','执行结果','.modal-body','删除成功!');
					setTimeout(function(){
						$('#DelModal').modal('hide');
						window.location.reload();
					},2000)
				}
			}
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
									 <a href="${APP_PATH}/admin/model/list">模块管理</a>
                                </span>
                            </h3>
                        </div>

                        <div class="om-header-right">
                            <button id="addButton" type="button" class="btn btn-success btn-sm" onclick="window.location.href='${APP_PATH}/admin/model/createPage'">
                                <i>+</i>添加
                            </button>
                        </div>


                        <div class="clearfix"></div>
                    </div>

                    <div class="om-wrapper">
                        <div class="row">
                            <div class="col-sm-12">

                                <div class="om-wrpper-body">
                                   
                                        <table class="table table-bordered table-striped">

                                            <thead>
                                                <tr>
                                                    <th>Key</th>
                                                    <th>名称</th>
                                                    <th>描述</th>
                                                    <th>操作</th>
                                                </tr>
                                            </thead>

                                            <tbody>
												<c:forEach items="${pageInfo}" var="model">
	                                                <tr>
	                                                <td>${model.key} <input type="hidden" value="${model.key}" /></td>
                                                    <td>${model.name}</td>
                                                    <td>${model.version}</td>
                                                    <td>
                                                    	<a href="${APP_PATH}/static/process-editor/modeler.html?modelId=${model.id}" class="btn btn-success btn-sm btn-edit">
                                                    		<i class="glyphicon glyphicon-edit"></i>
                                                    		编辑
                                                    	</a>
                                                    	<button onclick="deployModel(this);" data-modelId="${model.id}" class="btn btn-info btn-sm btn-deploy">
	                                                    	<i class="glyphicon glyphicon-briefcase"></i>
	                                                    	部署
                                                    	</button>
                                                    	<button onclick="deleModel(this);" data-modelId="${model.id}" class="btn btn-warning btn-sm btn-upload">
	                                                    	<i class="glyphicon glyphicon-minus"></i>
	                                                    	删除
                                                    	</button>
                                                    </td>
													</c:forEach>
                                            </tbody>

                                        </table>
                                </div>

                            </div>

                        </div>

                    </div>
                </div>
            </div>

        </section>
        
         <!-- 删除模态框 -->
		 <div class="modal fade" id="DelModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel"></h4>
		      </div>
		      <div class="modal-body">
		        
		      </div>
		    </div>
		  </div>
		</div>

		<!-- 部署模态框 -->
		 <div class="modal fade" id="DeployModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel"></h4>
		      </div>
		      
		      <form action="${APP_PATH}/admin/model/deployModel" method="post">
			      <div class="modal-body">
			      	<div class="form-group" style="border-bottom: 0 none;">
			      		<label for="" class="col-md-2" style="padding-top:7px;">流程人数</label>
			      		<div class="col-md-10">
			      			<input class="form-control" type="number" id="People" name="people" placeholder="输入人数" />
			      		</div>
			      	</div>
			      </div>
		      
			       <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			        <button type="submit" class="btn btn-primary btn-deploy">确认</button>
			        <input type="hidden"  name="modelId" />
			      </div>
		      </form>
		      
		    </div>
		  </div>
		</div>
		
		
		
		
    </body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工相册</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<link href="${APP_PATH}/static/lightbox/css/lightbox.min.css" rel="stylesheet">
</head>
<script type="text/javascript">
function dele(ele) {
	var topicId = $(ele).attr('data-topicId');
	$.ajax({
		url:"${APP_PATH}/admin/image/dele",
		data:{
			'topicId':topicId
		},
		type:"POST",
		success:function(result){
			setTimeout(function(){
				$('.modal-footer').remove();
				$('#myModal').modal('show');
				ShowTips('.modal-title','操作结果','.modal-body','删除成功');
				setTimeout(function(){
					$('#myModal').modal('hide');
					window.location.reload();
				},1000)
			})
		}
	})
	
}
function editor(ele){
	$('#myModal').modal('show');

	var title = $(ele).attr('data-imgtitle');
	var sumary = $(ele).attr('data-img-sumary');
	
	var iputTitle = $('.modal-body').find('input[name="title"]');
	var inputSumary = $('.modal-body').find('textarea[name="summary"]');
	
	var btnImgInfo = $('.modal-footer').find('button.inputto');
	
	ShowTips('.modal-title','编辑相册：'+title,null);
	
	iputTitle.val(title);
	inputSumary.val(sumary);
	
	btnImgInfo.attr({
		'data-topicId':$(ele).attr('data-topicId'),
		'data-editor-title':title,
		'data-editor-summary':sumary
	})
	
	
}

$(function(){
	var btnInput = $('.modal-footer').find('button.inputto');
	
	$('.modal-body').find('input[name="title"]').blur(function(){
		btnInput.attr('data-editor-title',$(this).val());
	})
	$('.modal-body').find('textarea[name="summary"]').blur(function(){
		btnInput.attr('data-editor-summary',$(this).val());
	})
	
	$('.inputto').click(function(){
   		var topicId = $(this).attr('data-topicId');
   		var title = $(this).attr('data-editor-title');
   		var summary = $(this).attr('data-editor-summary')
   		
   		$.ajax({
   			url:"${APP_PATH}/admin/image/update",
   			data:{
   				'topicId':topicId,
   				'title':title,
   				'summary':summary
   			},
   			type:"POST",	
   			success:function(result){
   				window.location.reload();
   			}
   		});
   	})

})

</script>
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

				<jsp:include page="iniUserInfo.jsp"></jsp:include>

				<div class="clearfix"></div>

			</div>

			<!-- 页面模版，按需更改 -->
			<div class="wrapper">
				
					<div class="row">
						<div class="col-lg-12">

							<section class="panel">
								<header class="om-wrapper-header" style="padding-left:15px;">
								精彩相片
								<div class="pull-right">
								<c:if test="${isByMy==0}">
									<a href="${APP_PATH}/admin/image/list?isByMy=1" class="btn btn-warning btn-sm">我的相片</a>
								</c:if>
								<c:if test="${isByMy!=0}">
									<a href="${APP_PATH}/admin/image/list" class="btn btn-success btn-sm">全部相片</a>
								</c:if>
									<a href="${APP_PATH}/admin/image/add" class="btn btn-success btn-sm">+上传相片</a>
								</div>
							</header>
								<div class="panel-body">
									<div id="gallery" class="media-gal">
									<c:forEach items="${MyImageDispaly}" var="MyImageDispaly">
										<div class="images item ">
											<a href="${APP_PATH}/myImage/${MyImageDispaly.imageName}" data-lightbox="example-set">
												<img src="${APP_PATH}/myImage/${MyImageDispaly.imageName}" alt="" />
											</a>
											<p class="img-title"><a href="${APP_PATH}/admin/KnowledgeSharing/detailedTopic?topicId=${MyImageDispaly.topicId}">${fn:substring(MyImageDispaly.title,0, 10)}</a> </p>
											<p class="img-desc">${MyImageDispaly.sketch}</p>
											<p>${MyImageDispaly.userName}${fn:substring(MyImageDispaly.date, 0, 10)}上传</p>
											<p>
												<c:if test="${isByMy!=0}">
												<a data-topicId="${MyImageDispaly.topicId}" data-imgtitle="${fn:substring(MyImageDispaly.title,0, 10)}" data-img-sumary="${MyImageDispaly.sketch}" onclick="editor(this)"><i class="glyphicon glyphicon-edit"></i></a>
												<a data-topicId="${MyImageDispaly.topicId}" onclick="dele(this)"><i class="glyphicon glyphicon-trash"></i></a>
												</c:if>
											</p>
										</div>
									</c:forEach>
									</div>
								</div>
							</section>
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
    <div class="modal-body editor-imgdesc">
      <div class="form-group"><label for="recipient-name" class="control-label">标题:</label><input class="form-control" name="title" type="text"></div>
      <div class="form-group"><label for="message-text" class="control-label">说明:</label><textarea class="form-control" name="summary">我想知道相片背后的故事</textarea></div>
    </div>
    <div class="modal-footer">
     	<button type="button" class="btn btn-success inputto">提交</button>
     	<script type="text/javascript">
     	
     	</script>
        <button type="button" class="btn btn-default no" data-dismiss="modal">取消</button>
     </div>
   </div>
 </div>
</div>
	<script src="${APP_PATH}/static/lightbox/js/lightbox.min.js"></script>
</body>
</html>
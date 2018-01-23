<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sh" uri="http://shiro.apache.org/tags" %>
	<!DOCTYPE html>
	<html lang="en">

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="ie=edge">
		<title>更换我的头像</title>

		<%
			pageContext.setAttribute("APP_PATH", request.getContextPath());
		%>
			<jsp:include page="iniCssHref.jsp"></jsp:include>
			<link rel="stylesheet" href="${APP_PATH}/static/css/cropper.css">
			<link rel="stylesheet" href="${APP_PATH}/static/css/font-awesome.css">
			<script src="${APP_PATH}/static/js/cropper.min.js"></script>
			<script src="${APP_PATH}/static/js/cropper-option.js"></script>
			
			<script type="text/javascript">
			$(function(){
				$('.upLoad').click(function(){
					var imgBase64 = $('#download').html();
					var imgUploaded = $('#uploadedImg').html();
					console.log(imgUploaded);
					//发送ajax链接,上传裁剪过后的图片
					$.ajax({
				        url: '${APP_PATH}/admin/personPage/upPersonHeadFile', // 要上传的地址
				        type: 'POST',
				        data: 'imgData='+imgBase64,
				        success: function (result) {
				            if (result.code==100) {
								alert("上传成功");
							}
				        }
				    });
					//发送ajax链接，上传原图
					if(imgUploaded != ''){
						
					}
					
				})
			})
			</script>
	</head>

	<body class="bg-common">
		<jsp:include page="iniLeftMenu.jsp"></jsp:include>
		<div class="main-content">
			<div class="content-head content-head-section">

				<a href="" class="toggle-btn">
					<span class="glyphicon glyphicon-th-list"></span>
				</a>

				<jsp:include page="iniUserInfo.jsp"></jsp:include>

				<div class="clearfix"></div>
			</div>
			<div class="wrapper">
				<div class="om-wrapper">
					<div class="row">
						<div class="col-sm-12">
							<header class="om-wrapper-header">设置头像</header>
							<div class="container">
							<div class="panel-body">

								<!-- 预览区域 -->
								<div class="col-md-9">

									<!--用户上传的图片-->
									<div style="height: 500px;" class="img-container">
										<img src="${APP_PATH}/static/em.jpg" alt="picture" id="image" class="img-responsive">
									</div>

									<!--工具栏 -->
									<div class="row text-center" id="actions" style="margin-top: 15px;">
								
									
								
									
								<div class="docs-buttons">
										<!--上传按钮 -->
											<div class="btn-group">
											<label class="btn btn-primary btn-upload" for="inputImage" title="Upload image file">
									            <input class="sr-only" id="inputImage" name="file" accept=".jpg,.jpeg,.png,.gif,.bmp,.tiff" type="file">
									            <span class="docs-tooltip" data-toggle="tooltip" title="">
									              <span class="fa fa-upload">上传</span>
									            </span>
          									</label>
											</div>
											
											
											<!--缩放按钮 -->
											<div class="btn-group">
												<button type="button" class="btn btn-primary" data-method="zoom" data-option="0.1" title="Zoom In">
													<span class="docs-tooltip" data-toggle="tooltip" title="cropper.zoom(0.1)">
														<span class="fa fa-search-plus"></span>
													</span>
												</button>
												<button type="button" class="btn btn-primary" data-method="zoom" data-option="-0.1" title="Zoom Out">
													<span class="docs-tooltip" data-toggle="tooltip" title="cropper.zoom(-0.1)">
														<span class="fa fa-search-minus"></span>
													</span>
												</button>
											</div>

											<!--步进按钮 -->
											<div class="btn-group">
												<button type="button" class="btn btn-primary" data-method="move" data-option="-10" data-second-option="0" title="Move Left">
													<span class="docs-tooltip" data-toggle="tooltip" title="cropper.move(-10, 0)">
														<span class="fa fa-arrow-left"></span>
													</span>
												</button>
												<button type="button" class="btn btn-primary" data-method="move" data-option="10" data-second-option="0" title="Move Right">
													<span class="docs-tooltip" data-toggle="tooltip" title="cropper.move(10, 0)">
														<span class="fa fa-arrow-right"></span>
													</span>
												</button>
												<button type="button" class="btn btn-primary" data-method="move" data-option="0" data-second-option="-10" title="Move Up">
													<span class="docs-tooltip" data-toggle="tooltip" title="cropper.move(0, -10)">
														<span class="fa fa-arrow-up"></span>
													</span>
												</button>
												<button type="button" class="btn btn-primary" data-method="move" data-option="0" data-second-option="10" title="Move Down">
													<span class="docs-tooltip" data-toggle="tooltip" title="cropper.move(0, 10)">
														<span class="fa fa-arrow-down"></span>
													</span>
												</button>
											</div>

											<!--旋转按钮 -->
											<div class="btn-group">
												<button type="button" class="btn btn-primary" data-method="rotate" data-option="-45" title="Rotate Left">
													<span class="docs-tooltip" data-toggle="tooltip" title="cropper.rotate(-45)">
														<span class="fa fa-rotate-left"></span>
													</span>
												</button>
												<button type="button" class="btn btn-primary" data-method="rotate" data-option="45" title="Rotate Right">
													<span class="docs-tooltip" data-toggle="tooltip" title="cropper.rotate(45)">
														<span class="fa fa-rotate-right"></span>
													</span>
												</button>
											</div>

											<!--翻转按钮 -->
											<div class="btn-group">
												<button type="button" class="btn btn-primary" data-method="scaleX" data-option="-1" title="Flip Horizontal">
													<span class="docs-tooltip" data-toggle="tooltip" title="" data-original-title="cropper.scaleX(-1)">
														<span class="fa fa-arrows-h"></span>
													</span>
												</button>
												<button type="button" class="btn btn-primary" data-method="scaleY" data-option="1" title="Flip Vertical">
													<span class="docs-tooltip" data-toggle="tooltip" title="" data-original-title="cropper.scaleY(-1)">
														<span class="fa fa-arrows-v"></span>
													</span>
												</button>
											</div>

											<!--重置按钮 -->
											<div class="btn-group">
												<button type="button" class="btn btn-primary" data-method="reset" title="Reset">
													<span class="docs-tooltip" data-toggle="tooltip" title="" data-original-title="cropper.reset()">
														<span class="fa fa-refresh"></span>
													</span>
												</button>
											</div>
											
										<!--确定按钮 -->
										 <div class="btn-group btn-group-crop">
								          <button type="button" class="btn btn-success btn-sure" data-method="getCroppedCanvas" data-option="{ &quot;maxWidth&quot;: 4096, &quot;maxHeight&quot;: 4096 }">
								            <span class="docs-tooltip" data-toggle="tooltip">
								            	  确定
								            </span>
								          </button>
								        </div>
										
										<!--显示裁剪结果的模态框 -->
									        <div class="modal fade docs-cropped" id="getCroppedCanvasModal" role="dialog" aria-hidden="true" aria-labelledby="getCroppedCanvasTitle"
									          tabindex="-1">
									          <div class="modal-dialog">
									            <div class="modal-content">
									              <div class="modal-header">
									                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
									                  <span aria-hidden="true">&times;</span>
									                </button>
									                <h4 class="modal-title" id="myModalLabel">裁剪结果</h4>
									              </div>
									              <div class="modal-body"></div>
									              <div class="modal-footer">
									                <button type="button" class="btn btn-default" data-dismiss="modal">不满意</button>
									                <button class="btn btn-primary upLoad">上传</button>
									                <span id="download" style="display: none;"></span>
									                <span id="uploadedImg" style="display: none;"></span>
									              </div>
									            </div>
									          </div>
									        </div>




										</div>
									</div>

									


								</div>

							<img alt="" src="${APP_PATH}/personHeadFile/<sh:principal property="id" />.png">


								<!-- 操作区域 -->
								<div class="col-md-3">

									<!--额外的预览区域 -->
									<div class="preview clearfix">
										<div class="img-preview preview-lg"></div>
										<div class="img-preview preview-md"></div>
										<div class="img-preview preview-sm"></div>
										<div class="img-preview preview-xs"></div>
									</div>
									
									<!--存放裁剪数据 -->
									<div class="docs-data">
										<input type="hidden" class="form-control" id="dataX" placeholder="x">
										<input type="hidden" class="form-control" id="dataY" placeholder="y">
										<input type="hidden" class="form-control" id="dataWidth" placeholder="width">
										<input type="hidden" class="form-control" id="dataHeight" placeholder="height">
										<input type="hidden" class="form-control" id="dataRotate" placeholder="rotate">
										<input type="hidden" class="form-control" id="dataScaleX" placeholder="scaleX">
										<input type="hidden" class="form-control" id="dataScaleY" placeholder="scaleY">
									</div>



								</div>
							</div>
						
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>

	</html>
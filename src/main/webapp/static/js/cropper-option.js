/**
 * 
 */
$(function() {

	// 获取用户上传的图片
	var container = document.querySelector('.img-container');
	var image = container.getElementsByTagName('img').item(0);
	
	// 获取工具栏操作
	var actions = document.getElementById('actions');

	// 获取裁剪数据
	var dataX = document.getElementById('dataX');// 剪裁区的左偏移量
	var dataY = document.getElementById('dataY');// 剪裁区的上偏移量
	var dataHeight = document.getElementById('dataHeight');// 剪裁区高度
	var dataWidth = document.getElementById('dataWidth');// 剪裁区宽度
	var dataRotate = document.getElementById('dataRotate');// 图片的旋转角度
	var dataScaleX = document.getElementById('dataScaleX');// 图片横坐标上的缩放因子
	var dataScaleY = document.getElementById('dataScaleY');// 图片纵坐标上的缩放因子

	// 定义裁剪配置
	var options = {
		preview : '.img-preview',
		viewMode : 1,
		dragMode : 'move',
		aspectRatio : 16 / 9,
		autoCropArea : 0.6,
		restore : false,
		guides : false,
		highlight : false,

		//填充裁剪数据
		crop : function(e) {
			var data = e.detail;

			dataX.value = Math.round(data.x);
			dataY.value = Math.round(data.y);
			dataHeight.value = Math.round(data.height);
			dataWidth.value = Math.round(data.width);
			dataRotate.value = typeof data.rotate !== 'undefined' ? data.rotate: '';
			dataScaleX.value = typeof data.scaleX !== 'undefined' ? data.scaleX: '';
			dataScaleY.value = typeof data.scaleY !== 'undefined' ? data.scaleY: '';
		}
	};
	var cropper = new Cropper(image, options);
	
	var URL = window.URL || window.webkitURL;
	var originalImageURL = image.src;
	var uploadedImageType = 'image/jpeg';
	var uploadedImageURL;

	// 定义工具栏操作
	$('[data-toggle="tooltip"]').tooltip();
	
	//工具栏上的操作
	  actions.querySelector('.docs-buttons').onclick = function (event) {
		    var e = event || window.event;
		    var target = e.target || e.srcElement;
		    var cropped;
		    var result;
		    var input;
		    var data;

		    if (!cropper) {
		      return;
		    }

		    while (target !== this) {
		      if (target.getAttribute('data-method')) {
		        break;
		      }

		      target = target.parentNode;
		    }

		    if (target === this || target.disabled || target.className.indexOf('disabled') > -1) {
		      return;
		    }

		    data = {
		      method: target.getAttribute('data-method'),
		      target: target.getAttribute('data-target'),
		      option: target.getAttribute('data-option') || undefined,
		      secondOption: target.getAttribute('data-second-option') || undefined
		    };

		    cropped = cropper.cropped;

		    if (data.method) {
		      if (typeof data.target !== 'undefined') {
		        input = document.querySelector(data.target);

		        if (!target.hasAttribute('data-option') && data.target && input) {
		          try {
		            data.option = JSON.parse(input.value);
		          } catch (e) {
		            console.log(e.message);
		          }
		        }
		      }

		      switch (data.method) {
		        case 'rotate':
		          if (cropped && options.viewMode > 0) {
		            cropper.clear();
		          }

		          break;

		        case 'getCroppedCanvas':
		          try {
		            data.option = JSON.parse(data.option);
		          } catch (e) {
		            console.log(e.message);
		          }

		          if (uploadedImageType === 'image/jpeg') {
		            if (!data.option) {
		              data.option = {};
		            }

		            data.option.fillColor = '#fff';
		          }

		          break;
		      }

		      result = cropper[data.method](data.option, data.secondOption);

		      switch (data.method) {
		        case 'rotate':
		          if (cropped && options.viewMode > 0) {
		            cropper.crop();
		          }

		          break;

		        case 'scaleX':
		        case 'scaleY':
		          target.setAttribute('data-option', -data.option);
		          break;

		        case 'getCroppedCanvas':
		          if (result) {
		            // Bootstrap's Modal
		            $('#getCroppedCanvasModal').modal().find('.modal-body').html(result);

		            if (!download.disabled) {
		              $('#download').html(result.toDataURL(uploadedImageType));
		            }
		          }

		          break;

		        case 'destroy':
		          cropper = null;

		          if (uploadedImageURL) {
		            URL.revokeObjectURL(uploadedImageURL);
		            uploadedImageURL = '';
		            image.src = originalImageURL;
		          }

		          break;
		      }

		      if (typeof result === 'object' && result !== cropper && input) {
		        try {
		          input.value = JSON.stringify(result);
		        } catch (e) {
		          console.log(e.message);
		        }
		      }
		    }
		  };
		  
		  //上传图片
		  var inputImage = document.getElementById('inputImage');

		  if (URL) {
		    inputImage.onchange = function () {
		      var files = this.files;
		      var file;

		      if (cropper && files && files.length) {
		        file = files[0];

		        if (/^image\/\w+/.test(file.type)) {
		          uploadedImageType = file.type;

		          if (uploadedImageURL) {
		            URL.revokeObjectURL(uploadedImageURL);
		          }

		          image.src = uploadedImageURL = URL.createObjectURL(file);
		          cropper.destroy();
		          cropper = new Cropper(image, options);
		          inputImage.value = null;
		        } else {
		          window.alert('Please choose an image file.');
		        }
		      }
		    };
		  } else {
		    inputImage.disabled = true;
		    inputImage.parentNode.className += ' disabled';
		  }
		  
})
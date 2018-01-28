/**
 * 文件说明：执行知识分类的操作
 */
//点击新建标签弹出输入框
	$('.addLabel').click(function(){
		$('.addNewLabel').removeClass('addNewLabel');
	});
	//点击配置按钮弹出标签操作按钮
	$('.mangeLabel').click(function(){
		if($('.order-list-control').hasClass('show')){
			$('.order-list-control').removeClass('show');
		}
		else{
			$('.order-list-control').addClass('show');
		}
		
	});
	//辑按钮的操作 
	var editorBtn = $('.order-list-editor');
	for(var i = 0; i<editorBtn.length; i++){
		$(editorBtn[i]).click(function(){
			$(this).parent().parent().children().eq(0).addClass('hidden');
			$(this).parent().parent().find('div.editorArea').removeClass('hidden');
		})
	}
	//取消按钮的操作 
	var btnNo = $('.btn-no');
	for(var i = 0; i<btnNo.length; i++){
		$(btnNo[i]).click(function(){
			$(this).parent().addClass('hidden');
			$(this).parent().parent().children().eq(0).removeClass('hidden');
		});
	}
	
	//删除按钮的操作
	$('.order-list-del').click(function(){
		$('#myModal').modal('show');
		 ShowTips('.modal-title','警告！','.modal-body','<b style = "color:#c9302c;">删除分类之后，该分类下面的所有帖子都会被删除</b>' + '，确定要执行删除操作吗？');
	})
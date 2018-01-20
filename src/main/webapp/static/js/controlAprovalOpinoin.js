//<reference path="jquery.min.js" />
//<reference path="ctrolButton.js" />
/*
    文件说明：根据审批意见的不同，弹出不同的模态框
 */

function controlAprovalOpinoin(result) {
	if(result.extend.NoNextNode != null){
		$('#myModal').modal('show');
		ShowTips('.modal-title','错误的操作','.modal-body','<b style = "color:#d9534f;">您已经是最后1位审批者，无法继续提交</b>');
		 setTimeout(function(){
				$('#myModal').modal('hide');
		},2000);
	}
    switch (parseInt(result.extend.state)) {
        case 0:
            $('#myModal').modal('show');
            ShowTips('.modal-title', '执行结果', '.modal-body', '<b style = "color:#5cb85c;">成功批准该申请人的申请！</b>');
            break;
        case 1:
            $('#myModal').modal('show');
            ShowTips('.modal-title', '执行结果', '.modal-body', '<b style = "color:#d9534f;">已驳回该申请人的申请！</b>');
            break;
        case 2:
            $('#myModal').modal('show');
            ShowTips('.modal-title', '执行结果', '.modal-body', '<b style = "color:#f0ad4e;">已成功提交给上一级审核！</b>');
            break;
        default:
            break;
    }
}
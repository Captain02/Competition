/**
 * 
 */
$(function(){
	if(document.getElementById('selectAll') == null){
		return false;
	}
	var selectAll = document.getElementById('selectAll');
    var selectItems = document.getElementsByName('selectItem');

    selectAll.onclick = function () {
        for (var i = 0; i < selectItems.length; i++) {
            selectItems[i].checked = selectAll.checked;
        }
    }

    for (var i = 0; i < selectItems.length; i++) {
        selectItems[i].onclick = function () {
            selectAll.checked = true;
            for (var j = 0; j < selectItems.length; j++) {
                if (!selectItems[j].checked) {
                    selectAll.checked = false;
                }
            }
        }
    }
})

function selectAllTips(){
	var empNames = "";
	var ids = "";
	var ifHavechecked = $('tbody tr td input[type="checkbox"]:checked');
	//一旦进入判断，就说明没有复选框被选中
	if(ifHavechecked.length == 0){
		$('#myModal').modal('show');
		 ShowTips('.modal-title','错误的操作！','.modal-body','<b style = "color:#d9534f;">请至少选择一行</b>' );
		 ShowEle('.yes','hide','.no','hide','.down','hide');
		 setTimeout(function(){
			$('#myModal').modal('hide');
		 },1000);
	}
	
	else{
		for(var i = 0; i<ifHavechecked.length; i++){
			
				if(i == ifHavechecked.length-1){
					ids += $(ifHavechecked[i]).parent().parent().find('input').eq(1).val();
					empNames += $(ifHavechecked[i]).parent().parent().children('td').eq(2).html();
				}
				else{
					ids += $(ifHavechecked[i]).parent().parent().find('input').eq(1).val() + '-';
					empNames += $(ifHavechecked[i]).parent().parent().children('td').eq(2).html() + ',';
				}
		}
		
		$('.ids').val(ids);
		$('#myModal').modal('show');
		ShowTips('.modal-title','删除确认？','.modal-body','确认删除' + '<b style = "color:#c9302c;">所选内容</b>' + '吗？');
		ShowEle('.yes','show','.no','show','.down','hide');
	}
}
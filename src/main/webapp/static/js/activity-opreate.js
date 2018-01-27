/**
 * 文件说明：对于动态的点赞和收藏，动态的添加样式
 */
$(function(){
	if($("#isLike").val() == 1){
		$('.fa-thumbs-o-up').addClass('controled');
	}
	if($("#isCollection").val() == 1){
		$('.fa-heart-o').addClass('controled');
	}
})

function addClassToThumbs(result,isLike,icon,num){
	$(isLike).val(result.extend.isLike);
	if($(isLike).val() == 1){
		$(icon).addClass('controled');
	}
	else if($(isLike).val() == 0){
		$(icon).removeClass('controled');
	}
	$(num).html(result.extend.likeNum);
}

function addClassToCollection(result,isCollection,icon,num){
	$(isCollection).val(result.extend.isCollection);
	if($(isCollection).val() == 1){
		$(icon).addClass('controled');
	}
	else if($(isCollection).val() == 0){
		$(icon).removeClass('controled');
	}
	$(num).html(result.extend.collectionNum);
}
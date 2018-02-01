/**
 * 文件说明：有关回复的js都写在这里
 */
// <reference path="jquery.min.js" />

$(function () {

	var 
		btnReplyLzReply,
		lPost,
		lNum;

	$('.editor-container-area').each(function () {
		$(this).attr('data-repliesuserid', $(this).parent().parent().siblings('div.core-reply').find('input#ByRepliesUserId').val());
		$(this).focus(function () {
			repliesId = $(this).attr('data-comments-id');
			byRepliesUserId = $(this).attr('data-repliesuserid');
		})
	})

	$('.btn-reply-lz').each(function(){
		$(this).click(function(){
			var inputReplyArea = $(this).parent().parent().parent().siblings("div.lzl-editor-container").find('div.editor-container-area');
			inputReplyArea.focus();
			inputReplyArea.prev().addClass('hidden');
			$(this).parents('div.core-reply').next('div.core-reply-container').removeClass('hidden');
			if($(this).next('span.shou-reply').hasClass('hidden')){
				$(this).next('span.shou-reply').removeClass('hidden');
				$(this).addClass('hidden');
			}
		})
		
	});
	
	$('.shou-reply').each(function(){
		$(this).click(function(){
			if($(this).prev('a.btn-reply-lz').hasClass('hidden')){
				$(this).prev('a.btn-reply-lz').removeClass('hidden');
				$(this).addClass('hidden');
				$(this).parents('div.core-reply').next('div.core-reply-container').addClass('hidden');
			}
		})
		
	});
	
	$('.btn-reply-lz-reply').each(function(){
		$(this).click(function(){
			repliesId = $(this).siblings('#repliesId').val();
			byRepliesUserId = $(this).siblings('#ByRepliesUserId').val();
			var inputReplyUsername = $(this).parents('div.d-author-post-content-main').find('div.editor-container-area');
			inputReplyUsername.attr('data-repliesuserid', byRepliesUserId);
			inputReplyUsername.prev().removeClass('hidden');
			inputReplyUsername.prev().html('回复：　' +  $(this).parent().parent().find('a.lzl-username').html());
			inputReplyUsername.focus();
		})
	})
	
	$('.core-reply-container').each(function(){
		$(this).addClass('hidden');
	})

	lPost = $('.l-post');
	lNum = $('.l-num');
	for (var i = 1; i <= lPost.length; i++) {
		$(lNum[i - 1]).html(i);
	}

});
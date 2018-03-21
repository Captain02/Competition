/**
 *
 */
// <reference path="jquery.min.js" />
$(function() {

	var btnReplyLzReply, lPost, lNum;

	/*回复框*/
	$('div.editor-container-area').each(function() {
		var input = $(this);
		$(this).attr('data-byrepliesuserid', $(this).parent().parent().siblings('div.core-reply').find('input#ByRepliesUserId').val());
		$(this).attr('data-comments-id',$(this).prev('input.editor-container-area').attr('data-comments-id'));
		
		$(this).focus(function() {
			repliesId = input.attr('data-comments-id');
			byRepliesUserId = input.attr('data-byrepliesuserid');
		});
	});
	
	/*回复按钮*/
//	$('.btn-reply-lz').each(function() {
//		$(this).click(function() {
//			var inputReplyArea = $(this).parent().parent().parent().siblings('div.lzl-editor-container').find('div.editor-container-area');
//			inputReplyArea.focus();
//			inputReplyArea.prev().addClass('hidden');
//			$(this).parents('div.core-reply').next('div.core-reply-container').removeClass('hidden');
//			if ($(this).next('span.shou-reply').hasClass('hidden')) {
//				$(this).next('span.shou-reply').removeClass('hidden');
//				$(this).addClass('hidden');
//			}
//		});
//	});
	
	/*回复回复者的按钮*/
	$('.btn-reply-lz-reply').each(function() {
		/*找到回复框*/
		var inputReply = $(this).parents('div.core-reply-container').siblings('div.lzl-editor-container').find('div.editor-container-area');
		/*找到提交按钮*/
		var btnEditorReply = $(this).parents('div.core-reply-container').siblings('div.lzl-editor-container').find('input.btn-editor-reply');
		/*找到被回复者的用户名*/
		var replyUserName = $(this).parents('div.core-reply-container').siblings('div.lzl-editor-container').find('span.reply-userName');
		
		$(this).click(function() {
			var scrollX = inputReply.offset().top;
			$(document).scrollTop(scrollX-400);
			inputReply.focus();
			
			btnEditorReply.attr('data-reply-state','1');
			inputReply.attr('data-byrepliesuserid',$(this).siblings('#ByRepliesUserId').val());
			replyUserName.html('回复：' + $(this).parents('div.lzl-cnt').find('a.lzl-username').html());
		});
	});

	/*显示回复/收起回复按钮*/
	$('.shou-reply').each(function() {
		$(this).click(function() {
			if ($(this).prev('a.btn-reply-lz').hasClass('hidden')) {
				$(this).prev('a.btn-reply-lz').removeClass('hidden');
				$(this).addClass('hidden');
				$(this).parents('div.core-reply').next('div.core-reply-container').addClass('hidden');
			}
		});
	});

});
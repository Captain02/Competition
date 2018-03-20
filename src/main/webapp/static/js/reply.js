/**
 *
 */
// <reference path="jquery.min.js" />
$(function() {

	var btnReplyLzReply, lPost, lNum;

	$('input.editor-container-area').each(function() {
		var input = $(this);
		$(this).attr('data-byrepliesuserid', $(this).parent().parent().siblings('div.core-reply').find('input#ByRepliesUserId').val());
		$(this).focus(function() {
			repliesId = input.attr('data-comments-id');
			byRepliesUserId = input.attr('data-byrepliesuserid');
		});
	});
	
	$('.btn-reply-lz-reply').each(function() {
		$(this).click(function() {
			var btnEditorReply = $(this).parents('div.core-reply-container').siblings('div.lzl-editor-container').find('input.btn-editor-reply');
			btnEditorReply.attr('data-reply-state','1');
			$('input.editor-container-area').attr('data-byrepliesuserid',$(this).siblings('#ByRepliesUserId').val());
			
		});
	});

	$('.btn-reply-lz').each(function() {
		$(this).click(function() {
			var inputReplyArea = $(this).parent().parent().parent().siblings('div.lzl-editor-container').find('div.editor-container-area');
			inputReplyArea.focus();
			inputReplyArea.prev().addClass('hidden');
			$(this).parents('div.core-reply').next('div.core-reply-container').removeClass('hidden');
			if ($(this).next('span.shou-reply').hasClass('hidden')) {
				$(this).next('span.shou-reply').removeClass('hidden');
				$(this).addClass('hidden');
			}
		});
	});

	$('.shou-reply').each(function() {
		$(this).click(function() {
			if ($(this).prev('a.btn-reply-lz').hasClass('hidden')) {
				$(this).prev('a.btn-reply-lz').removeClass('hidden');
				$(this).addClass('hidden');
				$(this).parents('div.core-reply').next('div.core-reply-container').addClass('hidden');
			}
		});
	});

	lPost = $('.l-post');
	lNum = $('.l-num');
	for (var i = 1; i <= lPost.length; i++) {
		$(lNum[i - 1]).html(i);
	}

});
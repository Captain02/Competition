/**
 * 文件说明：有关回复的js都写在这里
 */

$(function () {
	//楼层递增
	var lPost = $('.l-post');
	var lNum = $('.l-num');
	for (var i = 1; i <= lPost.length; i++) {
		$(lNum[i - 1]).html(i);
	}

	//点击回复按钮获得帖子id和要回复的那个人的id
	var btnReplyLz = $('.btn-reply-lz');
	for (var i = 0; i < btnReplyLz.length; i++) {
		$(btnReplyLz[i]).click(
			function () {
				repliesId = $(this).siblings('#repliesId').val();
				byRepliesUserId = $(this).siblings('#ByRepliesUserId').val();
				var inputReplyArea = $(this).parent().parent().parent().siblings("div.lzl-editor-container").find('div.editor-container-area');
				inputReplyArea.focus();
				inputReplyArea.val('');
				inputReplyArea.attr('placeholder', '在此输入回复信息');
			})
	}


	//点击回复按钮，将回复者的用户名填写到回复框中，并加上回复二字
	var btnReplyLzReply = $('.btn-reply-lz-reply');
	for (var i = 0; i < btnReplyLzReply.length; i++) {
		$(btnReplyLzReply[i]).click(function () {
			repliesId = $(this).siblings('#repliesId').val();
			byRepliesUserId = $(this).siblings('#ByRepliesUserId').val();
			var replyUsername = $(this).parent().parent().find('a.lzl-username').html();
			var inputReplyUsername = $(this).parents('div.d-author-post-content-main').find("textarea[name='editor-container-area']");
			inputReplyUsername.attr('placeholder', '回复　' + replyUsername + ':');
			inputReplyUsername.focus();
		})
	}

});

window.onbeforeunload = function () {
	var scrollPos;
	if (typeof window.pageYOffset != 'undefined') {
		scrollPos = window.pageYOffset;
	} else if (typeof document.compatMode != 'undefined' && document.compatMode != 'BackCompat') {
		scrollPos = document.documentElement.scrollTop;
	} else if (typeof document.body != 'undefined') {
		scrollPos = document.body.scrollTop;
	}
	document.cookie = "scrollTop=" + scrollPos; //存储滚动条位置到cookies中  
}


window.onload = function () {
	if (document.cookie.match(/scrollTop=([^;]+)(;|$)/) != null) {
		var arr = document.cookie.match(/scrollTop=([^;]+)(;|$)/); //cookies中不为空，则读取滚动条位置  
		document.documentElement.scrollTop = parseInt(arr[1]);
		document.body.scrollTop = parseInt(arr[1]);
	}
}
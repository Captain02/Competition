/**
 * 文件说明：有关回复的js都写在这里
 */

$(function(){
	//楼层递增
	var lPost = $('.l-post');
	var lNum = $('.l-num');
	for(var i = 1; i<=lPost.length; i++){
		$(lNum[i-1]).html(i);
	}
	
	//载入页面的时候，如果评论没有回复，则隐藏下面的回复框，点击回复按钮的时候，才会显示出来
	
	
	//回复按钮的操作
	var btnReply = $('.btn-reply-lz');
	btnReply.click(function(){
		
	});
	
});

window.onbeforeunload = function () {
    var scrollPos;
    if (typeof window.pageYOffset != 'undefined') {
        scrollPos = window.pageYOffset;
    }
    else if (typeof document.compatMode != 'undefined' && document.compatMode != 'BackCompat') {
        scrollPos = document.documentElement.scrollTop;
    }
    else if (typeof document.body != 'undefined') {
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
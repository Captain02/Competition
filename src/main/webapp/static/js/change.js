// <reference path="jquery.min.js" />
/**
 * 
 */
// 页面交互效果

// No.1 隐藏侧边栏效果
$(function () {
    var flag = 1;
    var toggleBtn = $('.toggle-btn');
    var bodyClass = $('body');
    var menuText = $('.nav-user a');
    //控制按钮样式
    toggleBtn.mousemove(function () {
        $('.toggle-btn').css('backgroundColor', 'rgb(101,206,167)');
        $('.toggle-btn span').css('color', 'white');
    })
    toggleBtn.mouseout(function () {
        toggleBtn.css('backgroundColor', 'white');
        $('.toggle-btn span').css('color', 'rgb(182, 180, 180)');
    })
    //控制点击按钮事件
    toggleBtn.click(function () {
        if (flag) {
            $('body').addClass('stickey-menu');
            flag = 0;
        } else {
            $('body').removeClass('stickey-menu');
            flag = 1;
        }
        return false;
    })
    //在缩小状态下显示提示框
    for (var i = 0; i < menuText.length; i++) {
        $(menuText[i]).mousemove(function () {
            if (bodyClass.hasClass('stickey-menu')) {
                $(this).addClass('show-stickey-menu');
            }
        })
        $(menuText[i]).mouseout(function () {
            if (bodyClass.hasClass('stickey-menu')) {
                $(this).removeClass('show-stickey-menu');
            }
        })
    }

    //No.2 左侧导航栏效果
    var menuLi = $('.nav-user li');
    for (var i = 0; i < menuLi.length; i++) {
        $(menuLi[i]).mousemove(function () {
            if (bodyClass.hasClass('stickey-menu')) {
                $(this).addClass('nav-hover-stickety');
            } else {
                $(this).addClass('nav-hover');
            }
        });
        $(menuLi[i]).mouseout(function () {
            if (bodyClass.hasClass('stickey-menu')) {
                $(this).removeClass('nav-hover-stickety');
            } else {
                $(this).removeClass('nav-hover');
            }
        });
    }
    
    //No.4 显示会话栏效果
    $('.btn-mycomment').click(function(){
    	switch ($(this).attr('data-chat-status')) {
		case 'true':
			$('#chat').show(500);
			$(this).attr('data-chat-status','flase');
			break;
		case 'flase':
			$('#chat').hide(500);
			$(this).attr('data-chat-status','true');
			break;
		default:
			break;
		}
    })
    
    //No.5 获取通知消息
    $('.comment div li').each(function(){
    	$(this).click(function(){
    		$('#myModal').modal('show');
    		ShowTips('.modal-title',$(this).find('p.charts-friends-info-abbr').html(),'.modal-body',$(this).find('p.charts-text-abbr').html());
    		ShowEle('.yes','hide','.no','hide','.down','hide');
    	})
    })
	
    //No.6 会话列表的切换
    $('.charts-opearte li').each(function(){
    	$(this).click(function(){
    		var btn = $(this);
    		$('div.chat-info').each(function(){
    			if($(this).attr('data-index') === btn.attr('data-index')){
    				$(this).removeClass('hidden');
    				$(this).siblings('div.chat-info').addClass('hidden');
    				btn.addClass('active');
    				btn.siblings().removeClass('active');
    			}
    		})
    	})
    })
    
  
});
//No.3 点赞效果
function ActivityControl(result,hiddenValue,icon,cntrolNum){
	hiddenValue.val(result.extend.isLike);
	if(hiddenValue.val() == 1){
		icon.addClass('controled');
	}
	else if(hiddenValue == 0){
		icon.removeClass('controled');
	}
	cntrolNum.html(result.extend.likeNum);
}
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
    	//初始化会话列表
    	$('.char-comment li').remove();
    	//初始化好友列表
    	$('.chart-friends li').remove();
    	switch ($(this).attr('data-chat-status')) {
		case 'true':
			$('#chat').slideDown(200);
			$(this).attr('data-chat-status','flase');
			open();
			break;
		case 'flase':
			$('#chat').slideUp(200);
			$(this).attr('data-chat-status','true');
			close();
			break;
		default:
			break;
		}
    })
    
    //No.5 获取通知消息
   $('.char-comment').on('click','li',function(){
	   if($(this).attr('data-info-status') === '1'){
		   return false;
	   }
	   $(this).attr('data-info-status','1');
	   //初始化会话列表
	   $('.cool-chat li').remove();
	   switch ($(this).attr("data-info-type")) {
	   
		case 'addFrends':
			$('#myModal').modal('show');
			ShowTips('.modal-title','好友验证','.modal-body',
					$(this).find('p.charts-text-abbr').html()+
					"<a class='not-sure-require-friend pull-right btn btn-warning btn-sm' onclick='notSure(this)' data-not-sure-id="+$(this).attr('data-info-userid')+" data-info-status="+$(this).attr('data-info-status')+">拒绝</a>"+
					"<a class='sure-require-friend pull-right btn btn-success btn-sm' onclick='sure(this)' data-sure-id="+$(this).attr('data-info-userid')+" data-info-status="+$(this).attr('data-info-status')+">同意</a>"
					);
			break;
			
		case 'agreeAddFriend':
			$('#myModal').modal('show');
			ShowTips('.modal-title','验证消息','.modal-body',
					$(this).find('p.charts-text-abbr').html()+
					"<a style='display:none;' data-info-status="+$(this).attr('data-info-status')+" data-not-sure-id="+$(this).attr('data-info-userid')+"></a>"
					);
			setTimeout(function(){
				$('#myModal').modal('hide');
			},3000)
			$('.char-comment li').each(function(){
				if( $(this).attr('data-info-userid')===$('.modal-body a').attr('data-not-sure-id') && $(this).attr('data-info-status')===$('.modal-body a').attr('data-info-status')){
					$(this).remove();
				}
			})
			unAgreeAddFriend($(this).attr('data-info-userid'));
			break;
			
		case 'sendTalk':
			var li = $(this);
			$(this).find('span.label-new-info-num').remove();
			$('#chat-window').removeClass('hidden');
	    	$('#chat-window').find('h4').html($(this).find('p.charts-friends-info-abbr').html());
	    	$('#chat-window').find('button.btn-send').attr('data-userid',$(this).attr('data-userid'));
	    	var data = {};
	    	
	    	$(this).siblings().each(function(){
	    		$(this).find('span.label-new-info-num').remove();
	    		if($(this).attr('data-info-userid')===li.attr('data-info-userid') && $(this).attr('data-info-type')==='sendTalk'){
	    			addMessage(data,$(this));
	    		}
	    	});
	    	addMessage(data,$(this));
	    	break;
	    	
		default:
			break;
	   }
   })
   
	
    //No.6 会话列表的切换
    $('.charts-opearte li').each(function(){
    	$(this).click(function(){
    		var btn = $(this);
    		$('div.chat-info').each(function(){
    			if($(this).attr('data-index') === btn.attr('data-index')){
    				$(this).removeClass('hidden');
    				$(this).parent().parent().siblings().find('div.chat-info').addClass('hidden');
    				btn.addClass('active');
    				btn.siblings().removeClass('active');
    			}
    		})
    	})
    })
    
  
    //No.9 弹出会话窗口
    $('.chart-friends').on('dblclick','li',function(){
    	$('#chat-window').removeClass('hidden');
    	$('#chat-window').find('h4').html($(this).find('p.charts-friends-info-abbr').html());
    	$('#chat-window').find('button.btn-send').attr('data-userid',$(this).attr('data-userid'));
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
//No.7 动态插入消息节点
function addNewsToList(data){
	var pathName = window.document.location.pathname;
	var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
	var listNode = $(
			"<li data-info-type="+data.type+" data-info-username="+data.fromName+" data-info-userId="+data.fromId+" data-info-status='0' onselectstart='return false;' data-info-date="+data.date+" data-info-headfile="+data.user.headFile+">"+
			"<div class='row'>"+
			"<div class='col-md-2'>"+
			"<div class='person-img friend-img clearfix'>"+
			"<img src="+projectName+"/personHeadFile/"+data.user.headFile+">"+
			"</div>"+
			"</div>"+
			"<div class='col-md-10'>"+
			"<div class='charts-myfriends-text'>"+
			"<p class='charts-friends-info-abbr clearfix'>"+
			data.fromName+
			"<span class='label-new-info-num pull-right'>1</span>"+
			"</p>"+
			"<p class='charts-text-abbr'>"+
			data.text+
			"</p>"+
			"</div>"+
			"</div>"+
			"</div>"+
			"</li>"
					);
	$('.char-comment').append(listNode);
	var massageNum = $("li[data-info-userid="+listNode.attr('data-info-userid')+"][data-info-type='sendTalk']");
	$('span.label-new-info-num').html(massageNum.length);
	listNode.siblings("[data-info-username="+listNode.attr('data-info-username')+"][data-info-type='addFrends']").remove();
	listNode.siblings("[data-info-userid="+listNode.attr('data-info-userid')+"][data-info-type='sendTalk']").hide();
}

//No.8 动态生成好友列表
function addFriendsToList(result){
	var pathName = window.document.location.pathname;
	var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
	$(result.extend.friends).each(function(){
		var listNode = $(		
				"<li onselectstart='return false;' data-userid="+$(this).attr('id')+">"+
				"<div class='row'>"+
				"<div class='col-md-2'>"+
				"<div class='person-img friend-img clearfix'>"+
				"<img src="+ projectName +"/personHeadFile/"+$(this).attr('headFile')+">"+
				"</div>"+
				"</div>"+
				"<div class='col-md-10'>"+
				"<div class='charts-myfriends-text'>"+
				"<p class='charts-friends-info-abbr clearfix'>"+
				$(this).attr('username')+
				"</p>"+
				"<p class='charts-text-abbr'>"+
				"暂无简介"+
				"</p>"+
				"</div>"+
				"</div>"+
				"</div>"+
				"</li>"
						);
		$('.chart-friends').append(listNode);
		
	})
}

//No .10 创建消息节点
function addMessageToMessageList(data,thisClass){
	var pathName = window.document.location.pathname;
	var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
	var listNode = $(
			"<li class='in "+thisClass+"'>"+
			"<a><img src="+projectName+"/personHeadFile/"+data.user.headFile+" class='avatar'></a>"+
			"<div class='message'>"+
			"<span class='arrow'></span>"+
			"<a class='name' href='/user/show/1503578717063303691' target='_blank'>"+data.fromName+"</a>"+
			"<span class='datetime'>"+data.date+"</span>"+
			"<span class='body'>"+
			data.text+
			"</span>"+
			"</div>"+
			"</li>"
					);
	$('.cool-chat').append(listNode);
	$('div.input-chat-text').html('');
	$('div.input-chat-text').focus();
}

//No.11 将消息添加到会话框中
function addMessage(data,ele){
	data['fromName'] = ele.find('p.charts-friends-info-abbr').html();
	data['text'] = ele.find('p.charts-text-abbr').html();
	data['date'] = ele.attr('data-info-date');
	data['user'] ={
		headFile:ele.attr('data-info-headfile')
	};
	var json = JSON.stringify(data);
	addMessageToMessageList(data,'');
	$('.chat-content-body').scrollTop($('.chat-content-body')[0].scrollHeight );
}
























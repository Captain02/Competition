// <reference path="jquery.min.js" />
/**
 * 
 */
// 页面交互效果

//隐藏侧边栏效果
$(function () {
	//隐藏侧边栏的效果
    var flag = 0;
    var toggleBtn = $('.toggle-btn');
    var bodyClass = $('body');
    var menuText = $('.nav-user a');
    var menuLi = $('.nav-user li');
    toggleBtn.mousemove(function () {
        $('.toggle-btn').css('backgroundColor', 'rgb(101,206,167)');
        $('.toggle-btn span').css('color', 'white');
    })
    toggleBtn.mouseout(function () {
        toggleBtn.css('backgroundColor', 'white');
        $('.toggle-btn span').css('color', 'rgb(182, 180, 180)');
    })
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
    }//end
    
    //显示会话栏
    $('.btn-mycomment').click(function(){
    	$('.char-comment li').remove();
    	switch ($(this).attr('data-chat-status')) {
		case 'true':
			$('#chat').slideDown(200);
			$(this).attr('data-chat-status','flase');
			openSocket();
			break;
		case 'flase':
			$('#chat').slideUp(200);
			$(this).attr('data-chat-status','true');
			close();
			break;
		default:
			break;
		}
    })//end
    
   //根据消息类型的不同，点击之后进行不同的操作
   $('.char-comment').on('click','li',function(){
	   $(this).find('span.label-new-info-num').remove();
	   $(this).attr('data-info-status','1');
	   $(this).siblings('li[data-info-type="sendTalk"]').attr('data-info-status',0);
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
			chatWindowValue('#chat-window',$(this));
			var data = {};
			$(this).siblings().each(function(){
				if($(this).attr('data-info-userid')===li.attr('data-info-userid') && $(this).attr('data-info-type')==='sendTalk'){
					addMessage(data,$(this));
				}
			});
			addMessage(data,$(this));
		break;
		
		case 'videoTalk':
			chatWindowValue('#chat-window',$(this));
			showMessageHistoryArea();
			var videoTalk = $('.message-histroty-content').find('div.video-talk');
			videoTalk.find('a.user-img').find('img').attr('src',""+$(this).find('div.person-img').find('img').attr('src')+"");
			videoTalk.find('a.answer-video').attr({
				'data-info-fromid':""+$(this).attr('data-info-userid')+"",
				'data-info-toid':""+$(this).attr('data-info-touserid')+"",
				'data-info-answeraddress':""+$(this).find('span.answerAddress').html()+""
			});
			showOrHide($(this));
		break;
		
		default:
		break;
	   }
   })//end
   
	
    //会话列表操作的切换
    $('.charts-opearte li').each(function(){
    	$(this).click(function(){
    		$(this).attr('data-status',1);
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
    })//end
    
  
    //弹出聊天窗口
    $('.chart-friends').on('dblclick','li',function(){
    	chatWindowValue('#chat-window',$(this));
    	$('.message-histroty-content').addClass('hidden');
    	$('#chat-window').addClass('message-hide');
    	$('.chat-content').removeClass('col-md-6');
    })//end
    
    //查看公告
    $("li.new").each(function(){
		$(this).click(function(){
			$('#myModal').modal('show');
			ShowTips('.modal-title','公告详情','.modal-body',$(this).find('input.notice-text').val());
		})
	})//end
	
	//可移动的会话框
	$('.chat-content-header').mousedown(function(e){
		e = window.event || e;
		var offset = $('#chat-window').offset();
		var x = e.pageX - offset.left;
		var y = e.pageY - offset.top;
		
		$(document).bind("mousemove",function(ev){
            $("#chat-window").stop();

            var _x = ev.pageX - x;
            var _y = ev.pageY - y;

            	$("#chat-window").css({
            		"left":_x+"px",
            		"top":_y+"px"
            	});
            $('body').addClass('no-select');
        });
		 $(document).mouseup(function(){  
	            $(this).unbind("mousemove");
	            $('body').removeClass('no-select');
	     });  
	});//end
	
    //关闭会话框按钮
	$('.btn-close').click(function(){
		$('div.vtalk-view iframe').remove();
		chatWindowClose($('.btn-send').attr('data-info-userid'));
		 (function(ele){
			 $(ele).addClass('hidden');
			 $(ele).attr('data-status',0);
		 }('#chat-window'));
		 $('.char-comment li[data-info-type="sendTalk"]').each(function(){
			 if($(this).attr('data-info-status')=== '1'){
				 $(this).attr('data-info-status',0);
			 }
		 })
		 
	})//end
	
	//弹出消息历史窗口
	$('.message-history').click(function(){
		showMessageHistoryArea();
		showOrHide($(this));
	})//end
		
	//在历史消息中区分我的消息和他人消息
	$('.message-history-area li').each(function(){
		if($(this).attr('data-myid') === $(this).attr('data-userid')){
			$(this).addClass('my-message');
		}
	})//end
	
	//弹出白名单窗口
	$('#cc-username').click(function(){
       $('#myModal').modal('show');
    })//end
     
     //判定当前项目所属的访问控制并在页面上勾选
     $('input[name="releaseControl"]').each(function(){
    	 if($(this).val() === $(this).attr('data-releaseControl')){
    		 $(this).prop('checked', true);
    	 }
     })
     
     //判定当前项目所属访问控制并添加active样式
     $('a.p-follow-btn').each(function(){
    	 if( $(this).attr('data-state')!==undefined && $(this).attr('data-project-state')!==undefined){
    		 if( $(this).attr('data-state') === $(this).attr('data-project-state')){
        		 $(this).addClass('active');
        	 }
    	 }
     })
     
     //载入页面的时候如果自定义按钮被勾选了，那么白名单框就显示出来
     $('input[name="releaseControl"]:checked').each(function(){
 		if($(this).attr('data-control-value') == 1){
 			$('#whitename').show();
 		}
 		else{
 			$('#whitename').hide();
 		}
 	});//end
	
    //自定义访问控制
	$('input[name="releaseControl"]').on('click', function(){
  		var obj = $(this);
  		if (obj.attr('data-control-value') == 1) {
  			$('#whitename').show();
  		} else {
  			$('#whitename').hide();
  		}
  	});
	
	//以逗号分割用户名，以短线分割选中的白名单人员的id
	var idArray = new Array(),
		nameArray = new Array();
	$('.yes-add').click(function(){
		idArray.length = 0;
		nameArray.length = 0;
		$('.modal-body input[name="whiteListName"]:checked').each(function(){
		idArray.push($(this).attr('data-userid'));
			nameArray.push($(this).val());
		});
	
		var idStr = idArray.join('-');
		var nameStr = nameArray.join(',');
		$('#ccid').val(idStr);
		$('#cc-username').val(nameStr);
		$('#myModal').modal('hide');
		
		var ccidArr = $('#ccid').val().split(',');
		$('.modal-body input[name="whiteListName"]').each(function(){
			if($.inArray($(this).attr('data-userid'),ccidArr) >=0){
				$(this).prop('checked', true);
			}
		})
	});//end
	
})

//动态插入消息节点到消息列表中
function addNewsToList(data){
	var pathName = window.document.location.pathname;
	var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
	var listNode = $(
			"<li data-info-type="+data.type+" data-info-username="+data.fromName+" data-info-userId="+data.fromId+" data-info-touserId="+data.toId+" data-info-status='0' onselectstart='return false;'  data-info-headfile="+data.user.headFile+">"+
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
			"<span class='date hidden'>"+data.date+"</span>"+
			"<span class='answerAddress hidden'>"+data.answerAddress+"</span>"+
			"</li>"
					);
	$('.char-comment').append(listNode);
	var massageNum = $("li[data-info-userid="+listNode.attr('data-info-userid')+"][data-info-type='sendTalk']");
	$('span.label-new-info-num').html(massageNum.length);
	listNode.siblings("[data-info-username="+listNode.attr('data-info-username')+"][data-info-type='addFrends']").remove();
	listNode.siblings("[data-info-userid="+listNode.attr('data-info-userid')+"][data-info-type='sendTalk']").hide();
}//end

//将收到的消息插入到会话框中
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
	$('p.input-chat-text').html('');
	$('p.input-chat-text').focus();
}//end


//点击消息列表中的消息，弹出会话框，并把消息添加到会话框中
function addMessage(data,ele){
	data['fromName'] = ele.find('p.charts-friends-info-abbr').html();
	data['text'] = ele.find('p.charts-text-abbr').html();
	data['date'] = ele.find('span.date').html();
	data['user'] ={
		headFile:ele.attr('data-info-headfile')
	};
	addMessageToMessageList(data,'');
	$('.chat-content-body').scrollTop($('.chat-content-body')[0].scrollHeight );
}//end

//生成好友列表插入到联系人列表中
function addFriendsToList(result){
	var pathName = window.document.location.pathname;
	var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
	$(result.extend.friends).each(function(){
		var listNode = $(		
				"<li onselectstart='return false;' data-info-userid="+$(this).attr('id')+">"+
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
		
	});
}//end

//会话窗口的赋值
function chatWindowValue(ele,val){
	$(ele).removeClass('hidden');
	$(ele).attr('data-status',1);
	$(ele).find('h4.chat-content-title').html(val.find('p.charts-friends-info-abbr').html());
	$(ele).find('button.btn-send').attr('data-info-userid',val.attr('data-info-userid'));
	$(ele).find('a.message-video').attr('data-info-userid',val.attr('data-info-userid'));
}//end

//聊天框的展开形态
function showMessageHistoryArea(){
	var chatArea = $('#chat-window');
	var chatContent = $('.chat-content');
	var messageHistory = $('.message-histroty-content');
	(chatArea.hasClass('message-hide'))?chatArea.removeClass('message-hide'):chatArea.addClass('message-hide');
	(chatContent.hasClass('col-md-6'))?chatContent.removeClass('col-md-6'):chatContent.addClass('col-md-6');
	(messageHistory.hasClass('hidden'))?messageHistory.removeClass('hidden'):messageHistory.addClass('hidden');
}//end

//根据进行操作的不同来显示或隐藏聊天框侧边栏的某些元素
function showOrHide(ele){
	$('div.vtalk-view iframe').remove();
	$('.message-histroty-content div.row > div').each(function(){
		var div = $(this);
		var dataInfoType = $(this).attr('data-info-type');
		if($(ele).attr('data-info-type')=== dataInfoType){
			div.removeClass('hidden');
			div.siblings().addClass('hidden');
			return false;
		}
		
	});
}

//知识的点赞效果
function ActivityControl(result,hiddenValue,icon,cntrolNum){
	hiddenValue.val(result.extend.isLike);
	if(hiddenValue.val() == 1){
		icon.addClass('controled');
	}
	else if(hiddenValue == 0){
		icon.removeClass('controled');
	}
	cntrolNum.html(result.extend.likeNum);
}//end





















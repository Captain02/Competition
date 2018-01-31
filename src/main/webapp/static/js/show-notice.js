/**
 * 文件说明：公告页展示公告的js
 */
$(function(){
		$('.notice-text a').each(function(){
			var maxwidth = 30
			if($(this).text().length>maxwidth){
				$(this).text($(this).text().substring(0,maxwidth));
				$(this).html($(this).html() + '...');
			}
			
			$(this).click(function(){
				$('#myModal').modal('show');
				$('.btn-more-info').addClass('hidden');
				$('div.notice-info').addClass('hidden');
				ShowTips('.modal-title','公告详情','.modal-body',$(this).attr('data-notice-text'));
			})
			
		})
		
		$('.view-notice').each(function(){
			$(this).click(function(){
				$('#myModal').modal('show');
				ShowTips('.modal-title','公告详情','.modal-body',$(this).attr('data-notice-text'));
				$('div.notice-info').addClass('hidden');
				$('.btn-more-info').removeClass('hidden');
				$('.notice-author').html($(this).attr('data-notice-username'));
				$('.notice-author-deparment').html($(this).attr('data-notice-department'));
				$('.notice-author-role').html($(this).attr('data-notice-role'));
				$('.notice-date').html($(this).attr('data-notice-date'));
				$('.profile-pic img').attr('src',$(this).attr('data-notice-headfile'));
			})
		})
		
		$('.btn-more-info').click(function(){
			if($('div.notice-info').hasClass('hidden')){
				$('div.notice-info').removeClass('hidden');
			}
			else{
				$('div.notice-info').addClass('hidden');
			}
		});
		
	})
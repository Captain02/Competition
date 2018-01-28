/**
 * 文件说明：知识评论页的文本编辑器配置
 */

//初始化kindEditor配置
$(function(){
	var editor = KindEditor.create('textarea[name="comment"]', {
		minHeight:'100',
		themeType : 'simple',
		items : [
			'bold','italic','underline','fontname','fontsize','forecolor','image','emoticons','baidumap']
	});
})
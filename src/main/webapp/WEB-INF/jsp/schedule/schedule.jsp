<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
	
	<%
		pageContext.setAttribute("APP_PATH", request.getContextPath());
	%>
	
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>日程管理</title>
    <link rel="stylesheet" href="${APP_PATH}/static/fullcalendar/fullcalendar.min.css" />
	<jsp:include page="iniCssHref.jsp"></jsp:include>
	<link rel="stylesheet" href="${APP_PATH}/static/css/font-awesome.css">
	
	<link rel="stylesheet" href="${APP_PATH}/static/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css">
	<script src="${APP_PATH}/static/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
	<script src="${APP_PATH}/static/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
	
	
    <script src="${APP_PATH}/static/fullcalendar/lib/moment.min.js"></script>
    <script src="${APP_PATH}/static/fullcalendar/fullcalendar.min.js"></script>
    
	<script type="text/javascript">
	$.ajax({
		url:"${APP_PATH}/admin/schedule/scheduleds",
		data:'',
		type:"GET",
		success:function(result){
			$.each(result.extend.schedules,function (index, term) {
				console.log(term);
                $("#calendar").fullCalendar('renderEvent', term, true);
            });
		}
	})
	
	function save(ele){
		$('input.schedu-info').each(function(){
			if($(this).val() == ''){
				alert('请填写完整日程信息');
				return false;
			}
		})
		var isInsert = $(ele).attr('data-isInsert');
		$.ajax({
				url:"${APP_PATH}/admin/schedule/save",
				data:"isInsert="+isInsert+'&'+$('#scheduleForm').serialize(),
				type:"POST",
				success:function(result){
					
				}
			})
	}
	
	function updateDay(days,start,end,id){
		
 		var startTime = new Date(start).format("yyyy-MM-dd hh:mm:ss");
 		var endTime = new Date(end).format("yyyy-MM-dd hh:mm:ss");
		$.ajax({
        	url:"${APP_PATH}/admin/schedule/updateDay",
        	data:{
        		'days':days,
        		'start':startTime,
        		'end':endTime,
        		'id':id
        	},
        	type:"POST",
        	success:function(result){
        		
        	}
        }) 
	}
	</script>
	
</head>

    <body class="bg-common stickey-menu">

        <section>

            <!-- 页面模版，每页左侧区域固定不变 -->
            <jsp:include page="iniLeftMenu.jsp"></jsp:include>

            <div class="main-content">
             <!-- 页面模版，每页主体部分头部按需更改 -->
            <div class="content-head content-head-section">

                <a href="" class="toggle-btn">
                    <span class="glyphicon glyphicon-th-list"></span>
                </a>


                <div class="content-head-right"></div>

                <div class="clearfix"></div>

            </div>
                <!-- 页面模版，按需更改 -->
                <div class="wrapper">
                <div class="om-header">

                        <div class="om-header-left">
                            <h3>
                                <span class="om-title">日程管理</span>
                            </h3>
                        </div>

                        
					  <div class="row">
					  	<div class="col-md-3">
					  		<div class="panel">
					  			<header class="panel-heading">日程设置</header>
					  			<div class="panel-body">
					  			
					  		<form id="scheduleForm" action="">
					  		
					  			<div class="form-group">
				                  <label>日程名称</label>
				                  <input class="schedu-info form-control" name="title" placeholder="日程名称" type="text">
               					</div>
					  			
					  			
								<div class="form-group">
									<label for="">开始日期</label>
									<div class="input-group date form_datetime">
									    <input name="startTime" class="schedu-info form-control" type="text" value="" readonly>
									    <span class="input-group-addon clearTime"><i class="fa fa-times"></i></span>
									    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
									</div>
								</div>
								
								<div class="form-group">
									<label for="">结束日期</label>
									<div class="input-group date form_datetime">
									    <input name="endTime" class="schedu-info form-control" type="text" value="" readonly>
									    <span class="input-group-addon clearTime"><i class="fa fa-times"></i></span>
									    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
									</div>
								</div>
								
								<input type="hidden"  name="id"/>
								
								<div class="form-group schedule-control">
									<button class="btn btn-success btn-save btn-sm" data-isInsert="1" type="button" onclick="save(this);">提交</button>
									<button class="btn btn-warning btn-editor btn-sm" data-isInsert="0" type="button" onclick="save(this);">修改</button>
									<button class="btn btn-danger btn-delete btn-sm" data-isInsert="-1" type="button" onclick="save(this);">删除</button>
								</div>
								
					  	</form>
								
					  		</div>
					  		</div>
					  	
					  	</div>
					  	
					  	
					  	
					  	<div class="col-md-9">
					  		<section class="panel">
					  			<div id="calendar"></div>
					  		</section>
					  	</div>
					  	
					  	
					    </div>  


                    </div>
                </div>
               </div>

        </section>
        
       
        <script type="text/javascript">
        $(function () {  
            $(".form_datetime").datetimepicker({
                format: "yyyy-mm-dd hh:ii",
                autoclose: true,
                todayBtn: true,
                minuteStep: 10,
                language:'zh-CN'
            });
        });  
        </script>
        
       <script type="text/javascript">
			$(function(){
				if($('input[name="id"]').val() ==''){
					$('button.btn-editor').attr('disabled','disabled');
					$('button.btn-delete').attr('disabled','disabled');
				}
				var scheduleInfOld = new Array();
				$('input[name="id"]').val('');
				$('#calendar').fullCalendar({
					header: {
						left: 'prev,next today',
			            center: 'title',
			            right: 'month,agendaWeek,agendaDay,listMonth'
					},
					monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
					monthNamesShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
					dayNames: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"],
					dayNamesShort: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"],
					buttonText: {
					    today: '今天',
					    month: '月',
					    week: '周',
					    day: '日',
					    prev:'上一月',
					    next:'下一月',
					    list:'月总览'
					},
					editable : true,
					dragOpacity: 0.5,
					
					//拖动改变日程日期
					eventDrop : function( event, dayDelta, revertFunc ) {
					    if(dayDelta._days != 0){
					        days = dayDelta._days;
					        updateDay(days,event.start,event.end,event.id);
					    }else if(dayDelta._milliseconds != 0){
					        console.log('eventDrop被执行，Event的start和end时间改变了：', dayDelta._milliseconds/1000+'秒！');
					    }else{
					        console.log('eventDrop被执行，Event的start和end时间没有改变！');
					    }
					},
					
					//拖拽改变日程日期
					eventResize:function(event,dayDelta,minuteDelta,revertFunc){
						updateDay(0,event.start,event.end,event.id);
					},
					
					//点击查看日程详情
					eventClick:function(event){
						$('button.btn-delete').removeAttr('disabled','disabled');
						$('button.btn-save').attr('disabled','disabled');
						$('input[name="id"]').val(event.id);
						scheduleInfOld.push(event.title,new Date(event.start).format('yyyy-MM-dd hh:mm:ss'),new Date(event.end).format('yyyy-MM-dd hh:mm:ss'));
						$('input[name="title"]').val(event.title);
						$('input[name="startTime"]').val(new Date(event.start).format('yyyy-MM-dd hh:mm:ss'));
						$('input[name="endTime"]').val(new Date(event.end).format('yyyy-MM-dd hh:mm:ss'));
					}
				})
				
				$('input.schedu-info').each(function(){
					$(this).change(function(){
						if($.inArray($(this).val(),scheduleInfOld) == -1 && $(this).val() != ''){
							$('button.btn-editor').removeAttr('disabled','disabled');
						}
					})
				})
				
				$('.clearTime').click(function(){
					if($('input[name="startTime"]').val()=='' && $('input[name="endTime"]').val()==''){
						$('button.btn-save').removeAttr('disabled','disabled');
					}
				})
				
				
			})
       </script>
        
       <script type="text/javascript">
       Date.prototype.format = function(fmt) { 
    	     var o = { 
    	    		"M+" : this.getMonth()+1,                 //月份 
   	    	        "d+" : this.getDate(),                    //日 
   	    	        "h+" : this.getHours()-8,                 //小时 
   	    	        "m+" : this.getMinutes(),                 //分 
   	    	        "s+" : this.getSeconds(),                 //秒 
    	    };
    	    if(/(y+)/.test(fmt)) {
    	            fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
    	    }
    	     for(var k in o) {
    	        if(new RegExp("("+ k +")").test(fmt)){
    	             fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
    	         }
    	     }
    	    return fmt; 
    	}
       </script>
        
        
 </body>

</html>
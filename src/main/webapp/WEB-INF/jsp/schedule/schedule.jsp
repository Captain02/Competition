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
	<jsp:include page="iniCssHref.jsp"></jsp:include>
	<link rel="stylesheet" href="${APP_PATH}/static/css/font-awesome.css">
	
	<link rel="stylesheet" href="${APP_PATH}/static/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css">
	<script src="${APP_PATH}/static/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
	<script src="${APP_PATH}/static/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
	
    <link rel="stylesheet" href="${APP_PATH}/static/fullcalendar/fullcalendar.min.css" />
    <script src="${APP_PATH}/static/fullcalendar/lib/moment.min.js"></script>
    <script src="${APP_PATH}/static/fullcalendar/fullcalendar.min.js"></script>
    
	<script type="text/javascript">
	$.ajax({
		url:"${APP_PATH}/admin/schedule/scheduleds",
		data:'',
		type:"GET",
		success:function(result){
			console.log(result);
			$.each(result.extend.schedules,function (index, term) {
				console.log(term);
                $("#calendar").fullCalendar('renderEvent', term, true);
            });
		}
	})
	
	function save(){
		$.ajax({
				url:"${APP_PATH}/admin/schedule/save",
				data:$('#scheduleForm').serialize(),
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
                <!-- 页面模版，按需更改 -->
                <div class="wrapper">


                   
					  <div class="row">
					  	<div class="col-md-3">
					  		<div class="panel">
					  			<header class="panel-heading">日程设置</header>
					  			<div class="panel-body">
					  			
					  		<form id="scheduleForm" action="">
					  		
					  			<div class="form-group">
				                  <label>日程名称</label>
				                  <input class="form-control" name="title" placeholder="日程名称" type="text">
               					</div>
					  			
					  			
								<div class="form-group">
									<label for="">开始日期</label>
									<div class="input-group date form_datetime">
									    <input name="startTime" class="form-control" type="text" value="" readonly>
									    <span class="input-group-addon"><i class="fa fa-times"></i></span>
									    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
									</div>
								</div>
								
								<div class="form-group">
									<label for="">结束日期</label>
									<div class="input-group date form_datetime">
									    <input name="endTime" class="form-control" type="text" value="" readonly>
									    <span class="input-group-addon"><i class="fa fa-times"></i></span>
									    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
									</div>
								</div>
								
								<input type="hidden"  name="id"/>
								<button class="btn btn-success" type="button" onclick="save()">提交</button>
								
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
				$('#calendar').fullCalendar({
					header: {
						left: 'month,agendaWeek,agendaDay',
						center: 'title',
						right: 'today, prev, next'
					},
					monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
					monthNamesShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
					dayNames: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"],
					dayNamesShort: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"],
					buttonText: {
					    today: '今天',
					    month: '月',
					    week: '周',
					    day: '日'
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
						alert(dayDelta);
						alert(minuteDelta);
						//updateDay(days,event.start,event.end,event.id);
					},
					
					//点击查看日程详情
					eventClick:function(event){
						$('input[name="id"]').val(event.id);
						$('input[name="title"]').val(event.title);
						$('input[name="startTime"]').val(new Date(event.start).format('yyyy-MM-dd hh:mm:ss'));
						$('input[name="endTime"]').val(new Date(event.end).format('yyyy-MM-dd hh:mm:ss'));
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
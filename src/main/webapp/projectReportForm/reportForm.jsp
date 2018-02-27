<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>项目管理</title>

<%
   pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<jsp:include page="iniCssHref.jsp"></jsp:include>
<link rel="stylesheet" href="${APP_PATH}/static/css/font-awesome.css">
<script src="${APP_PATH}/static/js/echarts.js"></script>
<style>
	.pie-chart{width: 620px;height:400px;}
	@media screen and (max-width: 768px) {
		.pie-chart{width: 384px;height:430px;}
	}
</style>
</head>
    <body class="bg-common">

        <section>

            <!-- 页面模版，每页左侧区域固定不变 -->
             <jsp:include page="iniLeftMenu.jsp"></jsp:include>


            <div class="main-content">

                <!-- 页面模版，每页主体部分头部按需更改 -->
                <div class="content-head content-head-section">

                    <a href="" class="toggle-btn">
                        <span class="glyphicon glyphicon-th-list"></span>
                    </a>

                    <form action="${APP_PATH}/admin/demand/list" class="serach-form" method="get">

                        
						<select name="state" class="form-control">
				          <option value="需求状态">需求状态</option>
				          <option value="草稿">草稿</option>
				          <option value="激活">激活</option>
				          <option value="已变更">已变更</option>
				          <option value="待关闭">待关闭</option>
				          <option value="已关闭">已关闭</option>
       					</select>
                        <input type="text" placeholder="输入项目名称" value="${demandName == '需求名称'?null:demandName}" class="form-control" name="demandName">

                        <button type="submit" class="btn btn-primary">搜索</button>


                        <div class="clearfix"></div>
                    </form>


                     <jsp:include page="iniUserInfo.jsp"></jsp:include>

                    <div class="clearfix"></div>

                </div>

                <!-- 页面模版，按需更改 -->
                <div class="wrapper">

                    <div class="om-header">
						<div class="om-header-left">
							<h3>
								<span class="om-title">项目管理</span>
								<jsp:include page="projectLeftManagement.jsp"></jsp:include>
							</h3>
						</div>
                         
                        <div class="om-header-right">
                            <button id="addButton" type="button" class="btn btn-success btn-sm" onclick="window.location.href='${APP_PATH}/admin/demand/addPage'">
                                <i>+</i>新需求
                            </button>
                        </div>


                        <div class="clearfix"></div>
                    </div>

                    
                        <div class="row">
                            <div class="col-sm-6">

                                <section class="panel">
                                	<header class="panel-heading">需求 / 总数：${pageInfo.total}</header>
                                	<div class="panel-body">
                                		<div id="chartTeam" class="pie-chart"></div>
                                	</div>
                                </section>

                               
                            </div>

                        </div>

                    </div>
                </div>

        </section>
        
       
    </body>
<script type="text/javascript">
option = { 
		title:{text: '项目团队人员', subtext: '职称比例',x:'center'}, 
		tooltip:{trigger: 'item',formatter: "{a} <br/>{b} : {c} ({d}%)"},
	    legend:{orient: 'vertical',left: 'left',
	    	data: [ "部门经理","总经理"]},
	    series : [
	        {
	            name: '职称比例',
	            type: 'pie',
	            radius : '55%',
	            center: ['50%', '60%'],
	            data:[
					
					{value: 1 , name:"部门经理"},
					{value: 1 , name:"总经理"}
					
	            ],
	            itemStyle: {
	                emphasis: {
	                    shadowBlur: 10,
	                    shadowOffsetX: 0,
	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
	                }
	            }
	        }
	    ]
};
var chartTeam = echarts.init(document.getElementById('chartTeam'));
chartTeam.setOption(option);
</script>
</html>
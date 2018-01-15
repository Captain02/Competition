<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>权限的编辑</title>

        <%
	       pageContext.setAttribute("APP_PATH", request.getContextPath());
        %>

        <jsp:include page="iniCssHref.jsp"></jsp:include>
    <style>
        .resource-name li {
            float: left;
            width: 130px;
        }

        .form-group label {
            font-weight: normal;
            font-size: 14px;
            cursor: pointer;
        }

        .resource-list h4 {
            cursor: pointer;
            margin-bottom: 15px;
        }
        .resource-name{
           padding-left:40px;
        }
    </style>
    
<script type="text/javascript">
$(function(){
	//定义一个数组来存放用户拥有的权限的id
	var resourceArray = new Array();
	//遍历隐藏域中存放的用户拥有的权限，得到每一个权限的id，放进数组
	$('.hasResourceId').each(function(){
		
		var hashasResourceId = $(this);
		resourceArray.push(hashasResourceId.val());
		
		
	})
	

	//遍历从数据库中得到的所有权限，得到每个权限的id
	$('.resourceId').each(function(){
		
		var resourceId = $(this);
		if( $.inArray(resourceId.val(),resourceArray) >= 0 ){
			resourceId.attr('checked','checked');
		}
	});
	
	//为复选框设置点击事件
	$(".resourceId").on("click",function(){
		var c = 0;
		var ifChecked = this.checked;
		
		var roleId = "${roleId}";
        var resourceId = $(this).val();
        
		if (ifChecked) {
			c = 1;
		}
		
		 $.ajax({
			url:"${APP_PATH}/admin/role/updateResource",
			data:"roleId="+roleId+"&resourceId="+resourceId+"&check="+c,
			type:"GET",
			success:function(result){
				if (result.code==200) {
					alert("修改失败");
				}
			}
		}) 
		
		
	})
	
})
</script>

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


                <jsp:include page="iniUserInfo.jsp"></jsp:include>

                <div class="clearfix"></div>

            </div>

            <!-- 页面模版，按需更改 -->
            <div class="wrapper">

                <div class="row">
                    <div class="om-header">
                        <jsp:include page="iniOrganizationManagementHref.jsp"></jsp:include>

                        <div class="clearfix"></div>
                    </div>

                    <div class="om-wrapper">
                        <div class="row">
                            <div class="col-sm-12">

                                <header class="om-wrapper-header">权限的编辑</header>

                                <div class="om-wrpper-body">

                                    <form action="" id="resource-form" name="resource-form" class="resource-form">
                                    
                                       <%-- 将从数据库查询出来的角色所绑定的权限放在这个隐藏域里面--%>
                                       <c:forEach items="${roleHasResourceList}" var="roleHasResourceList">
	                                       <input type="hidden" class="hasResourceId" value="${roleHasResourceList.id }"/>
                                       </c:forEach>

                                        <ul id="resource-list" name="resource-list" class="list-unstyled resource-list">

                                            <!-- 项目管理类权限列表 -->
                                            <li>

                                                <h4>
                                                    权限编辑
                                                    <input name="checkresource" type="checkbox">
                                                </h4>

                                                <ul id="" name="" class="resource-name">
                                                    <!-- 在此处遍历生成权限的名称 -->
                                                    <c:forEach items="${resources}" var="resources">
	                                                     <li>
	                                                        <div class="form-group">
	                                                            <label for="" class="checkbox-inline ">
	                                                                <input type="checkbox" name="id" class="resourceId" value="${resources.id}"> ${resources.name }
	                                                            </label>
	                                                        </div>
	                                                    </li>
                                                     </c:forEach>
                                                    <div class="clearfix"></div>
                                                    
                                                </ul>

                                            </li>

                                       
                                        
                                        </ul>

                                      

                                    </form>
                                    
                                        <!-- 保存按钮 -->
                                        <div class="form-group">
                                            <div class="col-lg-10">
                                                <input name="id" value="0" type="hidden">
                                                <button type="submit" class="btn btn-success">保 存</button>
                                            </div>
                                        </div>
                                        
                                    <div class="clearfix"></div>
                                    
                                        
                                        

                                </div>

                            </div>

                        </div>



                    </div>

                </div>

            </div>
        </div>
    </section>
</body>

</html>
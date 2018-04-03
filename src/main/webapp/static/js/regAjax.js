//校验用的方法
//1、判定是否为空值
function ifNull(eleValue) {
    return (eleValue == '');

}
//2、判定是否有中文或特殊字符
function ifSpecialStr(eleValue) {
    var reg = /^[a-zA-Z0-9_]{0,}$/;
    return (reg.test(eleValue));
}
//3、判定只能是数字
function ifNum(eleValue) {
    var reg = /[\d]/g;
    return (reg.test(eleValue));
}

//用来显示验证的结果
function show_validate_msg(ele, status, msg) {
    $(ele).parent().removeClass("has-success has-error");
    $(ele).next("span").text("").addClass("showMessage").removeClass("successMessage errorMesage");
    if ("success" == status) {
        $(ele).parent().addClass("has-success");
        $(ele).next("span").append('<i class="glyphicon glyphicon-ok-sign"></i>' + msg).addClass("successMessage");
    } else if ("error" == status) {
        $(ele).parent().addClass("has-error");
        $(ele).next("span").append('<i class="glyphicon glyphicon-remove-sign"></i>' + msg).addClass("errorMesage");
    }
}

//判断是否还存在错误信息
function ifErrorMessage() {
    var showMessage = $(".showMessage");
    showMessage.each(function () {
        if ($(this).hasClass("errorMesage")) {
            $(".save-button").attr("ajax-va", "error");
        }else{
        	$(".save-button").attr("ajax-va", "success");
        }
    });
   
}

$(function () {
	//通用的不为空的校验
	$('.notNull').each(function(){
		$(this).change(function(){
			var value = $(this).val();
			ifNull(value)?show_validate_msg($(this), "error", "请正确填写相关内容"):show_validate_msg($(this), "success", "正确");
		})
	})
	
	//通用的只能是数字的校验
	$('.onlyNumber').each(function(){
		$(this).blur(function(){
			var value = $(this).val();
			ifNum(value)?show_validate_msg($(this), "success", "正确"):show_validate_msg($(this), "error", "只能填写数字");
		})
	})
	
    //密码的前端校验
    $('#password').change(function () {
        var password = $("#password").val();
        if (ifNull(password)) {
            show_validate_msg("#password", "error", "密码不为空");
        }
        else if (!ifSpecialStr(password)) {
            show_validate_msg("#password", "error", "密码不能有中文");
        } else {
            show_validate_msg("#password", "success", "密码可用");
        }        
    });
    
    //姓名的前端校验
    $('#name').change(function () {
        var name = $("#name").val();
        ifNull(name)?show_validate_msg("#name", "error", "名称不能为空"):show_validate_msg("#name", "success", "名称可用");
    });
    
    //别名的前端校验
    $('#nameAlias').change(function(){
    	var nameAlias = $('#nameAlias').val();
    	ifNull(nameAlias)?show_validate_msg("#nameAlias", "error", "别名不能为空"):show_validate_msg("#nameAlias", "success", "别名可用");
    })
    
    //手机的前端校验
    $('#phone').change(function () {
        var phone = $("#phone").val();
        if (ifNull(phone)) {
            show_validate_msg("#phone", "error", "手机不能为空");
        }
        else if (!ifNum(phone)) {
            show_validate_msg("#phone", "error", "手机号码只能为数字");

        } else {
            show_validate_msg("#phone", "success", "手机号可用");
        }
    });
    
    //部门名的前端校验
    $('#departmentname').change(function () {
        var departname = $('#departmentname').val();
        if (ifNull(departname)) {
            show_validate_msg("#departmentname", "error", "部门名不能为空");
        }else{
        	show_validate_msg("#departmentname", "success", "部门名可用");
        }
    });

    //部门地址的前端校验
    $('#departmentaddress').change(function () {
        var departmentaddress = $('#departmentaddress').val();
        if (ifNull(departmentaddress)) {
            show_validate_msg("#departmentaddress", "error", "部门地址不能为空");
        }else{
        	show_validate_msg("#departmentaddress", "success", "部门地址可用");
        }
    });
    
    //职称名的前端校验
    $("#rolename").change(function () {
    	var rolename = $("#rolename").val();
        if (ifNull(rolename)) {
            show_validate_msg("#rolename", "error", "职称名称不能为空");
        }else{
        	show_validate_msg("#rolename", "success", "职称名称可用");
        }
    });
    
    //权限栏目的前端校验
    $("#column").change(function(){
    	var colum = $("#column").val();
    	if (ifNull(colum)) {
            show_validate_msg("#column", "error", "权限栏目不能为空");
        }else{
        	show_validate_msg("#column", "success", "权限栏目可用");
        }
    	
    });
    
  //权限名称的前端校验
    $("#resource-name").change(function(){
    	var resourceName = $("#resource-name").val();
    	if (ifNull(resourceName)) {
            show_validate_msg("#resource-name", "error", "权限名称不能为空");
        }else{
        	show_validate_msg("#resource-name", "success", "权限名称可用");
        }
    	
    });
    
    //选择菜单的前端校验
    $('.select-menu').change(function(){
    	var selectValue = $(this).val();
    	ifNull(selectValue)?show_validate_msg($(this), "error", "没有选择任何内容"):show_validate_msg($(this), "success", "正确");
    })
    
    
    //批量添加的校驗
    $('.table-addBatch select.select-menu').each(function(){
    	$(this).change(function(){
    		var selectValue = $(this).val();
    		ifNull(selectValue)?show_validate_msg($(this), "error", "没有选择任何内容"):show_validate_msg($(this), "success", "正确");
    	})
    })
    $('.table-addBatch input#name').each(function(){
    	$(this).change(function(){
    		var name = $(this).val();
    		ifNull(name)?show_validate_msg($(this), "error", "请正确填写相关内容"):show_validate_msg($(this), "success", "正确");
    	})
    })
    
    //权限描述的前端校验
    $("#resource-desc").change(function(){
    	var resourceDesc = $("#resource-desc").val();
    	if (ifNull(resourceDesc)) {
            show_validate_msg("#resource-desc", "error", "权限描述不能为空");
        }else{
        	show_validate_msg("#resource-desc", "success", "权限描述可用");
        }
    	
    });
    
    //权限拦截链接的前端校验
    $("#resource-href").change(function(){
    	var resourceHref = $("#resource-href").val();
    	if (ifNull(resourceHref)) {
            show_validate_msg("#resource-href", "error", "权限拦截链接不能为空");
        }else{
        	show_validate_msg("#resource-href", "success", "权限拦截可用");
        }
    	
    });
    
    //两次密码是否一致的校验
    $("#newPassword").change(function(){
    	var newPassword = $("#newPassword").val();
    	if (ifNull(newPassword)) {
            show_validate_msg("#newPassword", "error", "新密码不能为空");
        }
    	else if(!ifSpecialStr(newPassword)){
    		show_validate_msg("#newPassword", "error", "新密码不能有中文或特殊字符");
    	}
    	else{
        	show_validate_msg("#newPassword", "success", "格式正确");
        }
    	
    });
    $("#truePassword").change(function(){
    	var newPassword = $("#newPassword").val();
    	var truePassword = $("#truePassword").val();
    	
    	if(newPassword !== truePassword){
    		show_validate_msg("#truePassword", "error", "两次密码不一致！请重新输入");
    	}else{
        	show_validate_msg("#truePassword", "success", "密码一致！");
        }
    	
    });
    

})
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
    //清除当前元素效果
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

    //密码的前端校验
    $('#password').change(function () {

        // 获得用户填写的用户名
        var password = $("#password").val();
        //密码不为空
        if (ifNull(password)) {
            show_validate_msg("#password", "error", "密码不为空");
        }
        //密码不能有中文
        else if (!ifSpecialStr(password)) {
            show_validate_msg("#password", "error", "密码不能有中文");
        } else {
            show_validate_msg("#password", "success", "密码可用");
        }        
    });
    //姓名的前端校验
    $('#name').change(function () {

        // 获得用户填写的姓名
        var name = $("#name").val();
        //密码不为空
        if (ifNull(name)) {
            show_validate_msg("#name", "error", "姓名不能为空");

        } else {
            show_validate_msg("#name", "success", "用户名可用");
        }
    });
    //手机的前端校验
    $('#phone').change(function () {

        // 获得用户填写的手机号码
        var phone = $("#phone").val();
        //手机号码不为空
        if (ifNull(phone)) {
            show_validate_msg("#phone", "error", "手机不能为空");
        }
        //手机号码只能为数字
        else if (!ifNum(phone)) {
            show_validate_msg("#phone", "error", "手机号码只能为数字");

        } else {
            show_validate_msg("#phone", "success", "手机号可用");
        }
    });
    //部门名的前端校验
    $('#departmentname').change(function () {
        //获取用户填写的部门名
        var departname = $('#departmentname').val();
        //部门名不为空
        if (ifNull(departname)) {
            show_validate_msg("#departmentname", "error", "部门名不能为空");
        }else{
        	show_validate_msg("#departmentname", "success", "部门名可用");
        }
    });

    //部门地址的前端校验
    $('#departmentaddress').change(function () {
        //获取用户填写的部门名
        var departmentaddress = $('#departmentaddress').val();
        //部门名不为空
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
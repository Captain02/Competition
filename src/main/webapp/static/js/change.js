// <reference path="jquery.min.js" />
/**
 * 
 */
// 动画脚本

// No.1 隐藏侧边栏动画
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

})
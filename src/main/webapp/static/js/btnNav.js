// 我的审批页的按钮导航切换效果
$(function () {
    var locationHref = location.href.split('herfPage=');
    var thisPagelocationHref = locationHref[1];
    var toolsA = $('.tools > a');

    if (thisPagelocationHref == undefined) {
        $(toolsA[0]).addClass('active');
    }

    $(toolsA[thisPagelocationHref]).addClass('active');
    $(toolsA[thisPagelocationHref]).siblings().removeClass('active');
});
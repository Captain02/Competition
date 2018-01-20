// <reference path="jquery.min.js" />

/*
    文件说明：所选审批流程的不同，动态的显示可添加的审批人数
 */
//

function activeShowProcessPerson(selectProcessKeyName, result) {
    $('.addprocessPerson').removeClass('noProcessPerson');
    $('.processTips').removeClass('noProcessPerson');

    $('.processName').html(selectProcessKeyName);
    $('.processPersonNum').html(result.extend.num);

    $('.processPersonNum').attr('value', result.extend.num);
}
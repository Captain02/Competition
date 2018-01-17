// <reference path="jquery.min.js" />
/**
 * 
 */
//控制按钮的显示状态
function ShowEle(ele1, status1, ele2, status2, ele3, status3) {
    switch (status1) {
        case 'hide':
            $(ele1).hide();
            break;
        case 'show':
            $(ele1).show();
            break;

    }
    switch (status2) {
        case 'hide':
            $(ele2).hide();
            break;
        case 'show':
            $(ele2).show();
            break;

    }
    switch (status3) {
        case 'hide':
            $(ele3).hide();
            break;
        case 'show':
            $(ele3).show();
            break;

    }
}
//控制模态框的显示内容
function ShowTips(textArea1, text1, textArea2, text2) {
    $(textArea1).html(text1);
    $(textArea2).html(text2);

}

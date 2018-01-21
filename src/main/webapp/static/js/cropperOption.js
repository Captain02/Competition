// <reference path="jquery.min.js" />
// <reference path="cropper.min.js" />
/**
 * 文件说明：初始化cropper裁剪图像插件的配置
 */
$(function () {
    var image = document.querySelector('#image');
    var cropper = new Cropper(image, {
        dragmode: 'move',
        aspectRatio: 4 / 3,
        movable: true,
        zoomable: false,
        rotatable: false,
        scalable: false
    });
})
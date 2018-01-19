$(function () {
    //获得所有的审阅人标签
    var lis = $('.person-List > li');

    //点击添加按钮显示模态框
    $('.btn-person').click(function () {
        $('#myModal').modal('show');
        $('.add-error-ms').html('');
    });

    //给每个审阅人标签绑定单击事件
    for (var i = 0; i < lis.length; i++) {

        //鼠标移入的效果
        $(lis[i]).mouseover(function () {
            $(this).children('a').css('color', '#000');
        });
        $(lis[i]).mouseout(function () {
            $(this).children('a').css('color', '#65CEA7');
        });

        var nameArea = $('.person-name-area');
        var personNum = $('.person-name-area > a');

        //点击添加审批人
        $(lis[i]).click(function () {
            var aText = $(this).children('a').html();
            var aPersonName = $('.serach-person-name');
            var acPersonNum = parseInt($('.processPersonNum').attr('value'));
            if (personNum.length > acPersonNum-1) {
                $('.add-error-ms').html('最多只能添加' + acPersonNum + '位审批人!');
                $('#myModal').modal('hide');
                return false;
            }

            nameArea.append(' <a> ' + '<span class="serach-person-name addPerson">' + aText + '</span>' + '<span class="spare-dot">..........</span>' + '</a>');

            $('#myModal').modal('hide');

            personNum.length++;
        });
    }

    $(".person-name-area").on("click", "a", function () {
        $(this).remove();
        personNum.length--;
    });

});
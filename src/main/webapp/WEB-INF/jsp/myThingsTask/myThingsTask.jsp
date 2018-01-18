<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>


<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>我的任务</title>

   <%
	 pageContext.setAttribute("APP_PATH", request.getContextPath());
   %>
   <jsp:include page="iniCssHref.jsp"></jsp:include>

    <script src="static/js/ctrolButton.js"></script>
    <script type="text/javascript">
        $(function () {
            ShowEle('.yes', 'hide');
            $('.btn-assign').click(function () {
                $('#myModal').modal('show');
                var btnAssignPreviousSbiling = $(this).prev().attr('value');
                console.log(btnAssignPreviousSbiling);
                $('#assignHolidayProcessinstanceid').val(btnAssignPreviousSbiling);
            });

            var locationHref = location.href.split('herfPage=');
            var thisPagelocationHref = locationHref[1];
            var toolsA = $('.tools > a');
            $(toolsA[thisPagelocationHref]).addClass('active');
            $(toolsA[thisPagelocationHref]).siblings().removeClass('active');
        });

        function assignTask(object) {
            var assignHolidayProcessinstanceid = $(
                "#assignHolidayProcessinstanceid").val();
            var assignUsername = $(object).prev().val();
            $.ajax({
                url: "/OA02/admin/myHolidayTask/assignTask",
                type: "POST",
                data: "assignHolidayProcessinstanceid=" +
                    assignHolidayProcessinstanceid + "&assignUsername=" +
                    assignUsername,
                success: function (result) {
                    if (result.code == 100) {
                        $('#myModal').modal('show');
                        ShowTips('.modal-title', '执行结果', '.modal-body',
                            '<b style = "color:#5cb85c;">指派成功</b>');
                        ShowEle('.yes', 'show');
                    }
                }
            })
        }
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

                <form action="/OA02/admin/myHolidayTask/myHolidayTask" class="serach-form" method="get">

                    <select class="form-control" name="type">
                        <option>类型</option>
                        <option>事假</option>
                        <option>病假</option>
                        <option>年假</option>
                        <option>调休</option>
                        <option>婚假</option>
                        <option>产假</option>
                        <option>陪产假</option>
                        <option>路途假</option>
                        <option>其它</option>
                    </select>
                    <select class="form-control" name="state">
                        <option>状态</option>
                        <option>通过</option>
                        <option>未通过</option>
                        <option>审核中</option>
                    </select>
                    <input type="hidden" value="0" name="herfPage" />
                    <button type="submit" class="btn btn-primary">搜索</button>
                    <div class="clearfix"></div>
                </form>



                <!-- 此处显示登录所用的用户名以及职位，用include标签包含进来 -->
                <div class="content-head-right">
                    <ul class="login-info">
                        <li>
                            <a href="">
                                <i class="glyphicon glyphicon-comment"></i>
                            </a>
                        </li>
                        <li>
                            <span>欢迎！</span>
                            <a href="#" data-toggle="dropdown">
                                超级管理员
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                <li>
                                    <a href="#">个人主页</a>
                                </li>
                                <li role="separator" class="divider"></li>
                                <li>
                                    <a href="/OA02/admin/user/changePassword/140">修改密码</a>
                                </li>
                                <li role="separator" class="divider"></li>
                                <li>
                                    <a href="/OA02/logout">退出</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>

                <div class="clearfix"></div>

            </div>

            <!-- 页面模版，按需更改 -->
            <div class="wrapper">
                <div class="om-header" style="margin-bottom: 15px;">
                  <jsp:include page="iniMyApprovalManagement.jsp"></jsp:include>
                    <div class="clearfix "></div>
                </div>

                <div class="om-wrapper">
                    <div class="row">
                        <div class="col-sm-12">

                            <header class="om-wrapper-header">
                                任务 / 总数：
                                <span class="tools pull-right">
                                    <a href="/OA02/admin/myHolidayTask/myHolidayTask?herfPage=0" class="btn btn-default active">指派给我</a>
                                    <a href="/OA02/admin/myHolidayTask/myHolidayTask?herfPage=1" class="btn btn-default">由我创建</a>
                                    <a href="/OA02/admin/myHolidayTask/myHolidayTask?herfPage=2" class="btn btn-default">由我解决</a>
                                    <a href="/OA02/admin/myHolidayTask/myHolidayTask?herfPage=3" class="btn btn-default">由我完成</a>
                                </span>
                            </header>

                            <div class="om-wrpper-body">
                                <form action="" id="user-list" class="user-list">
                                    <table class="table table-bordered table-striped">

                                        <thead>
                                            <tr>
                                                <th>用途</th>
                                                <th>物品名称</th>
                                                <th>申请时间</th>
                                                <th>状态</th>
                                                <th>操作</th>
                                            </tr>
                                        </thead>

                                        <tbody>

                                            <tr>
                                                <td>工作</td>
                                                <td>打印机</td>
                                                <td>2017-1-1</td>
                                                <td>审核通过</td>
                                                <td>
                                                    <!-- this hidden -->

                                                    <input id="holidayProcessinstanceid" value="5" type="hidden">
                                                    <a class="btn btn-warning btn-xs btn-assign" title="指派">
                                                        <i class="glyphicon glyphicon-hand-right"></i>
                                                    </a>
                                                    <a href="/OA02/admin/myHolidayTask/examinationPage/15/1" class="btn btn-success btn-info btn-xs" title="完成">
                                                        <i class="glyphicon glyphicon-ok-sign "></i>
                                                    </a>

                                                    <a href="/OA02/admin/holiday/holidayNote/15" class="btn btn-danger btn-xs" title="查看">
                                                        <i class="glyphicon glyphicon-eye-open "></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </tbody>

                                    </table>
                                </form>
                            </div>

                        </div>

                    </div>

                    <!-- 分页 -->
                    <div class="page-area ">
                        <div class="container page-possiton ">

                            <nav aria-label="Page navigation">
                                <ul class="pagination pagination-control">
                                    <li>
                                        <a href="/OA02/admin/myHolidayTask/myHolidayTask?pn=1&type=类型&state=状态&herfPage=0">首页</a>
                                    </li>

                                    <li class="active">
                                        <a href="#">1</a>
                                    </li>
                                    <li>
                                        <a href="/OA02/admin/myHolidayTask/myHolidayTask?pn=2&type=类型&state=状态&herfPage=0">2</a>
                                    </li>

                                    <li>
                                        <a href="/OA02/admin/myHolidayTask/myHolidayTask?pn=2&type=类型&state=状态&herfPage=0" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="/OA02/admin/myHolidayTask/myHolidayTask?pn=2&type=类型&state=状态&herfPage=0" aria-label="Next">
                                            <span aria-hidden="true">末页</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </section>

    <!-- 模态框  指派-->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">任务指派给？</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-bordered table-hover text-center">
                        <thead>
                            <tr>
                                <th>用户名</th>
                                <th>姓名</th>
                                <th>部门</th>
                                <th>职位</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>

                            <tr>
                                <td>asdasd</td>
                                <td>asdasdasd</td>
                                <td style="width:20%;">财务部</td>
                                <td style="width:20%;">admin</td>
                                <td>
                                    <!-- hidden 1 -->
                                    <input id="assignHolidayProcessinstanceid" type="hidden" value="">
                                    <input id="assignUsername" type="hidden" value="asdasd">
                                    <button class="btn btn-defalut btn-success btn-sm" onclick="assignTask(this)">
                                        <span class="glyphicon glyphicon-hand-right" style="margin-right: 10px;"></span>指派
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="modal-footer">
                    <form action="/OA02/admin/myHolidayTask/myHolidayTask" method="get">
                        <input type="hidden" value="状态" name="state">
                        <input type="hidden" value="1" name="pn">
                        <input type="hidden" value="类型" name="type">
                        <input type="hidden" value="0" name="herfPage">
                        <button type="submit" class="btn btn-success yes">确认</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
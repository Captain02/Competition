<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>物品管理</title>

    <jsp:include page="iniCssHref.jsp"></jsp:include>

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

                <form action="/OA02/admin/holiday/list" class="serach-form" method="get">

                    <input class="form-control" type="text" placeholder="用途" value="">

                    <select class="form-control" name="result">
                        <option>结果</option>
                        <option>同意</option>
                        <option>拒绝</option>
                    </select>
                    <button type="submit" class="btn btn-primary">搜索</button>

                    <div class="clearfix"></div>
                </form>


                <!-- 此处显示登录所用的用户名以及职位，用include标签包含进来 -->
               <jsp:include page="iniUserInfo.jsp"></jsp:include>

                <div class="clearfix"></div>

            </div>

            <!-- 页面模版，按需更改 -->
            <div class="wrapper">

                <div class="om-header">

                    <div class="om-header-left">
                        <h3>
                            <span class="om-title">审批管理</span>
                            <span class="om-list">
                                <a href="/OA02/admin/holiday/list">请假</a>
                                <a href="/OA02/admin/reimbursement/list">报销</a>
                                <a href="/OA02/admin/role/list">物品</a>
                            </span>
                        </h3>
                    </div>

                    <div class="om-header-right ">
                        <button id="addButton" onclick="window.location.href='/OA02/admin/holiday/add'" type="button" class="btn btn-success btn-sm">
                            <i>+</i>我要领用
                        </button>
                    </div>
                    <div class="clearfix "></div>
                </div>

                <div class="om-wrapper ">
                    <div class="row ">
                        <div class="col-sm-12 ">

                            <header class="om-wrapper-header ">领用 / 总数：</header>

                            <div class="om-wrpper-body ">
                                <table class="table table-hover holiday-table">
                                    <thead>
                                        <tr>
                                            <th>用途</th>
                                            <th>物品名称</th>
                                            <th>领取时间</th>
                                            <th>状态</th>
                                            <th>操作</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <tr>
                                            <td>办公用品</td>
                                            <td>打印机</td>
                                            <td>2017-1-1</td>
                                            <td>
                                                <span class="label label-success">正常</span>
                                            </td>
                                            <td>
                                                <div class="btn-group">
                                                    <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                                        操作
                                                        <span class="caret"></span>
                                                    </button>
                                                    <ul class="dropdown-menu">
                                                        <li>
                                                            <a href="">查看物品</a>
                                                        </li>
                                                        <li role="separator" class="divider"></li>
                                                        <li>
                                                            <a href="">查看进度</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                        </div>

                    </div>
                    <!-- 分页 -->
                    <div class="page-area ">
                        <div class="container page-possiton ">

                            <nav aria-label="Page navigation">
                                <ul class="pagination pagination-control">
                                    <li>
                                        <a href="/OA02/admin/holiday/list?pn=1&type=类型&state=状态">首页</a>
                                    </li>

                                    <li class="active">
                                        <a href="#">1</a>
                                    </li>

                                    <li>
                                        <a href="/OA02/admin/holiday/list?pn=2&type=类型&state=状态">2</a>
                                    </li>

                                    <li>
                                        <a href="/OA02/admin/holiday/list?pn=3&type=类型&state=状态">3</a>
                                    </li>

                                    <li>
                                        <a href="/OA02/admin/holiday/list?pn=2&type=类型&state=状态" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>

                                    <li>
                                        <a href="/OA02/admin/holiday/list?pn=3&type=类型&state=状态" aria-label="Next">
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



</body>

</html>
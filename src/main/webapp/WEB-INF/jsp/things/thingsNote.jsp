<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>领用单</title>

    <%
	      pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
<jsp:include page="iniCssHref.jsp"></jsp:include>
</head>



<body class="bg-common stickey-menu">

    <section>

        <!-- 页面模版，每页左侧区域固定不变 -->
        <jsp:include page="iniLeftMenu.jsp"></jsp:include>


        <div class="main-content">

            <!-- 页面模版，每页主体部分头部按需更改 -->
            <div class="content-head content-head-section">

                <a href="" class="toggle-btn">
                    <span class="glyphicon glyphicon-th-list"></span>
                </a>

                <form action="" class="serach-form" method="get">

                    <select class="form-control">
                        <option>状态</option>
                        <option>占个位置</option>
                        <option>占个位置</option>
                        <option>占个位置</option>
                        <option>占个位置</option>
                    </select>

                    <input type="text" placeholder="请输入名称" value="" class="form-control" name="name">

                    <button type="submit" class="btn btn-primary">搜索</button>


                    <div class="clearfix"></div>
                </form>


                <jsp:include page="iniUserInfo.jsp"></jsp:include>

                <div class="clearfix"></div>

            </div>

            <!-- 页面模版，按需更改 -->
            <div class="wrapper">

                <div class="row">
                    <div class="col-md-8">
                        <div class="blog">
                            <div class="single-blog">
                                <div class="panel">
                                    <div class="panel-body">

                                        <h1 class="text-center">
                                            <a href="#">领用单</a>
                                            <button onclick=" doPrint();" class="pull-right btn">打 印</button>
                                        </h1>
                                        <p class="text-center auth-row"> By
                                            <a href="">${userThingsByThingsId.name}</a> | ${userThingsByThingsId.date}</p>

                                        <!--startprint-->
                                        <div id="print">
                                            <table class="table table-bordered" border="1">
                                                <tbody>
                                                    <tr class="hide">
                                                        <th colspan="6" class="text-center">领用单</th>
                                                    </tr>
                                                    <tr>
                                                        <td width="72">姓名</td>
                                                        <td width="62">${userThingsByThingsId.name}</td>
                                                        <td width="70">部门</td>
                                                        <td width="77">${userThingsByThingsId.department}</td>
                                                        <td width="80">职位</td>
                                                        <td width="93">${userThingsByThingsId.role}</td>
                                                    </tr>
                                                    <tr>
                                                        <td>日期</td>
                                                        <td colspan="5">${userThingsByThingsId.date}</td>
                                                    </tr>
                                                    <tr>
                                                        <td>物品用途</td>
                                                        <td colspan="5">${userThingsByThingsId.purpose}</td>
                                                    </tr>
                                                    <tr>
                                                        <td>物品详情</td>
                                                        <td colspan="5">${userThingsByThingsId.details}</td>
                                                    </tr>
                                                    <tr>
                                                        <td>物品名称</td>
                                                        <td colspan="5">${userThingsByThingsId.thingsName}</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            
                                            <span style="float: left; padding:8px 20px 0 0;">${userThingsByThingsId.filename!=null?userThingsByThingsId.filename:'无附件'}</span>
                                        </div>
 
                                        <!--endprint-->
                                        <button type="button" class="btn btn-default" onclick="window.location.href='${APP_PATH}/admin/things/down/${userThingsByThingsId.id}'">
                                            <span class="glyphicon glyphicon-arrow-down"></span>下载附件
                                        </button>
                                    </div>
                                </div>
                                <div class="panel">
                                    <div class="panel-body">
                                        <h1 class="text-center cmnt-head">当前审批人</h1>
                                        <p class="text-center fade-txt">${approver!=null?approver:'该任务已经完成'}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>



        </div>



    </section>


    <!-- 打印假条 -->
    <script>
        function doPrint() {
            bdhtml = window.document.body.innerHTML;
            sprnstr = "<!--startprint-->";
            eprnstr = "<!--endprint-->";
            prnhtml = bdhtml.substr(bdhtml.indexOf(sprnstr) + 17);
            prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
            window.document.body.innerHTML = '<div style="color: #fff; width:50%; margin:0 auto;">' +
                '<h2 class="text-center">请假条</h2>' +
                prnhtml +
                '</div>';
            window.print();
            window.document.body.innerHTML = bdhtml;
        }
    </script>
</body>

</html>
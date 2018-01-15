<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>

    <head>
        <%
            pageContext.setAttribute("APP_PATH", request.getContextPath());
          %>
            <link rel="stylesheet" href="${APP_PATH}/static/css/bootstrap.min.css">
            <link rel="stylesheet" href="${APP_PATH}/static/css/reset.css">
            <link rel="stylesheet" href="${APP_PATH}/static/css/style.css">

            <script src="${APP_PATH}/static/js/jquery.min.js"></script>
            <script src="${APP_PATH}/static/js/bootstrap.min.js"></script>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>错误！没有相关的操作权限</title>
            <style>
                body {
                    background-color: #ccc;
                }

                .errorPage {
                    width: 500px;
                    height: 300px;
                    background: #fff;
                    border-radius: 10px;
                    margin: 150px auto;
                }

                .error-head {
                    height: 60px;
                    line-height: 60px;
                    background-color: #5cb85c;
                    border-top-left-radius: 10px;
                    border-top-right-radius: 10px;
                    border-bottom: 3px #ccc solid;
                    font-size: 30px;
                    font-weight: bold;
                }

                .error-head span {
                    color: red;
                    display: inline-block;
                    padding: 0 20px;
                }
            </style>
    </head>

    <body>
        <div class="container">
            <div class="errorPage">
                <div class="error-head">
                    <p>
                        <span class="glyphicon glyphicon-remove-sign"></span>Error!</p>
                </div>
                <div class="error-body">
                    <p>您没有相关权限</p>
                </div>
                <button type="button" onclick="history.go(-1)" class="btn btn-warning">返回</button>
                <button type="button" onclick="window.location.href='${APP_PATH}/logout'" class="btn btn-success">切换帐号</button>
            </div>
        </div>
    </body>

    </html>
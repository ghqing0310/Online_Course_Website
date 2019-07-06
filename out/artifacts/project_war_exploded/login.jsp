<%--
  Created by IntelliJ IDEA.
  User: ghqing
  Date: 2018/7/22
  Time: 下午10:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>登录</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="http://static.runoob.com/assets/jquery-validation-1.14.0/lib/jquery.js"></script>
    <script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>
    <script src="js/login.js"></script>
</head>
<body>
<%
    String message = (String)request.getAttribute("message");
%>
<!--导航栏-->
<jsp:include page="navigator.jsp"/>
<div class="container">
    <div class="page-header">
        <h1>登录</h1>
    </div>
    <div style="padding: 100px 100px 10px;">
        <form class="bs-example bs-example-form" role="form" action="login.user" method="post" id="loginForm">
            <div class="input-group" id="usernameInput">
                <span class="input-group-addon">用户名:</span>
                <input type="text" class="form-control" value="" name="username">
            </div>
            <br>
            <div class="input-group" id="passwordInput">
                <span class="input-group-addon">密码:</span>
                <input type="password" class="form-control" value="" name="password">
            </div>
            <%
                if (message != null && message.equals("error")){
            %>
                    <div id="passwordMessage" style="color: red">用户名或密码错误！</div>
            <%
                }
            %>
            <br>
            <div><button type="submit" class="btn btn-primary btn-lg btn-block">提交</button></div>
        </form>
    </div>
</div>
</body>
</html>

<%--
  Created by IntelliJ IDEA.
  User: ghqing
  Date: 2018/8/2
  Time: 下午9:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>邮箱验证</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="http://static.runoob.com/assets/jquery-validation-1.14.0/lib/jquery.js"></script>
    <script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>
    <script src="js/codeVerify.js"></script>
</head>
<body>
<%
    String message = (String)request.getAttribute("message");
    if (message == null){
        message = "";
    }
    if (message.equals("codeWrong")){
%>
        <script>alert("验证码错误！")</script>
<%
    }
%>
<!--导航栏-->
<jsp:include page="navigator.jsp"/>
<div class="container">
    <div class="page-header">
        <h1>邮箱验证</h1>
    </div>
    <div style="padding: 100px 100px 10px;">
        <form class="bs-example bs-example-form" role="form" ACTION="code.user" method="post" id="codeForm">
            <div class="input-group" id="codeInput">
                <span class="input-group-addon">验证码:</span>
                <input type="text" class="form-control" value="" name="code">
            </div>
            <br>
            <div><button id="submit" type="submit" class="btn btn-primary btn-lg btn-block">提交</button></div>
        </form>
    </div>
</div>
</body>
</html>

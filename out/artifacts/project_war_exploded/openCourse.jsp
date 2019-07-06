<%@ page import="java.io.File" %>
<%@ page import="java.awt.*" %><%--
  Created by IntelliJ IDEA.
  User: ghqing
  Date: 2018/7/25
  Time: 下午2:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>新建课程</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="http://static.runoob.com/assets/jquery-validation-1.14.0/lib/jquery.js"></script>
    <script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>
    <script src="js/openCourse.js"></script>
</head>
<body>
<%
    String courseName = request.getParameter("courseName");
    String courseDescription = request.getParameter("courseDescription");
    String message = (String)request.getAttribute("message");
    if (courseName == null){
        courseName = "";
    }
    if (courseDescription == null){
        courseDescription = "";
    }
    if (message == null){
        message = "";
    }
%>
<!--导航栏-->
<jsp:include page="navigator.jsp"/>
<div class="container">
    <div class="page-header">
        <h1>新建课程</h1>
    </div>
    <div style="padding: 100px 100px 100px;">
        <form class="bs-example bs-example-form" role="form" action="openCourse.course?navigator=openCourse" method="post" id="openCourseForm" enctype="multipart/form-data">
            <div class="input-group" id="courseNameInput">
                <span class="input-group-addon">课程名称：</span>
                <input type="text" class="form-control" value="<%=courseName%>" name="courseName">
            </div>
            <%
                if (message.equals("courseNameExist")){
            %>
                    <div id="courseNameMessage" style="color: red">该课程已被开设！</div>
            <%
                }
            %>
            <br>
            <div class="input-group" id="courseDescriptionInput">
                <span class="input-group-addon">课程介绍：</span>
                <input type="text" class="form-control" value="<%=courseDescription%>" name="courseDescription">
            </div>
            <br>
            <div id="coursePictureInput">
                <input type="file" name="coursePicture">
            </div>
            <br>
            <div><button type="submit" class="btn btn-primary btn-lg btn-block">提交</button></div>
        </form>
    </div>
</div>
</body>
</html>

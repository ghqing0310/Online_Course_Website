<%@ page import="Model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Course" %>
<%@ page import="Service.Course.CourseServiceImpl" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Service.Course.CourseService" %><%--
  Created by IntelliJ IDEA.
  User: ghqing
  Date: 2018/7/24
  Time: 下午10:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>个人中心</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="http://static.runoob.com/assets/jquery-validation-1.14.0/lib/jquery.js"></script>
    <script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>
    <script src="js/information.js"></script>
</head>
<body>
<%
    String navigator = request.getParameter("navigator");

    User user = (User)session.getAttribute("user");
    String message = (String)request.getAttribute("message");
    if (message == null){
        message = "";
    }
    List<Course> openCourse = new ArrayList<Course>();
    List<Course> chooseCourse = new ArrayList<Course>();
    CourseService courseService = new CourseServiceImpl();
    if (user != null) {
        int userId = user.getId();
        openCourse = courseService.getAllOpenCourses(userId);
        chooseCourse = courseService.getAllChooseCourses(userId);
    }
%>
<%
    if (message.equals("passwordWrong")){
%>
        <script>alert("密码错误！")</script>
<%
    }
%>
<!--导航栏-->
<jsp:include page="navigator.jsp"/>
<%
    if (user != null){
%>
<div class="container">
    <div><h4 style="padding: 0 0 10px 10px">您好，<%=user.getUsername()%>!</h4></div>
    <div>
        <ul class="nav nav-pills nav-tabs">
            <li class="<%=navigator == null ? "active" : ""%>">
                <a href="information.jsp?">我选的课</a>
            </li>
            <li class="<%=navigator == null ? "" : "active"%>">
                <a href="information.jsp?navigator=openCourse">我开的课</a>
            </li>
            <li class="navbar-right">
                <a href="<%=navigator == null ? "search.jsp" : "openCourse.jsp"%>"><%=navigator == null ? "添加课程" : "新建课程"%></a>
            </li>
        </ul>
    </div>
    <div class="row" style="padding-top: 30px">
        <%
            if (navigator == null && chooseCourse.size() != 0){
                for (Course course: chooseCourse){
                    int courseId = course.getId();
                    String courseName = course.getCourseName();
                    String courseDescription = course.getCourseDescription();
                    String coursePicture = course.getCoursePicture();
        %>
                    <div class="col-sm-4">
                        <div class="thumbnail">
                            <img src="showPicture.course?coursePicture=<%=coursePicture%>"
                                 alt="通用的占位符缩略图" style="height: 200px">
                            <div class="caption">
                                <h3><%=courseName%></h3>
                                <p><%=courseDescription%></p>
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#dropCourse<%=courseId%>">退课</button>
                                <a href="courseDetail.jsp?courseId=<%=courseId%>" class="btn btn-default" role="button">
                                    查看
                                </a>
                            </div>
                        </div>
                    </div>
        <!--退课模态框-->
        <div class="modal fade" id="dropCourse<%=courseId%>" tabindex="-1" role="dialog" aria-labelledby="dropCourseLabel<%=courseId%>" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"
                                aria-hidden="true">×
                        </button>
                        <h4 class="modal-title" id="dropCourseLabel<%=courseId%>">
                            是否退课？
                        </h4>
                    </div>
                    <form action="dropCourse.course" method="post" id="dropCourseForm<%=courseId%>">
                        <input type="hidden" name="address" value="information.jsp">
                        <input type="hidden" name="courseId" value="<%=courseId%>">
                        <div class="modal-body" id="passwordInput<%=courseId%>">
                            请输入密码：<input type="password" name="password" id="password<%=courseId%>">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            <button type="submit" class="btn btn-primary">退课</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%
                }
            }
        %>
        <%
            if (navigator != null && openCourse.size() != 0){
                for (Course course: openCourse){
                    int courseId = course.getId();
                    String courseName = course.getCourseName();
                    String courseDescription = course.getCourseDescription();
                    String coursePicture = course.getCoursePicture();
        %>
                    <div class="col-sm-4">
                        <div class="thumbnail">
                            <img src="showPicture.course?coursePicture=<%=coursePicture%>"
                                 alt="通用的占位符缩略图" style="height: 200px">
                            <div class="caption">
                                <h3><%=courseName%></h3>
                                <p><%=courseDescription%></p>
                                <a href="courseDetail.jsp?courseId=<%=courseId%>" class="btn btn-default" role="button">
                                    查看
                                </a>
                            </div>
                        </div>
                    </div>
        <%
                }
            }
        %>
    </div>
</div>
<%
    }
%>
</body>
</html>

<%@ page import="Service.Course.CourseService" %>
<%@ page import="Service.Course.CourseServiceImpl" %>
<%@ page import="Model.Course" %><%--
  Created by IntelliJ IDEA.
  User: ghqing
  Date: 2018/7/22
  Time: 下午5:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>首页</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<%
    CourseService service = new CourseServiceImpl();
    Course[] hottest = service.getHottestCourses();
    Course[] newest = service.getNewestCourses();
%>
<body>
<!--导航栏-->
<jsp:include page="navigator.jsp"/>
<!--热门课程展示-->
<div id="myCarousel" class="carousel slide">
    <!-- 轮播（Carousel）指标 -->
    <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>
    <!-- 轮播（Carousel）项目 -->
    <div class="carousel-inner" style="background-color:dimgrey">
        <div class="col-sm-2"></div>
        <%
            for (int i = 0; i < 3; i++){
                int courseId = hottest[i].getId();
                String coursePicture = hottest[i].getCoursePicture();
                String courseName = hottest[i].getCourseName();
                String courseDescription = hottest[i].getCourseDescription();
        %>
                <div class="item <%=i==0 ? "active" : ""%> col-sm-8">
                    <a href="courseDetail.jsp?courseId=<%=courseId%>">
                        <img src="showPicture.course?coursePicture=<%=coursePicture%>" class="img-responsive" style="height: 500px">
                    </a>
                    <div class="carousel-caption">
                        <h4><%=courseName%></h4>
                        <p><%=courseDescription%></p>
                    </div>
                </div>
        <%
            }
        %>
        <!-- 轮播（Carousel）导航 -->
        <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
</div>
<!--最新课程展示-->
<div class="container" style="padding-top: 50px">
    <div class="row">
        <%
            for (int i = 0; i < 3; i++){
                int courseId = newest[i].getId();
                String coursePicture = newest[i].getCoursePicture();
                String courseName = newest[i].getCourseName();
                String courseDescription = newest[i].getCourseDescription();
        %>
                <div class="col-sm-4">
                    <div class="thumbnail">
                        <img src="showPicture.course?coursePicture=<%=coursePicture%>"
                             alt="通用的占位符缩略图" style="height: 200px">
                        <div class="caption">
                            <h3><%=courseName%></h3>
                            <p><%=courseDescription%></p>
                            <a href="courseDetail.jsp?courseId=<%=courseId%>" class="btn btn-primary" role="button">
                                查看
                            </a>
                        </div>
                    </div>
                </div>
        <%
            }
        %>
    </div>
</div>
</body>
</html>

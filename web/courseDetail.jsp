<%@ page import="Service.Course.CourseService" %>
<%@ page import="Service.Course.CourseServiceImpl" %>
<%@ page import="Model.Course" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.CoursePoint.CourseChapter" %>
<%@ page import="Model.CoursePoint.CoursePoint" %>
<%@ page import="Model.User" %><%--
  Created by IntelliJ IDEA.
  User: ghqing
  Date: 2018/7/22
  Time: 下午5:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>课程详情</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="http://static.runoob.com/assets/jquery-validation-1.14.0/lib/jquery.js"></script>
    <script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>
    <script src="js/courseDetail.js"></script>
</head>
<body>
<%
    User user = (User)session.getAttribute("user");
    int courseId = request.getParameter("courseId") == null ? 1 : Integer.parseInt(request.getParameter("courseId"));
    String message = (String)request.getAttribute("message");
    if (message == null){
        message = "";
    }
    CourseService service = new CourseServiceImpl();
    Course course = service.getCourse(courseId);
    String courseName = course.getCourseName();
    List<CourseChapter> courseChapters = service.getCourseChapters(courseId);
%>
<%
    if (message.equals("chapterNameExist")){
%>
        <script>alert("该课程的章节名已存在！")</script>
<%
    } else if (message.equals("pointNameExist")){
%>
        <script>alert("该章节的知识点已存在！")</script>
<%
    } else if (message.equals("passwordWrong")){
%>
        <script>alert("密码错误！")</script>
<%
    }
%>
<!--导航栏-->
<jsp:include page="navigator.jsp"/>
<!--次导航栏-->
<div>
    <div class="col-sm-1"></div>
    <div class="page-header">
        <h3><%=courseName%>
            <small>
                <ul class="nav nav-pills navbar-right" style="padding-right: 100px">
                    <li class="active"><a href="courseDetail.jsp?courseId=<%=courseId%>">首页</a></li>
                    <li><a href="<%=user == null ? "" : "courseResource.jsp?courseId=" + courseId%>">资源</a></li>
                    <li><a href="<%=user == null ? "" : "courseHomework.jsp?courseId=" + courseId%>">作业</a></li>
                </ul>
            </small>
        </h3>
    </div>
</div>
<!--知识点列表-->
<div class="container">
    <div class="panel-group col-sm-9" id="accordion">
        <%
            if (courseChapters.size() > 0){
                for (CourseChapter courseChapter: courseChapters){
                    int chapterId = courseChapter.getChapterId();
                    String chapterName = courseChapter.getChapterName();
                    List<CoursePoint> coursePoints = service.getCoursePoints(chapterId);
        %>
                    <div class="panel panel-default">
                        <!--章节名称-->
                        <div class="panel-heading" style="height: 70px">
                            <div class="col-lg-8">
                                <h4 class="panel-title" style="padding-top: 15px">
                                    <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne"><%=chapterName%></a>
                                </h4>
                            </div>
                            <%
                                if (user != null && service.isOpen(user.getId(), courseId) > 0){
                            %>
                                    <div class="col-lg-4">
                                        <div class="col-lg-5" style="padding-top: 8px">
                                            <button class="btn btn-default" data-toggle="modal" data-target="#myChapter<%=chapterId%>">
                                                修改章节
                                            </button>
                                        </div>
                                        <div class="col-lg-7" style="padding-top: 8px">
                                            <button class="btn btn-default" data-toggle="modal" data-target="#myPoint<%=chapterId%>">
                                                添加知识点
                                            </button>
                                        </div>
                                    </div>
                            <%
                                }
                            %>
                        </div>
                        <!--知识点名称-->
                        <%
                            if (coursePoints.size() > 0){
                        %>
                                <div id="collapseOne" class="panel-collapse collapse in">
                                    <div class="panel-body">
                        <%
                                for (CoursePoint coursePoint: coursePoints){
                                    int pointId = coursePoint.getPointId();
                                    String pointName = coursePoint.getPointName();
                        %>
                                    <p>
                                        <span class="glyphicon glyphicon-star" style="color: orange"></span>
                                        <a style="color:black;" href="<%=user != null && (service.isChosen(user.getId(), courseId) > 0
                                        || service.isOpen(user.getId(), courseId) > 0) ? "coursePoint.jsp?courseId=" + courseId + "&pointId=" + pointId : ""%>"><%=pointName%></a>
                                    </p>
                        <%
                                }
                        %>
                                    </div>
                                </div>
                        <%
                            }
                        %>
                    </div>
                    <!--修改章节模态框-->
                    <div class="modal fade" id="myChapter<%=chapterId%>" tabindex="-1" role="dialog" aria-labelledby="myChapterLabel<%=chapterId%>" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal"
                                            aria-hidden="true">×
                                    </button>
                                    <h4 class="modal-title" id="myChapterLabel<%=chapterId%>">
                                        修改章节
                                    </h4>
                                </div>
                                <form action="updateChapterName.course" method="post" class="updateChapterForm<%=chapterId%>">
                                    <input type="hidden" name="courseId" value="<%=courseId%>">
                                    <input type="hidden" name="chapterId" value="<%=chapterId%>">
                                    <div class="modal-body chapterNameInput<%=chapterId%>">
                                        章节名称：<input type="text" name="chapterName" id="chapterName<%=chapterId%>" value="<%=chapterName%>">
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                        <button type="submit" class="btn btn-primary">修改</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!--添加知识点模态框-->
                    <div class="modal fade" id="myPoint<%=chapterId%>" tabindex="-1" role="dialog" aria-labelledby="myPointLabel<%=chapterId%>" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal"
                                            aria-hidden="true">×
                                    </button>
                                    <h4 class="modal-title" id="myPointLabel<%=chapterId%>">
                                        添加知识点
                                    </h4>
                                </div>
                                <form action="addPointName.course" method="post" class="addPointForm<%=chapterId%>">
                                    <input type="hidden" name="courseId" value="<%=courseId%>">
                                    <input type="hidden" name="chapterId" value="<%=chapterId%>">
                                    <div class="modal-body pointNameInput<%=chapterId%>">
                                        知识点名称：<input type="text" name="pointName" id="pointName<%=chapterId%>">
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" id="button<%=chapterId%>" class="btn btn-default" data-dismiss="modal">关闭</button>
                                        <button type="submit" class="btn btn-primary">添加</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
        <%
                }
            }
        %>
    </div>
    <div class="col-sm-3">
        <%
            if (user != null && service.isOpen(user.getId(), courseId) > 0){
        %>
                <button type="button" class="btn btn-primary btn-lg btn-block" data-toggle="modal" data-target="#myChapter">添加章节</button>
        <%
            } else if (user != null && service.isChosen(user.getId(), courseId) > 0){
        %>
                <button type="button" class="btn btn-primary btn-lg btn-block" data-toggle="modal" data-target="#dropCourse">退课</button>
        <%
            } else if (user != null){
        %>
                <form action="chooseCourse.course">
                    <input type="hidden" name="courseId" value="<%=courseId%>">
                    <input type="hidden" name="address" value="courseDetail.jsp">
                    <button type="submit" class="btn btn-primary btn-lg btn-block">选课</button>
                </form>
        <%
            } else {
        %>
                <a href="register.jsp"><button type="submit" class="btn btn-primary btn-lg btn-block">选课</button></a>
        <%
            }
        %>
    </div>
    <!--添加章节模态框-->
    <div class="modal fade" id="myChapter" tabindex="-1" role="dialog" aria-labelledby="myChapterLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">×
                    </button>
                    <h4 class="modal-title" id="myChapterLabel">
                        添加章节
                    </h4>
                </div>
                <form action="addChapterName.course" id="addChapterForm" method="post">
                    <input type="hidden" name="courseId" value="<%=courseId%>">
                    <div class="modal-body" id="chapterNameInput">
                        章节名称：<input type="text" name="chapterName" id="chapterName">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="submit" class="btn btn-primary">添加</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!--退课模态框-->
    <div class="modal fade" id="dropCourse" tabindex="-1" role="dialog" aria-labelledby="dropCourseLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">×
                    </button>
                    <h4 class="modal-title" id="dropCourseLabel">
                        是否退课？
                    </h4>
                </div>
                <form action="dropCourse.course" method="post" id="dropCourseForm">
                    <input type="hidden" name="address" value="courseDetail.jsp">
                    <input type="hidden" name="courseId" value="<%=courseId%>">
                    <div class="modal-body" id="passwordInput">
                        请输入密码：<input type="password" name="password">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="submit" class="btn btn-primary">退课</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>

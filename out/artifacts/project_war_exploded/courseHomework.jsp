<%@ page import="Service.Course.CourseService" %>
<%@ page import="Service.Course.CourseServiceImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.*" %>
<%@ page import="Model.CourseHomework.CourseHomework" %><%--
  Created by IntelliJ IDEA.
  User: ghqing
  Date: 2018/7/22
  Time: 下午5:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>作业</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
    List<CourseHomework> courseHomeworks = service.getHomeworksOfCourse(courseId);
%>
<%
    if (message.equals("homeworkNameExist")){
%>
        <script>alert("该课程的作业名已存在！")</script>
<%
    }
%>
<!--导航栏-->
<jsp:include page="navigator.jsp"/>
<%
    if (user != null){
%>
<!--次导航栏-->
<div>
    <div class="col-sm-1"></div>
    <div class="page-header">
        <h3><%=courseName%>
            <small>
                <ul class="nav nav-pills navbar-right" style="padding-right: 100px">
                    <li><a href="courseDetail.jsp?courseId=<%=courseId%>">首页</a></li>
                    <li><a href="courseResource.jsp?courseId=<%=courseId%>">资源</a></li>
                    <li class="active"><a href="courseHomework.jsp?courseId=<%=courseId%>">作业</a></li>
                </ul>
            </small>
        </h3>
    </div>
</div>
<!--作业-->
<div class="container" style="padding: 0 100px 0 100px">
    <%
        if (service.isOpen(user.getId(), courseId) > 0){
    %>
            <div style="padding-right: 30px">
                <button type="button" class="navbar-right btn btn-primary" data-toggle="modal" data-target="#myHomework">添加作业</button>
            </div>
    <%
        }
    %>
    <div class="row" style="padding-top: 50px">
        <%
            if (courseHomeworks.size() > 0){
                for (CourseHomework courseHomework: courseHomeworks){
                    int homeworkId = courseHomework.getHomeworkId();
                    String homeworkName = courseHomework.getHomeworkName();
        %>
                    <div class="col-sm-4">
                        <div class="thumbnail">
                            <div class="caption">
                                <h4><a style="color: black"><%=homeworkName%></a></h4>
                                <br>
                                <p>
                                <%
                                    if (service.isOpen(user.getId(), courseId) > 0){
                                %>
                                    <a href="courseHomeworkResult.jsp?courseId=<%=courseId%>&homeworkId=<%=homeworkId%>" class="btn btn-primary" role="button">
                                        结果
                                    </a>
                                <%
                                    }
                                %>
                                    <a href="courseHomeworkDetail.jsp?courseId=<%=courseId%>&homeworkId=<%=homeworkId%>" class="btn btn-default" role="button">
                                        查看
                                    </a>
                                </p>
                            </div>
                        </div>
                    </div>
        <%
                }
            }
        %>
    </div>
</div>
<!--添加作业模态框-->
<div class="modal fade" id="myHomework" tabindex="-1" role="dialog" aria-labelledby="myHomeworkLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">×
                </button>
                <h4 class="modal-title" id="myHomeworkLabel">
                    添加作业
                </h4>
            </div>
            <form action="addHomework.course" id="addHomeworkForm" method="post">
                <input type="hidden" name="courseId" value="<%=courseId%>">
                <div class="modal-body" id="homeworkNameInput">
                    作业名称：<input type="text" name="homeworkName">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">添加</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%
    }
%>
</body>
</html>
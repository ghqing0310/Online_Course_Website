<%@ page import="Service.Course.CourseService" %>
<%@ page import="Service.Course.CourseServiceImpl" %>
<%@ page import="Model.Course" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.User" %>
<%@ page import="Model.CourseResource" %><%--
  Created by IntelliJ IDEA.
  User: ghqing
  Date: 2018/7/22
  Time: 下午5:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>资源</title>
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
    List<CourseResource> courseResources = service.getAllResourcesOfCourse(courseId);
    String courseName = course.getCourseName();
%>
<%
    if (message.equals("resourceNameExist")){
%>
        <script>alert("该课程已存在该资源！")</script>
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
                    <li class="active"><a href="courseResource.jsp?courseId=<%=courseId%>">资源</a></li>
                    <li><a href="courseHomework.jsp?courseId=<%=courseId%>">作业</a></li>
                </ul>
            </small>
        </h3>
    </div>
</div>
<!--资源-->
<div class="container" style="padding: 30px 100px 0 100px">
    <table class="table table-hover">
        <thead style="background-color: #F2F2F2">
        <tr style="height: 50px">
            <th width="70%" style="padding-bottom: 10px">文件名</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (courseResources.size() > 0){
                for (CourseResource courseResource: courseResources){
                    int resourceId = courseResource.getResourceId();
                    String resourceName = courseResource.getResourceName();
        %>
                    <tr style="height: 50px">
                        <td style="padding-top: 15px">
                            <%=resourceName%>
                            <%
                                if (service.isOpen(user.getId(), courseId) > 0){
                            %>
                            <a class="navbar-right" style="color:black;padding-right: 10px;padding-bottom: 5px">
                                <button data-toggle="modal" data-target="#myResource<%=resourceId%>">修改</button>
                            </a>
                            <%
                                }
                            %>
                            <a class="navbar-right" href="downloadResource.course?courseId=<%=courseId%>&resourceId=<%=resourceId%>" style="color:black;padding-right: 10px;padding-bottom: 5px">
                                <button>下载</button>
                            </a>
                        </td>
                    </tr>
                    <!--修改资源模态框-->
                    <div class="modal fade" id="myResource<%=resourceId%>" tabindex="-1" role="dialog" aria-labelledby="myResourceLabel<%=resourceId%>" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal"
                                            aria-hidden="true">×
                                    </button>
                                    <h4 class="modal-title" id="myResourceLabel<%=resourceId%>">
                                        修改
                                    </h4>
                                </div>
                                <form action="updateResource.course" method="post" class="updateResourceForm<%=resourceId%>" enctype="multipart/form-data">
                                    <input type="hidden" name="courseId" value="<%=courseId%>">
                                    <input type="hidden" name="resourceId" value="<%=resourceId%>">
                                    <div class="modal-body resourceInput<%=resourceId%>" style="padding-bottom: 50px">
                                        <div class="col-lg-2"><input type="file" name="resourceName"></div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                        <button type="submit" class="btn btn-primary">修改</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
        <%
                }
            }
        %>
        </tbody>
    </table>
    <%
        if (service.isOpen(user.getId(), courseId) > 0){
    %>
    <div style="padding-top: 30px">
        <form action="addResource.course" method="post" id="addResource" enctype="multipart/form-data">
            <input type="hidden" name="courseId" value="<%=courseId%>">
            <div class="col-lg-2"><input type="file" name="resourceName"></div>
            <div><button type="submit">上传</button></div>
        </form>
    </div>
    <%
        }
    %>
</div>
<%
    }
%>
</body>
</html>
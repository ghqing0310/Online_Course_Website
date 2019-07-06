<%@ page import="Service.Course.CourseService" %>
<%@ page import="Service.Course.CourseServiceImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.*" %>
<%@ page import="Model.CoursePoint.CourseChapter" %>
<%@ page import="Model.CoursePoint.CoursePoint" %>
<%@ page import="Model.CoursePoint.CoursePointFile" %><%--
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
    <title>知识点</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<%
    User user = (User)session.getAttribute("user");
    int courseId = request.getParameter("courseId") == null ? 1 : Integer.parseInt(request.getParameter("courseId"));
    int pointId = request.getParameter("pointId") == null ? 1 : Integer.parseInt(request.getParameter("pointId"));
    String message = (String)request.getAttribute("message");
    if (message == null){
        message = "";
    }
    CourseService service = new CourseServiceImpl();
    CoursePoint coursePoint = service.getCoursePoint(pointId);
    List<CourseChapter> courseChapters = service.getCourseChapters(courseId);
    List<CoursePointFile> coursePointFiles = service.getFilesOfPoint(pointId);
%>
<%
    if (message.equals("filenameExist")){
%>
        <script>alert("该章节已存在该视频！")</script>
<%
    } else if (message.equals("pointNameExist")){
%>
        <script>alert("该章节已存在该知识点！")</script>
<%
    } else if (message.equals("fileWrong")){
%>
        <script>alert("请上传mp4或pdf文件！")</script>
<%
    }
%>
<body>
<%
    if (user != null){
%>
<div class="container">
    <!--视频-->
    <div class="container col-sm-8">
        <div style="padding-top: 30px">
            <span class="glyphicon glyphicon-chevron-left"></span>
            <a href="courseDetail.jsp?courseId=<%=courseId%>" style="color:black;">回到课程</a>
        </div>
        <div class="page-header text-center">
            <%
                if (service.isOpen(user.getId(), courseId) > 0){
            %>
                    <a class="navbar-right" style="color:black;padding-top: 5px;padding-right: 20px">
                        <button data-toggle="modal" data-target="#myPoint<%=pointId%>">修改</button>
                    </a>
            <%
                }
            %>
            <h3><%=coursePoint.getPointName()%></h3>
        </div>
        <div style="padding-left: 20px">
            <%
                if (service.isOpen(user.getId(), courseId) > 0){
            %>
                    <form action="uploadPointFile.course" method="post" id="uploadPointForm" enctype="multipart/form-data">
                        <div>
                            <input type="hidden" name="courseId" value="<%=courseId%>">
                            <input type="hidden" name="pointId" value="<%=pointId%>">
                            <div class="col-sm-3"><input type="file" name="filename"></div>
                            <div><button type="submit">上传</button></div>
                        </div>
                    </form>
            <%
                }
            %>
            <%
                if (coursePointFiles.size() > 0){
                    for (CoursePointFile coursePointFile: coursePointFiles){
                        int fileId = coursePointFile.getFileId();
                        String filename = coursePointFile.getFilename();
                        if (filename.contains(".mp4")){
            %>
                            <video controls="controls" width="700px" style="padding-top: 30px">
                                <source src="showVideo.course?filename=<%=filename%>" type="video/mp4" />
                            </video>
            <%
                        } else {
            %>
                            <iframe width="700px" style="height: 400px;" src="showVideo.course?filename=<%=filename%>"></iframe>
            <%
                        }
                        if (service.isOpen(user.getId(), courseId) > 0){
            %>
                            <div style="padding-top: 10px;padding-bottom: 20px">
                                <a style="color:black;padding-top: 5px">
                                    <button data-toggle="modal" data-target="#myPointFile<%=fileId%>">修改</button>
                                </a>
                            </div>
            <%
                        }
            %>
            <!--修改文件模态框-->
            <div class="modal fade" id="myPointFile<%=fileId%>" tabindex="-1" role="dialog" aria-labelledby="myPointFileLabel<%=fileId%>" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"
                                    aria-hidden="true">×
                            </button>
                            <h4 class="modal-title" id="myPointFileLabel<%=fileId%>">
                                修改
                            </h4>
                        </div>
                        <form action="updatePointFile.course" method="post" class="updatePointFileForm<%=fileId%>" enctype="multipart/form-data">
                            <input type="hidden" name="courseId" value="<%=courseId%>">
                            <input type="hidden" name="pointId" value="<%=pointId%>">
                            <input type="hidden" name="fileId" value="<%=fileId%>">
                            <div class="modal-body PointFileInput<%=fileId%>" style="padding-bottom: 50px">
                                <div class="col-lg-2"><input type="file" name="filename"></div>
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
        </div>
    </div>
    <!--知识点列表-->
    <div style="padding-top: 30px" class="col-sm-4">
        <div class="panel-group" id="accordion">
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
                    <div class="col-lg-7">
                        <h4 class="panel-title" style="padding-top: 15px">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne"><%=chapterName%></a>
                        </h4>
                    </div>
                </div>
                <!--知识点名称-->
                <%
                    if (coursePoints.size() > 0){
                %>
                <div id="collapseOne" class="panel-collapse collapse in">
                    <div class="panel-body">
                        <%
                            for (CoursePoint coursePoint2: coursePoints){
                                int pointId2 = coursePoint2.getPointId();
                                String pointName = coursePoint2.getPointName();
                        %>
                        <p>
                            <span class="glyphicon glyphicon-star" style="color: orange"></span>
                            <a style="color:black;" href="<%=(service.isChosen(user.getId(), courseId) > 0
                                                        || service.isOpen(user.getId(), courseId) > 0) ? "coursePoint.jsp?courseId=" + courseId + "&pointId=" + pointId2 : ""%>"><%=pointName%></a>
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
            <%
                    }
                }
            %>
        </div>
        <!--修改知识点模态框-->
        <div class="modal fade" id="myPoint<%=pointId%>" tabindex="-1" role="dialog" aria-labelledby="myPointLabel<%=pointId%>" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"
                                aria-hidden="true">×
                        </button>
                        <h4 class="modal-title" id="myPointLabel<%=pointId%>">
                            修改章节
                        </h4>
                    </div>
                    <form action="updatePointName.course" method="post" class="updatePointForm<%=pointId%>">
                        <input type="hidden" name="courseId" value="<%=courseId%>">
                        <input type="hidden" name="chapterId" value="<%=coursePoint.getChapterId()%>">
                        <input type="hidden" name="pointId" value="<%=pointId%>">
                        <div class="modal-body pointNameInput<%=pointId%>">
                            知识点名称：<input type="text" name="pointName" id="pointName<%=pointId%>" value="<%=coursePoint.getPointName()%>">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            <button type="submit" class="btn btn-primary">修改</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%
    }
%>
</body>
</html>
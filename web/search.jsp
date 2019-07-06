<%@ page import="Model.User" %>
<%@ page import="Service.Course.CourseService" %>
<%@ page import="Service.Course.CourseServiceImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Course" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: ghqing
  Date: 2018/7/22
  Time: 下午5:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>搜索</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<%
    String searchWords = request.getParameter("searchWords");
    String searchType = request.getParameter("searchType");
    String searchOrder = request.getParameter("searchOrder");
    int leaf = request.getParameter("leaf") == null ? 1: Integer.parseInt(request.getParameter("leaf"));
    if (searchWords == null){
        searchWords = "";
    }
    if (searchType == null){
        searchType = "1";
    }
    if (searchOrder == null){
        searchOrder = "1";
    }

    User user = null;
    if (session.getAttribute("user") != null){
        user = (User)session.getAttribute("user");
    }
    CourseService courseService = new CourseServiceImpl();
    List<Course> courses = (List<Course>) request.getAttribute("courses");
    if (courses == null){
        courses = courseService.searchAndOrderCourses("", "1", "1", 1);
    }
    int leafNumber = courseService.getLeafNumber(searchWords, searchType, searchOrder);
%>
<!--导航栏-->
<jsp:include page="navigator.jsp"/>
<div class="container">
    <div class="navbar-right">
        <form action="order.course">
            <input type="hidden" name="searchWords" value="<%=searchWords%>">
            <input type="hidden" name="searchType" value="<%=searchType%>">
            <select name="searchOrder">
                <option value ="1" <%=searchOrder.equals("1") ? "selected" : ""%>>按照选课人数正排序</option>
                <option value ="2" <%=searchOrder.equals("2") ? "selected" : ""%>>按照选课人数逆排序</option>
            </select>
            <button type="submit">排序</button>
        </form>
    </div>
    <div class="row" style="padding-top: 50px">
        <%
            if (courses.size() != 0){
                for (Course course: courses){
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
                                <%
                                    if (user == null){
                                %>
                                        <a href="register.jsp" class="btn btn-primary" role="button">
                                            选课
                                        </a>
                                        <a href="courseDetail.jsp?courseId=<%=courseId%>" class="btn btn-default" role="button">
                                            查看
                                        </a>
                                <%
                                    } else if (courseService.isChosen(user.getId(), courseId) > 0){
                                %>
                                        <a href="courseDetail.jsp?courseId=<%=courseId%>" class="btn btn-default" role="button">
                                            查看
                                        </a>
                                <%
                                    } else if (courseService.isOpen(user.getId(), courseId) > 0){
                                %>
                                        <a href="courseDetail.jsp?courseId=<%=courseId%>" class="btn btn-default" role="button">
                                            查看
                                        </a>
                                <%
                                    } else {
                                %>
                                        <a href="chooseCourse.course?courseId=<%=courseId%>&address=information.jsp" class="btn btn-primary" role="button">
                                            选课
                                        </a>
                                        <a href="courseDetail.jsp?courseId=<%=courseId%>" class="btn btn-default" role="button">
                                            查看
                                        </a>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>
        <%
                }
            }
        %>
    </div>
    <div class="text-center">
        <ul class="pagination">
            <%
                if (leafNumber > 0){
                    String href = "leaf.course?searchWords=" + searchWords + "&searchType=" + searchType + "&searchOrder=" + searchOrder + "&leaf=";
                    String prev = "";
                    String after = "";
                    if (leaf == 1){
                        prev = href + leaf;
                    } else {
                        prev = href + (leaf - 1);
                    }
                    if (leaf == leafNumber){
                        after = href + leaf;
                    } else {
                        after = href + (leaf + 1);
                    }
            %>
                    <li><a href="<%=prev%>">&laquo;</a></li>
            <%
                    for (int i = 1; i <= leafNumber; i++){
                        String isActive = i == leaf ? "active" : "";
                        String hrefEach = "leaf.course?searchWords=" + searchWords + "&searchType=" + searchType + "&searchOrder=" + searchOrder + "&leaf=" + i;
            %>
                        <li class="<%=isActive%>"><a href="<%=hrefEach%>"><%=i%></a></li>
            <%
                    }
            %>
                    <li><a href="<%=after%>">&raquo;</a></li>
            <%
                }
            %>
        </ul>
    </div>
</div>
</body>
</html>
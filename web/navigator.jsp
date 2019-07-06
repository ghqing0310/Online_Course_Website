<%@ page import="Model.User" %><%--
  Created by IntelliJ IDEA.
  User: ghqing
  Date: 2018/7/24
  Time: 下午6:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User)session.getAttribute("user");
    String searchWords = request.getParameter("searchWords");
    String searchType = request.getParameter("searchType");
    if (searchWords == null){
        searchWords = "";
    }
    if (searchType == null){
        searchType = "1";
    }
%>
<!--导航栏-->
<nav class="navbar navbar-inverse navbar-static-top" role="navigation" style="height: 20px">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="home.jsp">在线课程</a>
        </div>
        <div>
            <form action="search.course" class="col-lg-6" style="padding-top: 8px">
                <!--向左对齐-->
                <div class="col-lg-6">
                    <div class="nav navbar-nav navbar-left">
                        <div class="input-group">
                            <input type="text" class="form-control" name="searchWords" value="<%=searchWords%>">
                            <span class="input-group-btn">
                            <button class="btn btn-default" type="submit">搜索</button>
					    </span>
                        </div>
                    </div>
                </div>
                <div class="nav navbar-nav navbar-left" style="padding-top: 8px">
                    <select name="searchType">
                        <option value ="1" <%=searchType.equals("1") ? "selected" : ""%>>课程名称</option>
                        <option value ="2" <%=searchType.equals("2") ? "selected" : ""%>>课程简介</option>
                        <option value="3" <%=searchType.equals("3") ? "selected" : ""%>>开课老师</option>
                    </select>
                </div>
            </form>
            <!--向右对齐-->
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <span class="glyphicon glyphicon-user"></span>  <%=user == null ? "个人" : user.getUsername()%> <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <%
                            if (session.getAttribute("user") == null){
                        %>
                                <li><a href="register.jsp"> 注册</a></li>
                                <li><a href="login.jsp"> 登录</a></li>
                        <%
                        } else {
                        %>
                                <li><a href="information.jsp?"> 个人中心</a></li>
                                <li><a href="quit.user"> 退出</a></li>
                        <%
                            }
                        %>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
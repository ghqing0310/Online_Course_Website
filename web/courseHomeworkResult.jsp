<%@ page import="Service.Course.CourseService" %>
<%@ page import="Service.Course.CourseServiceImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.*" %>
<%@ page import="Service.User.UserServiceImpl" %>
<%@ page import="Model.CourseHomework.CourseHomework" %>
<%@ page import="Model.CourseHomework.CourseHomeworkAnswer" %>
<%@ page import="Model.CourseHomework.CourseHomeworkChoice" %>
<%@ page import="Model.CourseHomework.CourseHomeworkQuestion" %><%--
  Created by IntelliJ IDEA.
  User: ghqing
  Date: 2018/8/1
  Time: 下午3:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>作业结果</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<%
    User user = (User)session.getAttribute("user");
    int userId = user == null ? 1 : user.getId();
    int courseId = request.getParameter("courseId") == null ? 1 : Integer.parseInt(request.getParameter("courseId"));
    int homeworkId = request.getParameter("homeworkId") == null ? 1 : Integer.parseInt(request.getParameter("homeworkId"));
    CourseService service = new CourseServiceImpl();
    CourseHomework courseHomework = service.getHomework(homeworkId);
    String homeworkName = courseHomework.getHomeworkName();
    Course course = service.getCourse(courseId);
    String courseName = course.getCourseName();
    List<CourseHomeworkChoice> courseHomeworkChoices = service.getChoicesOfHomework(homeworkId);
    int choiceNumber = courseHomeworkChoices.size();
    List<CourseHomeworkQuestion> courseHomeworkQuestions = service.getQuestionsOfHomework(homeworkId);
    int questionNumber = courseHomeworkQuestions.size();
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
<div class="container" style="padding: 0 100px 100px 100px">
    <div class="page-header">
        <h4><%=homeworkName%>
            <small class="navbar-right">
                <span class="glyphicon glyphicon-chevron-left"></span>
                <a href="courseHomework.jsp?courseId=<%=courseId%>" style="color:black;padding-right: 50px">返回</a>
            </small>
        </h4>
    </div>
    <%
        if (courseHomeworkChoices.size() > 0){
            for (CourseHomeworkChoice courseHomeworkChoice: courseHomeworkChoices){
                int choiceId = courseHomeworkChoice.getChoiceId();
                String question = courseHomeworkChoice.getQuestion();
                String rightAnswer = courseHomeworkChoice.getRightAnswer();
                List<CourseHomeworkAnswer> courseHomeworkAnswers = service.getAnswersOfQuestion(choiceId, "单选题");
                if (courseHomeworkAnswers.size() > 0){
    %>
                    <h5>【单选题】<%=question%></h5>
                    <table class="table table-hover">
                        <thead style="background-color: #F2F2F2">
                        <tr style="height: 50px">
                            <th style="padding-bottom: 10px">学生</th>
                            <th width="70%" style="padding-bottom: 10px">答案</th>
                            <th style="padding-bottom: 10px">是否正确</th>
                        </tr>
                        </thead>
                        <tbody>
                <%
                    for (CourseHomeworkAnswer courseHomeworkAnswer: courseHomeworkAnswers){
                        int studentId = courseHomeworkAnswer.getUserId();
                        String studentName = new UserServiceImpl().getUser(studentId).getUsername();
                        String choice = courseHomeworkAnswer.getAnswer();
                        String isRight = choice.equals(rightAnswer) ? "正确" : "错误";
                %>
                        <tr style="height: 50px">
                            <td style="padding-top: 15px">
                                <%=studentName%>
                            </td>
                            <td style="padding-top: 15px">
                                <%=choice%>
                            </td>
                            <td style="padding-top: 15px">
                                <%=isRight%>
                            </td>
                        </tr>
                <%
                    }
                %>
                        </tbody>
                    </table>
                <%
                }
            }
        }
    %>
    <%
        if (courseHomeworkQuestions.size() > 0){
            for (CourseHomeworkQuestion courseHomeworkQuestion: courseHomeworkQuestions){
                int questionId = courseHomeworkQuestion.getQuestionId();
                String question = courseHomeworkQuestion.getQuestion();
                List<CourseHomeworkAnswer> courseHomeworkAnswers = service.getAnswersOfQuestion(questionId, "简答题");
                if (courseHomeworkAnswers.size() > 0){
    %>
                    <h5>【简答题】<%=question%></h5>
                    <table class="table table-hover">
                        <thead style="background-color: #F2F2F2">
                        <tr style="height: 50px">
                            <th style="padding-bottom: 10px">学生</th>
                            <th width="80%" style="padding-bottom: 10px">答案</th>
                        </tr>
                        </thead>
                        <tbody>
                <%
                    for (CourseHomeworkAnswer courseHomeworkAnswer: courseHomeworkAnswers){
                        int studentId = courseHomeworkAnswer.getUserId();
                        String studentName = new UserServiceImpl().getUser(studentId).getUsername();
                        String answer = courseHomeworkAnswer.getAnswer();
                %>
                        <tr style="height: 50px">
                            <td style="padding-top: 15px">
                                <%=studentName%>
                            </td>
                            <td style="padding-top: 15px">
                                <%=answer%>
                            </td>
                        </tr>
                <%
                    }
                %>
                        </tbody>
                    </table>
                <%
                }
            }
        }
    %>
</div>
<%
    }
%>
</body>
</html>

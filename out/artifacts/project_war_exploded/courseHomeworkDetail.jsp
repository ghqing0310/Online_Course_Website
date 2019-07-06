<%@ page import="Service.Course.CourseService" %>
<%@ page import="Service.Course.CourseServiceImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.*" %>
<%@ page import="Model.CourseHomework.CourseHomework" %>
<%@ page import="Model.CourseHomework.CourseHomeworkAnswer" %>
<%@ page import="Model.CourseHomework.CourseHomeworkChoice" %>
<%@ page import="Model.CourseHomework.CourseHomeworkQuestion" %><%--
  Created by IntelliJ IDEA.
  User: ghqing
  Date: 2018/7/31
  Time: 下午4:41
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
    <script src="http://static.runoob.com/assets/jquery-validation-1.14.0/lib/jquery.js"></script>
    <script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>
    <script src="js/courseHomeworkDetail.js"></script>
</head>
<body>
<%
    User user = (User)session.getAttribute("user");
    int userId = user == null ? 1 : user.getId();
    int courseId = request.getParameter("courseId") == null ? 1 : Integer.parseInt(request.getParameter("courseId"));
    int homeworkId = request.getParameter("homeworkId") == null ? 1 : Integer.parseInt(request.getParameter("homeworkId"));
    String message = (String)request.getAttribute("message");
    if (message == null){
        message = "";
    }
    CourseService service = new CourseServiceImpl();
    CourseHomework courseHomework = service.getHomework(homeworkId);
    String homeworkName = courseHomework.getHomeworkName();
    Course course = service.getCourse(courseId);
    String courseName = course.getCourseName();
    List<CourseHomeworkChoice> courseHomeworkChoices = service.getChoicesOfHomework(homeworkId);
    int choiceNumber = courseHomeworkChoices.size();
    List<CourseHomeworkQuestion> courseHomeworkQuestions = service.getQuestionsOfHomework(homeworkId);
    int questionNumber = courseHomeworkQuestions.size();
    List<CourseHomeworkAnswer> courseHomeworkAnswers = service.getAnswersOfHomework(homeworkId, userId);
    boolean isDone = choiceNumber + questionNumber - courseHomeworkAnswers.size() == 0;
%>
<%
    if (message.equals("homeworkChoiceExist")){
%>
        <script>alert("该作业的单选题问题已存在！")</script>
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
        if (service.isOpen(user.getId(), courseId) > 0){
    %>
            <div style="padding-right: 50px" class="navbar-right">
                <p><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myChoice">添加单选题</button></p>
                <p><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myQuestion">添加简答题</button></p>
            </div>
            <div>
    <%
        } else {
    %>
            <form action="addAnswer.course" method="post" id="addAnswerForm">
                <div id="answerInput">
    <%
        }
    %>
        <input type="hidden" name="courseId" value="<%=courseId%>">
        <input type="hidden" name="homeworkId" value="<%=homeworkId%>">
        <input type="hidden" name="choiceNumber" value="<%=choiceNumber%>">
        <%
            for (int i = 1; i <= choiceNumber; i++){
                CourseHomeworkChoice courseHomeworkChoice = courseHomeworkChoices.get(i - 1);
                int choiceId = courseHomeworkChoice.getChoiceId();
                String question = courseHomeworkChoice.getQuestion();
                String answerA = courseHomeworkChoice.getAnswerA();
                String answerB = courseHomeworkChoice.getAnswerB();
                String answerC = courseHomeworkChoice.getAnswerC();
                String rightAnswer = courseHomeworkChoice.getRightAnswer();
        %>
                <div>
                    <h5><%=i%>、【单选题】</h5>
                    <div style="padding-left: 30px">
                        <p><%=question%></p>
                        <input type="hidden" name="choiceId<%=i%>" value="<%=choiceId%>">
                        <p><input type="radio" name="choice<%=i%>" value="A"> A.<%=answerA%></p>
                        <p><input type="radio" name="choice<%=i%>" value="B"> B.<%=answerB%></p>
                        <%=answerC.equals("") ? "" : "<p><input type='radio' name='choice" + i + "' value='C'> C." + answerC + "</p>"%>
                    </div>
                    <%
                        if (service.isOpen(user.getId(), courseId) > 0){
                    %>
                            <button type="button" data-toggle="modal" data-target="#myChoiceUpdate<%=i%>">修改</button>
                            <!--修改单选题模态框-->
                            <div class="modal fade" id="myChoiceUpdate<%=i%>" tabindex="-1" role="dialog" aria-labelledby="myChoiceUpdateLabel<%=i%>" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal"
                                                aria-hidden="true">×
                                        </button>
                                        <h4 class="modal-title" id="myChoiceUpdateLabel<%=i%>">
                                            修改单选题
                                        </h4>
                                    </div>
                                    <form action="updateChoice.course" id="updateChoiceForm<%=i%>" method="post">
                                        <input type="hidden" name="courseId" value="<%=courseId%>">
                                        <input type="hidden" name="homeworkId" value="<%=homeworkId%>">
                                        <input type="hidden" name="choiceId" value="<%=choiceId%>">
                                        <input type="hidden" name="questionOld" value="<%=question%>">
                                        <div class="modal-body" id="choiceUpdateInput<%=i%>">
                                            <p>问题：<input type="text" id="choiceQuestion<%=i%>" name="choiceQuestion" value="<%=question%>"></p>
                                            <p>选择A：<input type="text" id="answerA<%=i%>" name="answerA" value="<%=answerA%>"></p>
                                            <p>选择B：<input type="text" id="answerB<%=i%>" name="answerB" value="<%=answerB%>"></p>
                                            <p>选择C：<input type="text" id="answerC<%=i%>" name="answerC" value="<%=answerC%>"></p>
                                            <p>正确答案：
                                                <input type="radio" name="rightAnswer" value="A" <%=rightAnswer.equals("A") ? "checked='checked'" : ""%>> A
                                                <input type="radio" name="rightAnswer" value="B" <%=rightAnswer.equals("B") ? "checked='checked'" : ""%>> B
                                                <input type="radio" id="rightAnswerC<%=i%>" name="rightAnswer" value="C" <%=rightAnswer.equals("C") ? "checked='checked'" : ""%>> C
                                            </p>
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
                        } else if (isDone){
                            CourseHomeworkAnswer courseHomeworkAnswer = service.getAnswer(choiceId, userId, "单选题");
                            String answer = courseHomeworkAnswer.getAnswer();
                    %>
                            <div style="color: dimgrey">
                                <div>你的答案：<%=answer%></div>
                                <div>正确答案：<%=rightAnswer%></div>
                                <div>是否答对：<%=answer.equals(rightAnswer) ? "是" : "否"%></div>
                            </div>
                    <%
                        }
                    %>
                </div>
                <br>
        <%
            }
        %>
        <input type="hidden" name="questionNumber" value="<%=questionNumber%>">
        <%
            for (int i = choiceNumber + 1; i <= choiceNumber + questionNumber; i++){
                int j = i - choiceNumber;
                CourseHomeworkQuestion courseHomeworkQuestion = courseHomeworkQuestions.get(j - 1);
                int questionId = courseHomeworkQuestion.getQuestionId();
                String question = courseHomeworkQuestion.getQuestion();
        %>
                <div>
                    <h5><%=i%>、【简答题】</h5>
                    <div style="padding-left: 30px;padding-bottom: 10px">
                        <p><%=question%></p>
                        <input type="hidden" name="questionId<%=j%>" value="<%=questionId%>">
                        <textarea class="form-control" rows="3" name="answer<%=j%>" style="width: 700px"></textarea>
                    </div>
                    <%
                        if (service.isOpen(user.getId(), courseId) > 0){
                    %>
                            <button type="button" data-toggle="modal" data-target="#myQuestionUpdate<%=j%>">修改</button>
                            <!--修改简答题模态框-->
                            <div class="modal fade" id="myQuestionUpdate<%=j%>" tabindex="-1" role="dialog" aria-labelledby="myQuestionUpdateLabel<%=j%>" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal"
                                                    aria-hidden="true">×
                                            </button>
                                            <h4 class="modal-title" id="myQuestionUpdateLabel<%=j%>">
                                                修改简答题
                                            </h4>
                                        </div>
                                        <form action="updateQuestion.course" id="updateQuestionForm<%=j%>" method="post">
                                            <input type="hidden" name="courseId" value="<%=courseId%>">
                                            <input type="hidden" name="homeworkId" value="<%=homeworkId%>">
                                            <input type="hidden" name="questionId" value="<%=questionId%>">
                                            <input type="hidden" name="questionOld" value="<%=question%>">
                                            <div class="modal-body" id="questionUpdateInput<%=j%>">
                                                <p>问题：<input type="text" id="question<%=j%>" name="question" value="<%=question%>"></p>
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
                        } else if (isDone){
                            CourseHomeworkAnswer courseHomeworkAnswer = service.getAnswer(questionId, userId, "简答题");
                            String answer = courseHomeworkAnswer.getAnswer();
                    %>
                            <div style="color: dimgrey">你的答案：<%=answer%></div>
                    <%
                        }
                    %>
                </div>
                <br/>
        <%
            }
        %>
        <%
            if (service.isOpen(user.getId(), courseId) > 0){
        %>
                </div>
        <%
            } else if (!isDone){
        %>
                    <button type="submit">提交</button>
                </div>
            </form>
        <%
            } else {
        %>
                </div>
            </form>
        <%
            }
        %>
    <!--添加单选题模态框-->
    <div class="modal fade" id="myChoice" tabindex="-1" role="dialog" aria-labelledby="myChoiceLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">×
                    </button>
                    <h4 class="modal-title" id="myChoiceLabel">
                        添加单选题
                    </h4>
                </div>
                <form action="addChoice.course" id="addChoiceForm" method="post">
                    <input type="hidden" name="courseId" value="<%=courseId%>">
                    <input type="hidden" name="homeworkId" value="<%=homeworkId%>">
                    <div class="modal-body" id="choiceInput">
                        <p>问题：<input type="text" name="choiceQuestion"></p>
                        <p>选择A：<input type="text" name="answerA"></p>
                        <p>选择B：<input type="text" name="answerB"></p>
                        <p>选择C：<input type="text" name="answerC"></p>
                        <p>正确答案：
                            <input type="radio" name="rightAnswer" value="A"> A
                            <input type="radio" name="rightAnswer" value="B"> B
                            <input type="radio" name="rightAnswer" value="C"> C
                        </p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="submit" class="btn btn-primary">添加</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!--添加简答题模态框-->
    <div class="modal fade" id="myQuestion" tabindex="-1" role="dialog" aria-labelledby="myQuestionLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">×
                    </button>
                    <h4 class="modal-title" id="myQuestionLabel">
                        添加简答题
                    </h4>
                </div>
                <form action="addQuestion.course" id="addQuestionForm" method="post">
                    <input type="hidden" name="courseId" value="<%=courseId%>">
                    <input type="hidden" name="homeworkId" value="<%=homeworkId%>">
                    <div class="modal-body" id="questionInput">
                        <p>问题：<input type="text" name="question"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="submit" class="btn btn-primary">添加</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<%
    }
%>
</body>
</html>

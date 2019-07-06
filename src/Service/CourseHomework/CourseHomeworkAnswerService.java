package Service.CourseHomework;

import Model.CourseHomework.CourseHomeworkAnswer;

import java.util.List;

public interface CourseHomeworkAnswerService {

    //添加该作业的回答
    void addAnswer(int questionId, int homeworkId, int userId, String answer, String type);

    //获得该用户对该作业的回答
    List<CourseHomeworkAnswer> getAnswersOfHomework(int homeworkId, int userId);

    //获得该问题的所有用户回答
    List<CourseHomeworkAnswer> getAnswersOfQuestion(int questionId, String type);

    //获得用户对该问题的回答
    CourseHomeworkAnswer getAnswer(int questionId, int userId, String type);
}

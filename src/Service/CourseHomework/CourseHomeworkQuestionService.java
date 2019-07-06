package Service.CourseHomework;

import Model.CourseHomework.CourseHomeworkQuestion;

import java.util.List;

public interface CourseHomeworkQuestionService {

    void addQuestion(int homeworkId, String question);

    void updateQuestion(int homeworkId, int questionId, String question);

    long countQuestion(int homeworkId, String question);

    List<CourseHomeworkQuestion> getQuestionsOfHomework(int homeworkId);

    CourseHomeworkQuestion gerQuestion(int questionId);
}

package Service.CourseHomework;

import DAO.DAO;
import Model.CourseHomework.CourseHomeworkQuestion;

import java.util.List;

public class CourseHomeworkQuestionServiceImpl extends DAO<CourseHomeworkQuestion> implements CourseHomeworkQuestionService {

    @Override
    public void addQuestion(int homeworkId, String question) {
        String sql = "INSERT INTO CourseHomeworkQuestion (homeworkId,question) VALUES (?,?)";
        update(sql, homeworkId, question);
        sql = "DELETE FROM CourseHomeworkAnswer WHERE homeworkId=?";
        update(sql, homeworkId);
    }

    @Override
    public void updateQuestion(int homeworkId, int questionId, String question) {
        String sql = "UPDATE CourseHomeworkQuestion SET question=? WHERE questionId=?";
        update(sql, question, questionId);
        sql = "DELETE FROM CourseHomeworkAnswer WHERE homeworkId=?";
        update(sql, homeworkId);
    }

    @Override
    public long countQuestion(int homeworkId, String question) {
        String sql = "SELECT COUNT(questionId) FROM CourseHomeworkQuestion WHERE homeworkId=? AND question=?";
        return getForValue(sql, homeworkId, question);
    }

    @Override
    public List<CourseHomeworkQuestion> getQuestionsOfHomework(int homeworkId) {
        String sql = "SELECT * FROM CourseHomeworkQuestion WHERE homeworkId=?";
        return getForList(sql, homeworkId);
    }

    @Override
    public CourseHomeworkQuestion gerQuestion(int questionId) {
        String sql = "SELECT * FROM CourseHomeworkQuestion WHERE questionId=?";
        return get(sql, questionId);
    }
}

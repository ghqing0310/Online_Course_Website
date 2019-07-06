package Service.CourseHomework;

import DAO.DAO;
import Model.CourseHomework.CourseHomeworkAnswer;

import java.util.List;

public class CourseHomeworkAnswerServiceImpl extends DAO<CourseHomeworkAnswer> implements CourseHomeworkAnswerService {

    @Override
    public void addAnswer(int questionId, int homeworkId, int userId, String answer, String type) {
        String sql = "INSERT INTO CourseHomeworkAnswer (questionId,homeworkId,userId,answer,type) VALUES (?,?,?,?,?)";
        update(sql, questionId, homeworkId, userId, answer, type);
    }

    @Override
    public List<CourseHomeworkAnswer> getAnswersOfHomework(int homeworkId, int userId) {
        String sql = "SELECT * FROM CourseHomeworkAnswer WHERE homeworkId=? AND userId=?";
        return getForList(sql, homeworkId, userId);
    }

    @Override
    public List<CourseHomeworkAnswer> getAnswersOfQuestion(int questionId, String type) {
        String sql = "SELECT * FROM CourseHomeworkAnswer WHERE questionId=? AND type=?";
        return getForList(sql, questionId, type);
    }

    @Override
    public CourseHomeworkAnswer getAnswer(int questionId, int userId, String type) {
        String sql = "SELECT * FROM CourseHomeworkAnswer WHERE questionId=? AND userId=? AND type=?";
        return get(sql, questionId, userId, type);
    }

    public static void main(String[] args) {

    }
}

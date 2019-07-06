package Service.CourseHomework;

import DAO.DAO;
import Model.CourseHomework.CourseHomeworkChoice;

import java.util.List;

public class CourseHomeworkChoiceServiceImpl extends DAO<CourseHomeworkChoice> implements CourseHomeworkChoiceService {

    @Override
    public void addChoice(int homeworkId, String question, String answerA, String answerB, String answerC, String rightAnswer) {
        String sql = "INSERT INTO CourseHomeworkChoice (homeworkId,question,answerA,answerB,answerC,rightAnswer) VALUES (?,?,?,?,?,?)";
        update(sql, homeworkId, question, answerA, answerB, answerC, rightAnswer);
        sql = "DELETE FROM CourseHomeworkAnswer WHERE homeworkId=?";
        update(sql, homeworkId);
    }

    @Override
    public void updateChoice(int homeworkId, int choiceId, String question, String answerA, String answerB, String answerC, String rightAnswer) {
        String sql = "UPDATE CourseHomeworkChoice SET question=?,answerA=?,answerB=?,answerC=?,rightAnswer=? WHERE choiceId=?";
        update(sql, question, answerA, answerB, answerC, rightAnswer, choiceId);
        sql = "DELETE FROM CourseHomeworkAnswer WHERE homeworkId=?";
        update(sql, homeworkId);
    }

    @Override
    public long countChoice(int homeworkId, String question) {
        String sql = "SELECT COUNT(choiceId) FROM CourseHomeworkChoice WHERE homeworkId=? AND question=?";
        return getForValue(sql, homeworkId, question);
    }

    @Override
    public List<CourseHomeworkChoice> getChoicesOfHomework(int homeworkId) {
        String sql = "SELECT * FROM CourseHomeworkChoice WHERE homeworkId=?";
        return getForList(sql, homeworkId);
    }

    @Override
    public CourseHomeworkChoice getChoice(int choiceId) {
        String sql = "SELECT * FROM CourseHomeworkChoice WHERE choiceId=?";
        return get(sql, choiceId);
    }
}

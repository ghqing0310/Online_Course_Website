package Service.CourseHomework;

import DAO.DAO;
import Model.CourseHomework.CourseHomework;

import java.util.List;

public class CourseHomeworkServiceImpl extends DAO<CourseHomework> implements CourseHomeworkService {

    @Override
    public void addHomework(int courseId, String homeworkName) {
        String sql = "INSERT INTO CourseHomework (courseId,homeworkName) VALUES (?,?)";
        update(sql, courseId, homeworkName);
    }

    @Override
    public CourseHomework getHomework(int homeworkId) {
        String sql = "SELECT * FROM CourseHomework WHERE homeworkId=?";
        return get(sql, homeworkId);
    }

    @Override
    public List<CourseHomework> getHomeworksOfCourse(int courseId) {
        String sql = "SELECT * FROM CourseHomework WHERE courseId=?";
        return getForList(sql, courseId);
    }

    @Override
    public long countHomeworkName(int courseId, String homeworkName) {
        String sql = "SELECT COUNT(homeworkId) FROM CourseHomework WHERE courseId=? AND homeworkName=?";
        return getForValue(sql, courseId, homeworkName);
    }
}

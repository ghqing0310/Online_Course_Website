package Service.CoursePoint;

import DAO.DAO;
import Model.CoursePoint.CoursePoint;

import java.util.List;

public class CoursePointServiceImpl extends DAO<CoursePoint> implements CoursePointService {

    @Override
    public List<CoursePoint> getCoursePoints(int chapterId) {
        String sql = "SELECT * FROM CoursePoint WHERE chapterId=?";
        return getForList(sql, chapterId);
    }

    @Override
    public void addPointName(int chapterId, int courseId, String pointName) {
        String sql = "INSERT INTO CoursePoint (chapterId,courseId,pointName) VALUES (?,?,?)";
        update(sql, chapterId, courseId, pointName);
    }

    @Override
    public long countPointName(int chapterId, String pointName) {
        String sql = "SELECT COUNT(pointId) FROM CoursePoint WHERE chapterId=? AND pointName=?";
        return getForValue(sql, chapterId, pointName);
    }

    @Override
    public CoursePoint getCoursePoint(int pointId) {
        String sql = "SELECT * FROM CoursePoint WHERE pointId=?";
        return get(sql, pointId);
    }

    @Override
    public void updatePointName(int pointId, String pointName) {
        String sql = "UPDATE CoursePoint SET pointName=? WHERE pointId=?";
        update(sql, pointName, pointId);
    }
}

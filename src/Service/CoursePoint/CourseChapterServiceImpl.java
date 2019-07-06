package Service.CoursePoint;

import DAO.DAO;
import Model.CoursePoint.CourseChapter;

import java.util.List;

public class CourseChapterServiceImpl extends DAO<CourseChapter> implements CourseChapterService {

    @Override
    public List<CourseChapter> getCourseChapters(int courseId) {
        String sql = "SELECT * FROM CourseChapter WHERE courseId=?";
        return getForList(sql, courseId);
    }

    @Override
    public void addChapterName(int courseId, String chapterName) {
        String sql = "INSERT INTO CourseChapter (courseId,chapterName) VALUES (?,?)";
        update(sql, courseId, chapterName);
    }

    @Override
    public long countChapterName(int courseId, String chapterName) {
        String sql = "SELECT COUNT(chapterId) FROM CourseChapter WHERE courseId=? AND chapterName=?";
        return getForValue(sql, courseId, chapterName);
    }

    @Override
    public void updateChapterName(int chapterId, String chapterName) {
        String sql = "UPDATE CourseChapter SET chapterName=? WHERE chapterId=?";
        update(sql, chapterName, chapterId);
    }
}

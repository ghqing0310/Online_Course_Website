package Service.CoursePoint;

import DAO.DAO;
import Model.CoursePoint.CoursePointFile;

import java.util.List;

public class CoursePointFileServiceImpl extends DAO<CoursePointFile> implements CoursePointFileService {

    @Override
    public void addPointFile(int pointId, String filename) {
        String sql = "INSERT INTO CoursePointFile (pointId,filename) VALUES (?,?)";
        update(sql, pointId, filename);
    }

    @Override
    public long countFilename(int pointId, String filename) {
        String sql = "SELECT COUNT(pointId) FROM CoursePointFile WHERE pointId=? AND filename=?";
        return getForValue(sql, pointId, filename);
    }

    @Override
    public List<CoursePointFile> getFilesOfPoint(int pointId) {
        String sql = "SELECT * FROM CoursePointFile WHERE pointId=?";
        return getForList(sql, pointId);
    }

    @Override
    public void updatePointFile(int fileId, String filename) {
        String sql = "UPDATE CoursePointFile SET filename=? WHERE fileId=?";
        update(sql, filename, fileId);
    }

    public static void main(String[] args) {
        System.out.println(new CoursePointFileServiceImpl().countFilename(1, "video.mp4"));
    }
}

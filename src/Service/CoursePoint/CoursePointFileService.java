package Service.CoursePoint;

import Model.CoursePoint.CoursePointFile;

import java.util.List;

public interface CoursePointFileService {

    void addPointFile(int pointId, String filename);

    long countFilename(int pointId, String filename);

    List<CoursePointFile> getFilesOfPoint(int pointId);

    void updatePointFile(int fileId, String filename);
}

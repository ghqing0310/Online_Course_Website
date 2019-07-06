package Model.CoursePoint;

public class CoursePointFile {

    private int fileId;
    private int pointId;
    private String filename;

    public CoursePointFile(){}

    public CoursePointFile(int fileId, int pointId, String filename){
        this.fileId = fileId;
        this.pointId = pointId;
        this.filename = filename;
    }

    public int getFileId() {
        return fileId;
    }
    public void setFileId(int fileId) {
        this.fileId = fileId;
    }
    public int getPointId() {
        return pointId;
    }
    public void setPointId(int pointId) {
        this.pointId = pointId;
    }
    public String getFilename() {
        return filename;
    }
    public void setFilename(String filename) {
        this.filename = filename;
    }
}

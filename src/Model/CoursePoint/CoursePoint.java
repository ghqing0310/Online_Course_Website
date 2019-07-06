package Model.CoursePoint;

public class CoursePoint {
    private int pointId;
    private int chapterId;
    private int courseId;
    private String pointName;

    public CoursePoint(){}

    public CoursePoint(int pointId, int chapterId, int courseId, String pointName){
        this.pointId = pointId;
        this.chapterId = chapterId;
        this.courseId = courseId;
        this.pointName = pointName;
    }

    public int getPointId() {
        return pointId;
    }
    public void setPointId(int pointId) {
        this.pointId = pointId;
    }
    public int getChapterId() {
        return chapterId;
    }
    public void setChapterId(int chapterId) {
        this.chapterId = chapterId;
    }
    public int getCourseId() {
        return courseId;
    }
    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }
    public String getPointName() {
        return pointName;
    }
    public void setPointName(String pointName) {
        this.pointName = pointName;
    }
}

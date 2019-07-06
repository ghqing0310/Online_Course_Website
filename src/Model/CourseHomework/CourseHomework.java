package Model.CourseHomework;

public class CourseHomework {

    private int homeworkId;
    private int courseId;
    private String homeworkName;

    public CourseHomework(){}

    public CourseHomework(int homeworkId, int courseId, String homeworkName){
        this.homeworkId = homeworkId;
        this.courseId = courseId;
        this.homeworkName = homeworkName;
    }

    public int getHomeworkId() {
        return homeworkId;
    }
    public void setHomeworkId(int homeworkId) {
        this.homeworkId = homeworkId;
    }
    public int getCourseId() {
        return courseId;
    }
    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }
    public String getHomeworkName() {
        return homeworkName;
    }
    public void setHomeworkName(String homeworkName) {
        this.homeworkName = homeworkName;
    }
}

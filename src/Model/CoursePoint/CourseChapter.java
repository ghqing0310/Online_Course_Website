package Model.CoursePoint;

public class CourseChapter {
    private int chapterId;
    private int courseId;
    private String chapterName;

    public CourseChapter(){}

    public CourseChapter(int chapterId, int courseId, String chapterName){
        this.chapterId = chapterId;
        this.courseId = courseId;
        this.chapterName = chapterName;
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
    public String getChapterName() {
        return chapterName;
    }
    public void setChapterName(String chapterName) {
        this.chapterName = chapterName;
    }
}

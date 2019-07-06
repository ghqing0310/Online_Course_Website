package Model;

import java.sql.Timestamp;

public class Course {
    private int id;
    private String courseName;
    private String courseDescription;
    private String coursePicture;

    public Course(){}

    public Course(int id, String courseName, String courseDescription, String coursePicture){
        this.id = id;
        this.courseName = courseName;
        this.courseDescription = courseDescription;
        this.coursePicture = coursePicture;
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getCourseName() {
        return courseName;
    }
    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }
    public String getCourseDescription() {
        return courseDescription;
    }
    public void setCourseDescription(String courseDescription) {
        this.courseDescription = courseDescription;
    }
    public String getCoursePicture() {
        return coursePicture;
    }
    public void setCoursePicture(String coursePicture) {
        this.coursePicture = coursePicture;
    }
}

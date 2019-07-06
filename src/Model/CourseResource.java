package Model;

import java.util.List;

public class CourseResource {

    private int resourceId;
    private int courseId;
    private String resourceName;

    public CourseResource(){}

    public CourseResource(int resourceId, int courseId, String resourceName){
        this.resourceId = resourceId;
        this.courseId = courseId;
        this.resourceName = resourceName;
    }

    public int getResourceId() {
        return resourceId;
    }
    public void setResourceId(int resourceId) {
        this.resourceId = resourceId;
    }
    public int getCourseId() {
        return courseId;
    }
    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }
    public String getResourceName() {
        return resourceName;
    }
    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
    }
}

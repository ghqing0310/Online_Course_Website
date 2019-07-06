package Service.CourseResource;

import Model.CourseResource;

import java.util.List;

public interface CourseResourceService {

    void addResource(int courseId, String resourceName);

    List<CourseResource> getAllResourcesOfCourse(int courseId);

    CourseResource getResource(int resourceId);

    long countResourceName(int courseId, String resourceName);

    void updateResource(int resourceId, String resourceName);
}

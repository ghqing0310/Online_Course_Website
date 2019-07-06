package Service.CourseHomework;

import Model.CourseHomework.CourseHomework;

import java.util.List;

public interface CourseHomeworkService {

    void addHomework(int courseId, String homeworkName);

    CourseHomework getHomework(int homeworkId);

    List<CourseHomework> getHomeworksOfCourse(int courseId);

    long countHomeworkName(int courseId, String homeworkName);
}

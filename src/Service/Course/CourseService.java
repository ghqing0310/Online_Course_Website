package Service.Course;

import Model.Course;
import Service.CourseHomework.CourseHomeworkAnswerService;
import Service.CourseHomework.CourseHomeworkChoiceService;
import Service.CourseHomework.CourseHomeworkQuestionService;
import Service.CourseHomework.CourseHomeworkService;
import Service.CoursePoint.CourseChapterService;
import Service.CoursePoint.CoursePointFileService;
import Service.CoursePoint.CoursePointService;
import Service.CourseResource.CourseResourceService;

import java.util.List;

public interface CourseService extends CourseChapterService, CoursePointService, CoursePointFileService,
        CourseResourceService, CourseHomeworkService, CourseHomeworkChoiceService, CourseHomeworkQuestionService, CourseHomeworkAnswerService {

    //开课
    void openCourse(int userId, String courseName, String courseDescription, String coursePicture);

    //选课
    void chooseCourse(int userId, int courseId);

    //退课
    void dropCourse(int userId, int courseId);

    //判断该课程名是否已存在
    long countName(String courseName);

    //判断该用户是否已选择该课程
    long isChosen(int userId, int courseId);

    //判断该用户是否已开设该课程
    long isOpen(int userId, int courseId);

    //获取该用户开的所有课
    List<Course> getAllOpenCourses(int userId);

    //获取该用户选的所有课
    List<Course> getAllChooseCourses(int userId);

    //根据关键字、搜索方式和排序方式搜索课程
    List<Course> searchAndOrderCourses(String searchWords, String searchType, String searchOrder, int leaf);

    int getLeafNumber(String searchWords, String searchType, String searchOrder);

    //获取最热门的课程
    Course[] getHottestCourses();

    //获取最新开设的课程
    Course[] getNewestCourses();

    //获取该课程
    Course getCourse(int courseId);

}

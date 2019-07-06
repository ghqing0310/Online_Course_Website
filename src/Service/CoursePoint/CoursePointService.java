package Service.CoursePoint;

import Model.CoursePoint.CoursePoint;

import java.util.List;

public interface CoursePointService {

    //获取该章节的知识点列表
    List<CoursePoint> getCoursePoints(int chapterId);

    //为该章节添加知识点
    void addPointName(int chapterId, int courseId, String pointName);

    //判断该章节的知识点是否已经存在
    long countPointName(int chapterId, String pointName);

    //获取该知识点
    CoursePoint getCoursePoint(int pointId);

    //修改该知识点
    void updatePointName(int pointId, String pointName);
}

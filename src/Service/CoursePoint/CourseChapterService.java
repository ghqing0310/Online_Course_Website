package Service.CoursePoint;

import Model.CoursePoint.CourseChapter;

import java.util.List;

public interface CourseChapterService {

    //获取该课程的章节列表
    List<CourseChapter> getCourseChapters(int courseId);

    //为该课程添加章节
    void addChapterName(int courseId, String chapterName);

    //判断该课程的章节是否已经存在
    long countChapterName(int courseId, String chapterName);

    //修改该课程的章节
    void updateChapterName(int chapterId, String chapterName);

}

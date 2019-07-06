package Service.Course;

import DAO.DAO;
import Model.*;
import Model.CourseHomework.CourseHomework;
import Model.CourseHomework.CourseHomeworkAnswer;
import Model.CourseHomework.CourseHomeworkChoice;
import Model.CourseHomework.CourseHomeworkQuestion;
import Model.CoursePoint.CourseChapter;
import Model.CoursePoint.CoursePoint;
import Model.CoursePoint.CoursePointFile;
import Service.CourseHomework.*;
import Service.CoursePoint.*;
import Service.CourseResource.CourseResourceService;
import Service.CourseResource.CourseResourceServiceImpl;

import java.util.List;

public class CourseServiceImpl extends DAO<Course> implements CourseService{

    private CourseChapterService courseChapterService = new CourseChapterServiceImpl();
    private CoursePointService coursePointService = new CoursePointServiceImpl();
    private CoursePointFileService coursePointFileService = new CoursePointFileServiceImpl();
    private CourseResourceService courseResourceService = new CourseResourceServiceImpl();
    private CourseHomeworkService courseHomeworkService = new CourseHomeworkServiceImpl();
    private CourseHomeworkChoiceService courseHomeworkChoiceService = new CourseHomeworkChoiceServiceImpl();
    private CourseHomeworkQuestionService courseHomeworkQuestionService = new CourseHomeworkQuestionServiceImpl();
    private CourseHomeworkAnswerService courseHomeworkAnswerService = new CourseHomeworkAnswerServiceImpl();

    @Override
    public void openCourse(int userId, String courseName, String courseDescription, String coursePicture) {
        String sql = "INSERT INTO Course (courseName, courseDescription, coursePicture) VALUES (?,?,?)";
        update(sql, courseName, courseDescription, coursePicture);
        sql = "SELECT * FROM Course WHERE courseName=? AND courseDescription=? AND coursePicture=?";
        int courseId = get(sql, courseName, courseDescription, coursePicture).getId();
        sql = "INSERT INTO courseOpen (userId, courseId) VALUES (?,?)";
        update(sql, userId, courseId);
    }

    @Override
    public void chooseCourse(int userId, int courseId) {
        String sql = "INSERT INTO courseChoose (userId, courseId) VALUES (?,?)";
        update(sql, userId, courseId);
    }

    @Override
    public void dropCourse(int userId, int courseId) {
        String sql = "DELETE FROM CourseChoose WHERE userId=? AND courseId=?";
        update(sql, userId, courseId);
    }

    @Override
    public long countName(String courseName) {
        String sql = "SELECT COUNT(id) FROM Course WHERE courseName=?";
        return getForValue(sql, courseName);
    }

    @Override
    public long isChosen(int userId, int courseId) {
        String sql = "SELECT COUNT(userId) FROM CourseChoose WHERE userId=? AND courseId=?";
        return getForValue(sql, userId, courseId);
    }

    @Override
    public long isOpen(int userId, int courseId) {
        String sql = "SELECT COUNT(userId) FROM CourseOpen WHERE userId=? AND courseId=?";
        return getForValue(sql, userId, courseId);
    }

    @Override
    public List<Course> getAllOpenCourses(int userId) {
        String sql = "SELECT * FROM Course,CourseOpen WHERE Course.id=CourseOpen.courseId AND CourseOpen.userId=?";
        return getForList(sql, userId);
    }

    @Override
    public List<Course> getAllChooseCourses(int userId) {
        String sql = "SELECT * FROM Course,CourseChoose WHERE Course.id=CourseChoose.courseId AND CourseChoose.userId=?";
        return getForList(sql, userId);
    }

    @Override
    public List<Course> searchAndOrderCourses(String searchWords, String searchType, String searchOrder, int leaf) {
        switch (searchOrder){
            case "1":
                searchOrder = "DESC";
                break;
            case "2":
                searchOrder = "ASC";
        }
        String where = "";
        switch (searchType){
            case "1":
                where = "WHERE Course.courseName LIKE \"%" + searchWords + "%\"\n";
                break;
            case "2":
                where = "WHERE Course.courseDescription LIKE \"%" + searchWords + "%\"\n";
                break;
            case "3":
                where = "WHERE `User`.username LIKE \"%" + searchWords + "%\"\n";
        }
        String sql = "SELECT Course.id, \n" +
                "\tCourse.courseName, \n" +
                "\tCourse.courseDescription, \n" +
                "\tCourse.coursePicture, \n" +
                "\tCOUNT(CourseChoose.courseId) AS chooseCount, \n" +
                "\t`User`.username\n" +
                "FROM Course LEFT OUTER JOIN CourseChoose ON Course.id = CourseChoose.courseId\n" +
                "\t LEFT OUTER JOIN CourseOpen ON Course.id = CourseOpen.courseId\n" +
                "\t LEFT OUTER JOIN `User` ON CourseOpen.userId = `User`.id\n" +
                where +
                "GROUP BY Course.id\n" +
                "ORDER BY chooseCount " + searchOrder +
                " LIMIT ?,9";
        return getForList(sql, leaf * 9 - 9);
    }

    @Override
    public int getLeafNumber(String searchWords, String searchType, String searchOrder) {
        switch (searchOrder){
            case "1":
                searchOrder = "DESC";
                break;
            case "2":
                searchOrder = "ASC";
        }
        String where = "";
        switch (searchType){
            case "1":
                where = "WHERE Course.courseName LIKE \"%" + searchWords + "%\"\n";
                break;
            case "2":
                where = "WHERE Course.courseDescription LIKE \"%" + searchWords + "%\"\n";
                break;
            case "3":
                where = "WHERE `User`.username LIKE \"%" + searchWords + "%\"\n";
        }
        String sql = "SELECT Course.id, \n" +
                "\tCourse.courseName, \n" +
                "\tCourse.courseDescription, \n" +
                "\tCourse.coursePicture, \n" +
                "\tCOUNT(CourseChoose.courseId) AS chooseCount, \n" +
                "\t`User`.username\n" +
                "FROM Course LEFT OUTER JOIN CourseChoose ON Course.id = CourseChoose.courseId\n" +
                "\t LEFT OUTER JOIN CourseOpen ON Course.id = CourseOpen.courseId\n" +
                "\t LEFT OUTER JOIN `User` ON CourseOpen.userId = `User`.id\n" +
                where +
                "GROUP BY Course.id\n" +
                "ORDER BY chooseCount " + searchOrder;
        int size = getForList(sql).size();
        return size % 9 == 0 ? size / 9 : (size / 9 + 1);
    }

    @Override
    public Course[] getHottestCourses() {
        Course[] courses = new Course[3];
        List<Course> courseList = searchAndOrderCourses("", "1", "1", 1);
        for (int i = 0; i < 3; i++){
            courses[i] = courseList.get(i);
        }
        return courses;
    }

    @Override
    public Course[] getNewestCourses() {
        String sql = "SELECT * FROM Course ORDER BY id DESC LIMIT 0,3";
        return getForList(sql).toArray(new Course[3]);
    }

    @Override
    public Course getCourse(int courseId) {
        String sql = "SELECT * FROM Course WHERE id=?";
        return get(sql, courseId);
    }

    public static void main(String[] args) {
        System.out.println(new CourseServiceImpl().searchAndOrderCourses("","1","1", 100).size());
    }

    @Override
    public List<CourseChapter> getCourseChapters(int courseId) {
        return courseChapterService.getCourseChapters(courseId);
    }

    @Override
    public void addChapterName(int courseId, String chapterName) {
        courseChapterService.addChapterName(courseId, chapterName);
    }

    @Override
    public long countChapterName(int courseId, String chapterName) {
        return courseChapterService.countChapterName(courseId, chapterName);
    }

    @Override
    public void updateChapterName(int chapterId, String chapterName) {
        courseChapterService.updateChapterName(chapterId, chapterName);
    }

    @Override
    public List<CoursePoint> getCoursePoints(int chapterId) {
        return coursePointService.getCoursePoints(chapterId);
    }

    @Override
    public void addPointName(int chapterId, int courseId, String pointName) {
        coursePointService.addPointName(chapterId, courseId, pointName);
    }

    @Override
    public long countPointName(int chapterId, String pointName) {
        return coursePointService.countPointName(chapterId, pointName);
    }

    @Override
    public CoursePoint getCoursePoint(int pointId) {
        return coursePointService.getCoursePoint(pointId);
    }

    @Override
    public void updatePointName(int pointId, String pointName) {
        coursePointService.updatePointName(pointId, pointName);
    }

    @Override
    public void addPointFile(int pointId, String filename) {
        coursePointFileService.addPointFile(pointId, filename);
    }

    @Override
    public long countFilename(int pointId, String filename) {
        return coursePointFileService.countFilename(pointId, filename);
    }

    @Override
    public List<CoursePointFile> getFilesOfPoint(int pointId) {
        return coursePointFileService.getFilesOfPoint(pointId);
    }

    @Override
    public void updatePointFile(int fileId, String filename) {
        coursePointFileService.updatePointFile(fileId, filename);
    }

    @Override
    public void addResource(int courseId, String resourceName) {
        courseResourceService.addResource(courseId, resourceName);
    }

    @Override
    public List<CourseResource> getAllResourcesOfCourse(int courseId) {
        return courseResourceService.getAllResourcesOfCourse(courseId);
    }

    @Override
    public CourseResource getResource(int resourceId) {
        return courseResourceService.getResource(resourceId);
    }

    @Override
    public long countResourceName(int courseId, String resourceName) {
        return courseResourceService.countResourceName(courseId, resourceName);
    }

    @Override
    public void updateResource(int resourceId, String resourceName) {
        courseResourceService.updateResource(resourceId, resourceName);
    }

    @Override
    public void addHomework(int courseId, String homeworkName) {
        courseHomeworkService.addHomework(courseId, homeworkName);
    }

    @Override
    public CourseHomework getHomework(int homeworkId) {
        return courseHomeworkService.getHomework(homeworkId);
    }

    @Override
    public List<CourseHomework> getHomeworksOfCourse(int courseId) {
        return courseHomeworkService.getHomeworksOfCourse(courseId);
    }

    @Override
    public long countHomeworkName(int courseId, String homeworkName) {
        return courseHomeworkService.countHomeworkName(courseId, homeworkName);
    }

    @Override
    public void addChoice(int homeworkId, String question, String answerA, String answerB, String answerC, String rightAnswer) {
        courseHomeworkChoiceService.addChoice(homeworkId, question, answerA, answerB, answerC, rightAnswer);
    }

    @Override
    public void updateChoice(int homeworkId, int choiceId, String question, String answerA, String answerB, String answerC, String rightAnswer) {
        courseHomeworkChoiceService.updateChoice(homeworkId, choiceId, question, answerA, answerB, answerC, rightAnswer);
    }

    @Override
    public long countChoice(int homeworkId, String question) {
        return courseHomeworkChoiceService.countChoice(homeworkId, question);
    }

    @Override
    public List<CourseHomeworkChoice> getChoicesOfHomework(int homeworkId) {
        return courseHomeworkChoiceService.getChoicesOfHomework(homeworkId);
    }

    @Override
    public CourseHomeworkChoice getChoice(int choiceId) {
        return courseHomeworkChoiceService.getChoice(choiceId);
    }

    @Override
    public void addQuestion(int homeworkId, String question) {
        courseHomeworkQuestionService.addQuestion(homeworkId, question);
    }

    @Override
    public void updateQuestion(int homeworkId, int questionId, String question) {
        courseHomeworkQuestionService.updateQuestion(homeworkId, questionId, question);
    }

    @Override
    public long countQuestion(int homeworkId, String question) {
        return courseHomeworkQuestionService.countQuestion(homeworkId, question);
    }

    @Override
    public List<CourseHomeworkQuestion> getQuestionsOfHomework(int homeworkId) {
        return courseHomeworkQuestionService.getQuestionsOfHomework(homeworkId);
    }

    @Override
    public CourseHomeworkQuestion gerQuestion(int questionId) {
        return courseHomeworkQuestionService.gerQuestion(questionId);
    }

    @Override
    public void addAnswer(int questionId, int homeworkId, int userId, String answer, String type) {
        courseHomeworkAnswerService.addAnswer(questionId, homeworkId, userId, answer, type);
    }

    @Override
    public List<CourseHomeworkAnswer> getAnswersOfHomework(int homeworkId, int userId) {
        return courseHomeworkAnswerService.getAnswersOfHomework(homeworkId, userId);
    }

    @Override
    public List<CourseHomeworkAnswer> getAnswersOfQuestion(int questionId, String type) {
        return courseHomeworkAnswerService.getAnswersOfQuestion(questionId, type);
    }

    @Override
    public CourseHomeworkAnswer getAnswer(int questionId, int userId, String type) {
        return courseHomeworkAnswerService.getAnswer(questionId, userId, type);
    }
}

package Servlet;

import Model.Course;
import Model.User;
import Service.Course.CourseService;
import Service.Course.CourseServiceImpl;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.lang.reflect.Method;
import java.util.List;

@WebServlet("*.course")
public class CourseServlet extends HttpServlet {

    private CourseService courseService = new CourseServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp){
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp){
        String servletPath = req.getServletPath();
        String methodName = servletPath.substring(1, servletPath.length() - 7);

        try {
            Method method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
            method.invoke(this, req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void openCourse(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        int userId = ((User)session.getAttribute("user")).getId();
        String courseName = "";
        String courseDescription = "";
        String coursePicture = "";
        String address = "";
        String path = "pic";
        List<FileItem> items = getUpload(path).parseRequest(req);
        for (FileItem item: items){
            if (item.isFormField()){
                String name = item.getFieldName();
                String value = new String(item.getString().getBytes("ISO-8859-1"),"UTF-8");
                switch (name){
                    case "courseName":
                        courseName = value;
                        break;
                    case "courseDescription":
                        courseDescription = value;
                        break;
                }
                if (courseService.countName(courseName) > 0){
                    req.setAttribute("message", "courseNameExist");
                    address = "openCourse.jsp";
                    break;
                }
            } else {
                coursePicture = item.getName();
                upload(item, path, coursePicture);
            }
            if (item == items.get(items.size() - 1)){
                courseService.openCourse(userId, courseName, courseDescription, coursePicture);
                address = "information.jsp?navigator=openCourse";
            }
        }
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void chooseCourse(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        int userId = ((User)session.getAttribute("user")).getId();
        int courseId = Integer.parseInt(req.getParameter("courseId"));
        String address = req.getParameter("address");
        courseService.chooseCourse(userId, courseId);
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void dropCourse(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User user = ((User)session.getAttribute("user"));
        int userId = user.getId();
        String password = user.getPassword();
        String passwordInput = req.getParameter("password");
        int courseId = Integer.parseInt(req.getParameter("courseId"));
        String address = req.getParameter("address");
        if (password.equals(passwordInput)) {
            courseService.dropCourse(userId, courseId);
        } else {
            req.setAttribute("message", "passwordWrong");
        }
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void search(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        req.setCharacterEncoding("UTF-8");
        String searchWords = req.getParameter("searchWords");
        String searchType = req.getParameter("searchType");
        List<Course> courses = courseService.searchAndOrderCourses(searchWords, searchType, "1", 1);
        req.setAttribute("courses", courses);
        String address = "search.jsp";
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void addChapterName(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        req.setCharacterEncoding("UTF-8");
        int courseId = Integer.parseInt(req.getParameter("courseId"));
        String chapterName = req.getParameter("chapterName");
        if (courseService.countChapterName(courseId, chapterName) > 0){
            req.setAttribute("message", "chapterNameExist");
        } else {
            courseService.addChapterName(courseId, chapterName);
        }
        String address = "courseDetail.jsp";
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void addPointName(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        req.setCharacterEncoding("UTF-8");
        int courseId = Integer.parseInt(req.getParameter("courseId"));
        int chapterId = Integer.parseInt(req.getParameter("chapterId"));
        String pointName = req.getParameter("pointName");
        if (courseService.countPointName(chapterId, pointName) > 0){
            req.setAttribute("message", "pointNameExist");
        } else {
            courseService.addPointName(chapterId, courseId, pointName);
        }
        String address = "courseDetail.jsp";
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void updatePointName(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        req.setCharacterEncoding("UTF-8");
        int courseId = Integer.parseInt(req.getParameter("courseId"));
        int pointId = Integer.parseInt(req.getParameter("pointId"));
        int chapterId = Integer.parseInt(req.getParameter("chapterId"));
        String pointName = req.getParameter("pointName");
        if (courseService.countPointName(chapterId, pointName) > 0){
            req.setAttribute("message", "pointNameExist");
        } else {
            courseService.updatePointName(pointId, pointName);
        }
        String address = "coursePoint.jsp";
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void updateChapterName(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        req.setCharacterEncoding("UTF-8");
        int courseId = Integer.parseInt(req.getParameter("courseId"));
        int chapterId = Integer.parseInt(req.getParameter("chapterId"));
        String chapterName = req.getParameter("chapterName");
        if (courseService.countChapterName(courseId, chapterName) > 0){
            req.setAttribute("message", "chapterNameExist");
        } else {
            courseService.updateChapterName(chapterId, chapterName);
        }
        String address = "courseDetail.jsp";
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void order(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        req.setCharacterEncoding("UTF-8");
        String searchWords = req.getParameter("searchWords");
        String searchType = req.getParameter("searchType");
        String searchOrder = req.getParameter("searchOrder");
        List<Course> courses = courseService.searchAndOrderCourses(searchWords, searchType, searchOrder, 1);
        req.setAttribute("courses", courses);
        String address = "search.jsp";
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void leaf(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        req.setCharacterEncoding("UTF-8");
        String searchWords = req.getParameter("searchWords");
        String searchType = req.getParameter("searchType");
        String searchOrder = req.getParameter("searchOrder");
        int leaf = Integer.parseInt(req.getParameter("leaf"));
        List<Course> courses = courseService.searchAndOrderCourses(searchWords, searchType, searchOrder, leaf);
        req.setAttribute("courses", courses);
        String address = "search.jsp";
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void uploadPointFile(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        req.setCharacterEncoding("UTF-8");
        int pointId = 0;
        int courseId = 0;
        String filename = "";
        String path = "vid";
        List<FileItem> items = getUpload(path).parseRequest(req);
        for (FileItem item: items){
            if (item.isFormField()){
                String name = item.getFieldName();
                String value = new String(item.getString().getBytes("ISO-8859-1"),"UTF-8");
                switch (name){
                    case "pointId":
                        pointId = Integer.parseInt(value);
                        break;
                    case "courseId":
                        courseId = Integer.parseInt(value);
                }
            } else {
                filename = item.getName();
                upload(item, path, filename);
            }
            if (item == items.get(items.size() - 1)){
                if (courseService.countFilename(pointId, filename) > 0){
                    req.setAttribute("message", "filenameExist");
                    break;
                }
                if (!(filename.contains(".mp4") || filename.contains(".pdf"))){
                    req.setAttribute("message", "fileWrong");
                    break;
                }
                courseService.addPointFile(pointId, filename);
            }
        }
        String address = "coursePoint.jsp?courseId=" + courseId + "&pointId=" + pointId;
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void updatePointFile(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        req.setCharacterEncoding("UTF-8");
        int pointId = 0;
        int courseId = 0;
        int fileId = 0;
        String filename = "";
        String path = "vid";
        List<FileItem> items = getUpload(path).parseRequest(req);
        for (FileItem item: items){
            if (item.isFormField()){
                String name = item.getFieldName();
                String value = new String(item.getString().getBytes("ISO-8859-1"),"UTF-8");
                switch (name){
                    case "fileId":
                        fileId = Integer.parseInt(value);
                        break;
                    case "pointId":
                        pointId = Integer.parseInt(value);
                        break;
                    case "courseId":
                        courseId = Integer.parseInt(value);
                }
            } else {
                filename = item.getName();
                upload(item, path, filename);
            }
            if (item == items.get(items.size() - 1)){
                if (courseService.countFilename(pointId, filename) > 0){
                    req.setAttribute("message", "filenameExist");
                    break;
                }
                if (!(filename.contains(".mp4") || filename.contains(".pdf"))){
                    req.setAttribute("message", "fileWrong");
                    break;
                }
                courseService.updatePointFile(fileId, filename);
            }
        }
        String address = "coursePoint.jsp?courseId=" + courseId + "&pointId=" + pointId;
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void addResource(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        req.setCharacterEncoding("UTF-8");
        int courseId = 0;
        String resourceName = "";
        String path = "res";
        List<FileItem> items = getUpload(path).parseRequest(req);
        for (FileItem item: items){
            if (item.isFormField()){
                String name = item.getFieldName();
                String value = new String(item.getString().getBytes("ISO-8859-1"),"UTF-8");
                switch (name){
                    case "courseId":
                        courseId = Integer.parseInt(value);
                        break;
                }
            } else {
                resourceName = item.getName();
                upload(item, path, resourceName);
            }
            if (item == items.get(items.size() - 1)){
                if (courseService.countResourceName(courseId, resourceName) > 0){
                    req.setAttribute("message", "resourceNameExist");
                    break;
                }
                courseService.addResource(courseId, resourceName);
            }
        }
        String address = "courseResource.jsp?courseId=" + courseId;
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void downloadResource(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        int resourceId = Integer.parseInt(req.getParameter("resourceId"));
        String filename = courseService.getResource(resourceId).getResourceName();
        String configPath = "/Users/ghqing/Downloads/apache-tomcat-8.5.32/bin/res";
        filename = String.format("%s/%s", configPath, filename);
        String contentDisposition = "attachment;filename=" + new String(filename.getBytes("utf-8"), "iso8859-1");
        FileInputStream input = new FileInputStream(filename);
        resp.setHeader("Content-Disposition",  contentDisposition);
        resp.setContentType("application/octet-stream");
        byte[] buffer = new byte[1024];
        int nRead;
        BufferedOutputStream os = new BufferedOutputStream(resp.getOutputStream());
        while ((nRead = input.read(buffer, 0, 1024)) > 0) { // bis为网络输入流
            os.write(buffer, 0, nRead);
        }
        input.close();
        os.flush();
        os.close();
    }

    private void updateResource(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        req.setCharacterEncoding("UTF-8");
        int courseId = 0;
        int resourceId = 0;
        String resourceName = "";
        String path = "res";
        List<FileItem> items = getUpload(path).parseRequest(req);
        for (FileItem item: items){
            if (item.isFormField()){
                String name = item.getFieldName();
                String value = new String(item.getString().getBytes("ISO-8859-1"),"UTF-8");
                switch (name){
                    case "courseId":
                        courseId = Integer.parseInt(value);
                        break;
                    case "resourceId":
                        resourceId = Integer.parseInt(value);
                        break;
                }
            } else {
                resourceName = item.getName();
                upload(item, path, resourceName);
            }
            if (item == items.get(items.size() - 1)){
                if (courseService.countResourceName(courseId, resourceName) > 0){
                    req.setAttribute("message", "resourceNameExist");
                    break;
                }
                courseService.updateResource(resourceId, resourceName);
            }
        }
        String address = "courseResource.jsp?courseId=" + courseId;
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void addHomework(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        req.setCharacterEncoding("UTF-8");
        int courseId = Integer.parseInt(req.getParameter("courseId"));
        String homeworkName = req.getParameter("homeworkName");
        if (courseService.countHomeworkName(courseId, homeworkName) > 0){
            req.setAttribute("message", "homeworkNameExist");
        } else {
            courseService.addHomework(courseId, homeworkName);
        }
        String address = "courseHomework.jsp";
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void addChoice(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        req.setCharacterEncoding("UTF-8");
        int homeworkId = Integer.parseInt(req.getParameter("homeworkId"));
        String question = req.getParameter("choiceQuestion");
        String answerA = req.getParameter("answerA");
        String answerB = req.getParameter("answerB");
        String answerC = req.getParameter("answerC");
        String rightAnswer = req.getParameter("rightAnswer");
        if (courseService.countChoice(homeworkId, question) > 0){
            req.setAttribute("message", "homeworkChoiceExist");
        } else {
            courseService.addChoice(homeworkId, question, answerA, answerB, answerC, rightAnswer);
        }
        String address = "courseHomeworkDetail.jsp";
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void updateChoice(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        req.setCharacterEncoding("UTF-8");
        int homeworkId = Integer.parseInt(req.getParameter("homeworkId"));
        int choiceId = Integer.parseInt(req.getParameter("choiceId"));
        String questionOld = req.getParameter("questionOld");
        String question = req.getParameter("choiceQuestion");
        String answerA = req.getParameter("answerA");
        String answerB = req.getParameter("answerB");
        String answerC = req.getParameter("answerC");
        String rightAnswer = req.getParameter("rightAnswer");
        if (courseService.countChoice(homeworkId, question) > 0 && !question.equals(questionOld)){
            req.setAttribute("message", "homeworkChoiceExist");
        } else {
            courseService.updateChoice(homeworkId, choiceId, question, answerA, answerB, answerC, rightAnswer);
        }
        String address = "courseHomeworkDetail.jsp";
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void addQuestion(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        req.setCharacterEncoding("UTF-8");
        int homeworkId = Integer.parseInt(req.getParameter("homeworkId"));
        String question = req.getParameter("question");
        if (courseService.countQuestion(homeworkId, question) > 0){
            req.setAttribute("message", "homeworkQuestionExist");
        } else {
            courseService.addQuestion(homeworkId, question);
        }
        String address = "courseHomeworkDetail.jsp";
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void updateQuestion(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        req.setCharacterEncoding("UTF-8");
        int homeworkId = Integer.parseInt(req.getParameter("homeworkId"));
        int questionId = Integer.parseInt(req.getParameter("questionId"));
        String question = req.getParameter("question");
        String questionOld = req.getParameter("questionOld");
        if (courseService.countQuestion(homeworkId, question) > 0 && !question.equals(questionOld)){
            req.setAttribute("message", "homeworkQuestionExist");
        } else {
            courseService.updateQuestion(homeworkId, questionId, question);
        }
        String address = "courseHomeworkDetail.jsp";
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void addAnswer(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        int userId = ((User)session.getAttribute("user")).getId();
        int homeworkId = Integer.parseInt(req.getParameter("homeworkId"));
        int questionId;
        String answer;
        int choiceNumber = Integer.parseInt(req.getParameter("choiceNumber"));
        int questionNumber = Integer.parseInt(req.getParameter("questionNumber"));
        for (int i = 1; i <= choiceNumber; i++){
            questionId = Integer.parseInt(req.getParameter("choiceId" + i));
            answer = req.getParameter("choice" + i);
            courseService.addAnswer(questionId, homeworkId, userId, answer, "单选题");
        }
        for (int i = 1; i <= questionNumber; i++){
            questionId = Integer.parseInt(req.getParameter("questionId" + i));
            answer = req.getParameter("answer" + i);
            courseService.addAnswer(questionId, homeworkId, userId, answer, "简答题");
        }
        String address = "courseHomeworkDetail.jsp";
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void showPicture(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        String coursePicture = req.getParameter("coursePicture");
        String configPath = "/Users/ghqing/Downloads/apache-tomcat-8.5.32/bin/pic";
        coursePicture = String.format("%s/%s", configPath, coursePicture);
        String contentType = this.getServletContext().getMimeType(coursePicture);
        String contentDisposition = "attachment;filename=" + coursePicture;
        FileInputStream input = new FileInputStream(coursePicture);
        resp.setHeader("Content-Type", contentType);
        resp.setHeader("Content-Deposition",  contentDisposition);
        byte[] buffer = new byte[1024];
        int nRead;
        BufferedOutputStream os = new BufferedOutputStream(resp.getOutputStream());
        while ((nRead = input.read(buffer, 0, 1024)) > 0) { // bis为网络输入流
            os.write(buffer, 0, nRead);
        }
        input.close();
        os.flush();
        os.close();
        input.close();
    }

    private void showVideo(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        req.setCharacterEncoding("UTF-8");
        String filename = req.getParameter("filename");
        String configPath = "/Users/ghqing/Downloads/apache-tomcat-8.5.32/bin/vid";
        filename = String.format("%s/%s", configPath, filename);
        String contentType = this.getServletContext().getMimeType(filename);
        String contentDisposition = "attachment;filename=" + filename;
        FileInputStream input = new FileInputStream(filename);
        resp.setHeader("Content-Type", contentType);
        resp.setHeader("Content-Deposition",  contentDisposition);
        IOUtils.copy(input, resp.getOutputStream());
        input.close();
    }

    private ServletFileUpload getUpload(String path){
        DiskFileItemFactory factory = new DiskFileItemFactory();
        File directory = new File(path);
        factory.setRepository(directory);
        return new ServletFileUpload(factory);
    }

    private void upload(FileItem item, String path, String filename) throws Exception {
        InputStream inputStream = item.getInputStream();
        byte[] buffer = new byte[1024];
        int len;
        OutputStream outputStream = new FileOutputStream(path + "/" + filename);
        while ((len = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, len);
        }
        outputStream.close();
        inputStream.close();
    }
}

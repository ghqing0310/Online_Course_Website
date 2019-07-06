package Service.CourseResource;

import DAO.DAO;
import Model.CourseResource;

import java.util.List;

public class CourseResourceServiceImpl extends DAO<CourseResource> implements CourseResourceService {

    @Override
    public void addResource(int courseId, String resourceName) {
        String sql = "INSERT INTO CourseResource (courseId,resourceName) VALUES (?,?)";
        update(sql, courseId, resourceName);
    }

    @Override
    public List<CourseResource> getAllResourcesOfCourse(int courseId) {
        String sql = "SELECT * FROM CourseResource WHERE courseId=?";
        return getForList(sql, courseId);
    }

    @Override
    public CourseResource getResource(int resourceId) {
        String sql = "SELECT * FROM CourseResource WHERE resourceId=?";
        return get(sql, resourceId);
    }

    @Override
    public long countResourceName(int courseId, String resourceName) {
        String sql = "SELECT COUNT(resourceId) FROM CourseResource WHERE courseId=? AND resourceName=?";
        return getForValue(sql, courseId, resourceName);
    }

    @Override
    public void updateResource(int resourceId, String resourceName) {
        String sql = "UPDATE CourseResource SET resourceName=? WHERE resourceId=?";
        update(sql, resourceName, resourceId);
    }

    public static void main(String[] args) {
        System.out.println(new CourseResourceServiceImpl().countResourceName(1,"q"));
    }
}

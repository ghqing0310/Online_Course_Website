package Service.CourseHomework;

import Model.CourseHomework.CourseHomeworkChoice;

import java.util.List;

public interface CourseHomeworkChoiceService {

    void addChoice(int homeworkId, String question, String answerA, String answerB, String answerC, String rightAnswer);

    void updateChoice(int homeworkId, int choiceId, String question, String answerA, String answerB, String answerC, String rightAnswer);

    long countChoice(int homeworkId, String question);

    List<CourseHomeworkChoice> getChoicesOfHomework(int homeworkId);

    CourseHomeworkChoice getChoice(int choiceId);
}

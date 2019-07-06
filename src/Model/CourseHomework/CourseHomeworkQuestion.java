package Model.CourseHomework;

public class CourseHomeworkQuestion {

    private int questionId;
    private int homeworkId;
    private String question;

    public CourseHomeworkQuestion(){}

    public CourseHomeworkQuestion(int questionId, int homeworkId, String question){
        this.questionId = questionId;
        this.homeworkId = homeworkId;
        this.question = question;
    }

    public int getQuestionId() {
        return questionId;
    }
    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }
    public int getHomeworkId() {
        return homeworkId;
    }
    public void setHomeworkId(int homeworkId) {
        this.homeworkId = homeworkId;
    }
    public String getQuestion() {
        return question;
    }
    public void setQuestion(String question) {
        this.question = question;
    }
}

package Model.CourseHomework;

public class CourseHomeworkAnswer {

    private int answerId;
    private int questionId;
    private int homeworkId;
    private int userId;
    private String answer;
    private String type;

    public CourseHomeworkAnswer(){}

    public CourseHomeworkAnswer(int answerId, int questionId, int homeworkId, int userId, String answer, String type){
        this.answerId = answerId;
        this.questionId = questionId;
        this.homeworkId = homeworkId;
        this.userId = userId;
        this.answer = answer;
        this.type = type;
    }

    public int getAnswerId() {
        return answerId;
    }
    public void setAnswerId(int answerId) {
        this.answerId = answerId;
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
    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public String getAnswer() {
        return answer;
    }
    public void setAnswer(String answer) {
        this.answer = answer;
    }
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
}

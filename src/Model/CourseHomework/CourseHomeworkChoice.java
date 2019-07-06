package Model.CourseHomework;

public class CourseHomeworkChoice {

    private int choiceId;
    private int homeworkId;
    private String question;
    private String answerA;
    private String answerB;
    private String answerC;
    private String rightAnswer;

    public CourseHomeworkChoice(){}

    public CourseHomeworkChoice(int choiceId, int homeworkId, String question, String answerA, String answerB, String answerC,
                                String rightAnswer){
        this.choiceId = choiceId;
        this.homeworkId = homeworkId;
        this.question = question;
        this.answerA = answerA;
        this.answerB = answerB;
        this.answerC = answerC;
        this.rightAnswer = rightAnswer;
    }

    public int getChoiceId() {
        return choiceId;
    }
    public void setChoiceId(int choiceId) {
        this.choiceId = choiceId;
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
    public String getAnswerA() {
        return answerA;
    }
    public void setAnswerA(String answerA) {
        this.answerA = answerA;
    }
    public String getAnswerB() {
        return answerB;
    }
    public void setAnswerB(String answerB) {
        this.answerB = answerB;
    }
    public String getAnswerC() {
        return answerC;
    }
    public void setAnswerC(String answerC) {
        this.answerC = answerC;
    }
    public String getRightAnswer() {
        return rightAnswer;
    }
    public void setRightAnswer(String rightAnswer) {
        this.rightAnswer = rightAnswer;
    }
}

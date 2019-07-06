package Servlet;

import Service.User.UserService;
import Service.User.UserServiceImpl;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.Properties;
import java.util.Random;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import Model.User;

@WebServlet("*.user")
public class UserServlet extends HttpServlet{

    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp){
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp){
        String servletPath = req.getServletPath();
        String methodName = servletPath.substring(1, servletPath.length() - "user".length() - 1);
        try {
            Method method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
            method.invoke(this, req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void login(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        HttpSession session = req.getSession();
        String address;
        User user = userService.login(username, password);
        if (user == null){
            req.setAttribute("message", "error");
            address = "login.jsp";
            req.getRequestDispatcher(address).forward(req, resp);
        } else {
            session.setAttribute("user", user);
            address = "home.jsp";
            resp.sendRedirect(address);
        }
    }

    private void register(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String type = req.getParameter("type");
        HttpSession session = req.getSession();
        String address = "";
        if (userService.countName(username) > 0){
            req.setAttribute("message", "usernameExist");
            address = "register.jsp";
            req.getRequestDispatcher(address).forward(req, resp);
        } else {
            User user = userService.register(username, password, type);
            session.setAttribute("user", user);
            address = "mailVerify.jsp";
            resp.sendRedirect(address);
        }
    }

    private void quit(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        HttpSession session = req.getSession();
        session.setAttribute("user", null);
        String address = "home.jsp";
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void mail(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String myEmailAccount = "registerMail1@163.com";
        String myEmailPassword = "zaqw1234";
        String receiveMailAccount = req.getParameter("mail");
        int mailActiveCode = new Random().nextInt(900) + 100;
        String myEmailSMTPHost = "smtp.163.com";

        // 1. 创建参数配置, 用于连接邮件服务器的参数配置
        Properties props = new Properties();                    // 参数配置
        props.setProperty("mail.transport.protocol", "smtp");   // 使用的协议（JavaMail规范要求）
        props.setProperty("mail.smtp.host", myEmailSMTPHost);   // 发件人的邮箱的 SMTP 服务器地址
        props.setProperty("mail.smtp.auth", "true");            // 需要请求认证
        //你自己的邮箱
        props.put("mail.user", myEmailAccount);
        //你开启pop3/smtp时的验证码
        props.put("mail.password", myEmailPassword);

        // 2. 根据配置创建会话对象, 用于和邮件服务器交互
        Session session = Session.getDefaultInstance(props);
        MimeMessage message = createMimeMessage(session, myEmailAccount, receiveMailAccount, mailActiveCode);
        Transport transport = session.getTransport();
        transport.connect(myEmailAccount, myEmailPassword);
        transport.sendMessage(message, message.getAllRecipients());

        // 3. 关闭连接
        transport.close();
        req.getSession().setAttribute("codeSend", mailActiveCode);
        String address = "codeVerify.jsp";
        req.getRequestDispatcher(address).forward(req, resp);
    }

    private void code(HttpServletRequest req, HttpServletResponse resp) throws Exception{
        int codeSend = (int)req.getSession().getAttribute("codeSend");
        int code = Integer.parseInt(req.getParameter("code"));
        String address = "";
        if (codeSend == code){
            address = "home.jsp";
        } else {
            address = "codeVerify.jsp";
            req.setAttribute("message", "codeWrong");
        }
        req.getRequestDispatcher(address).forward(req, resp);
    }

    /**
     * 创建一封只包含文本的简单邮件
     *
     * @param session 和服务器交互的会话
     * @param sendMail 发件人邮箱
     * @param receiveMail 收件人邮箱
     * @param mailActiveCode
     * @return
     * @throws Exception
     */
    private MimeMessage createMimeMessage(Session session, String sendMail,
                                          String receiveMail, int mailActiveCode) throws Exception {
        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(sendMail, "课程网", "UTF-8"));
        message.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(receiveMail, "用户", "UTF-8"));
        message.setSubject("激活邮件", "UTF-8");
        message.setContent("尊敬的用户，您好！验证码是" + mailActiveCode + "。", "text/html;charset=UTF-8");
        message.setSentDate(new Date());
        message.saveChanges();

        return message;
    }
}

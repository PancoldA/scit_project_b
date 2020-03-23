package global.sesoc.wareware.dao;



import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;


@Service
public class MailSendService {

    @Autowired
    private JavaMailSender mailSender;


    public void mailSendWithUserKey(@Param("user_email") String user_email, @Param("user_emailauthkey") String user_emailauthkey, HttpServletRequest request) {
    	
        MimeMessage mail = mailSender.createMimeMessage();
        String htmlStr = "<h2>안녕하세요  FindJob 입니다.</h2><br><br>"
                + "회원님의 인증번호 키는 <b> " + user_emailauthkey + "</b> 입니다.<br>"
                + "(혹시 잘못 전달된 메일이라면 이 이메일을 무시하셔도 됩니다)";
        try {
            mail.setSubject("[인증] FindJob 취업지원 사이트의 인증메일입니다", "utf-8");
            mail.setText(htmlStr, "utf-8", "html");
            mail.addRecipient(RecipientType.TO, new InternetAddress(user_email));
            mailSender.send(mail);
        } catch (MessagingException e) {
            e.printStackTrace();
        }

    }


    public void tempkey_submit(@Param("user_email") String user_email, @Param("key") String key, HttpServletRequest request) {

        MimeMessage mail = mailSender.createMimeMessage();
        String htmlStr = "<h2>안녕하세요 FindJob 입니다.</h2><br><br>"
                + "<p>회원님의 임시비밀번호는 <b> " + key + "</b> 입니다 . 로그인 하신후 마이페이지 -> 정보수정 페이지에서 비밀번호를 변경해주시기 바랍니다. <p>"
                + "(혹시 잘못 전달된 메일이라면 이 이메일을 무시하셔도 됩니다)";
        try {
            mail.setSubject("FindJob 취업지원 사이트 회원님의 임시 비밀번호입니다.", "utf-8");
            mail.setText(htmlStr, "utf-8", "html");
            mail.addRecipient(RecipientType.TO, new InternetAddress(user_email));
            mailSender.send(mail);
        } catch (MessagingException e) {
            e.printStackTrace();
        }

    }

}
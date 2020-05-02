package global.sesoc.wareware.controllers;

import java.util.UUID;

import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MailController {

	@Autowired
	JavaMailSender mailSender;

	private static final Logger logger = LoggerFactory.getLogger(MailController.class);

	@PostMapping("/mailSend")
	public String mailSend(String user_email) {

		logger.info("MailRestContoller's GET mailSend Method");
		
		// UUID 난수르 이용한 인증 키 생성
		String authorizationKey = UUID.randomUUID().toString();

		// 메일 발송 시 보낼 메세지 작성

		String text = "<h1>Hello! Friend!</h1>";
		text += "<br>We are Team Wareware!";
		text += "<br>Thanks for join us!";
		text += "<br><br>" + authorizationKey + "<br><br>";
		text += "<br>This is authorizationKey";
		text += "<br>Thank You!";

		MimeMessage message = mailSender.createMimeMessage();

		try {

			message.setFrom("scitproject001@gmail.com");
			message.addRecipient(RecipientType.TO, new InternetAddress(user_email));
			message.setSubject("We are Team Wareware! Thanks for join us!");
			message.setText(text, "utf-8", "html");
			mailSender.send(message);
			return authorizationKey;

		} catch (MessagingException e) {

			e.printStackTrace();
			logger.info("MailRestContoller's GET mailSend Method Exception");
			return "";
		}

	}

}

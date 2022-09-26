package kh.project4.mealchelin.member;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;


@Component
public class MailSendService {

	@Autowired
	private JavaMailSenderImpl mailSender;
	private String VerificationCode; 

	public void makeRandomKey() {
		StringBuffer temp = new StringBuffer();
		for (int i = 0; i < 10; i++) temp = addRandomChar(temp);
		VerificationCode = temp.toString();
	}

	private StringBuffer addRandomChar(StringBuffer temp) {

		Random random = new Random();
		int randomIndex = random.nextInt(3);
		switch (randomIndex) {
			case 0:
				temp.append((char) (random.nextInt(26) + 97)); // a-z
				break;
			case 1:
				temp.append((char) (random.nextInt(26) + 65)); // A-Z
				break;
			case 2:
				temp.append((random.nextInt(10))); // 0-9
				break;
		}
		return temp;
	}

	//메일 양식
	public String setMail(String email) {
		makeRandomKey();
		String setFrom = "kh361team1@gmail.com";
		String title = "[인증코드 확인] 안녕하세요! 밀키트 쇼핑몰 밀슐랭입니다";
		String content = "인증코드: " + VerificationCode;
		sendMail(setFrom, email, title, content);
		return VerificationCode;
	}

	//전송 메소드
	public void sendMail(String setFrom, String toMail, String title, String content) {
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message,true,"utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content,true);
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
}

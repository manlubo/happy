package com.gitbaby.happygivers.util;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
@AllArgsConstructor
public class MailUtil {
  // 메일 전송용 메서드
  // Gmail SMTP 서버 정보
  private final String user;      // 보내는 사람 이메일
  private final String password;         // 앱 비밀번호
  private final Properties props;

  @Autowired
  public MailUtil(
    @Value("${spring.mail.host}") String host,
    @Value("${spring.mail.username}") String user,
    @Value("${spring.mail.password}") String password,
    @Value("${spring.mail.port}") String port,
    @Value("${spring.mail.properties.mail.smtp.auth}") String auth,
    @Value("${spring.mail.properties.mail.smtp.starttls.enable}") String enable
  ) {
    this.user = user;
    this.password = password;
    Properties props = new Properties();
    props.put("mail.smtp.host", host);
    props.put("mail.smtp.port", port);
    props.put("mail.smtp.auth", auth);
    props.put("mail.smtp.starttls.enable", enable);
    this.props = props;
  }

  public void sendEmail(String to, String subject, String content) {
    // 세션 생성
    Session session = Session.getDefaultInstance(props, new Authenticator() {
      protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(user, password);
      }
    });
    try {
      // 이메일 메시지 생성
      MimeMessage message = new MimeMessage(session);
      message.setFrom(new InternetAddress(user));
      message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
      message.setSubject(subject);

      // HTML 형식으로 메일 내용 설정
      message.setContent(content, "text/html; charset=utf-8");

      // 메일 전송
      Transport.send(message);
      System.out.println("메일 전송 완료: " + to);

    } catch (MessagingException e) {
      e.printStackTrace(); // 에러 출력
      throw new RuntimeException("메일 전송 실패: " + e.getMessage());
    }
  }

}
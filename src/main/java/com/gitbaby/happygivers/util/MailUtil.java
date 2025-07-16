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

@AllArgsConstructor
public class MailUtil {
  // 메일 전송용 메서드
  public static void sendEmail(String to, String subject, String content) {
    // Gmail SMTP 서버 정보
    final String host = "smtp.gmail.com";
    final String user = "thdtjdwns0902@gmail.com";      // 보내는 사람 이메일
    final String password = "jaxbyqyodienwksj";         // 앱 비밀번호

    // SMTP 속성 설정
    Properties props = new Properties();
    props.put("mail.smtp.host", host);
    props.put("mail.smtp.port", "587");
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true"); // TLS 보안

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

  public static void main(String[] args) {
    MailUtil.sendEmail("thdtjdwns@gmail.com", "테스트 제목", "테스트 본문<br>이건 HTML입니다.");
  }


}
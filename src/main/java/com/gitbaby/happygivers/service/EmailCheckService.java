package com.gitbaby.happygivers.service;

import java.util.UUID;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;

import com.gitbaby.happygivers.domain.Member;
import com.gitbaby.happygivers.mapper.MemberMapper;
import com.gitbaby.happygivers.util.MailUtil;

import com.gitbaby.happygivers.util.RedisUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

// 이메일 Redis 처리 + DB 인증 처리 서비스
@Service
@AllArgsConstructor
@Slf4j
public class EmailCheckService {
  private MemberMapper mapper;
  private MailUtil mailUtil;

  // 인증 토큰 저장
  public void saveToken(String uuid, String email) {
    RedisUtil.set(uuid, email, 600); // 10분 TTL
  }

  // 인증 토큰 존재 여부 확인
  public boolean isVerified(String uuid) {
    return RedisUtil.exists(uuid);
  }

  // 토큰으로 이메일 꺼내기
  public String getEmail(String uuid) {
    return RedisUtil.get(uuid);
  }

  // 토큰 삭제 (1회용)
  public void removeToken(String uuid) {
    RedisUtil.remove(uuid);
  }

  //  인증 성공 처리: emailcheck = 1 + email_check.check = 1
  @Transactional
  public boolean verifyEmail(String uuid) {
    //  uuid로 이메일 꺼냄
    String email = RedisUtil.get(uuid);
    if (email == null) return false;

    // tbl_member.emailcheck = 1
    mapper.updateEmailCheckByEmail(email);

    // tbl_email_check.check = 1
    mapper.verifyEmail(uuid);

    //  Redis 인증 토큰 삭제
    RedisUtil.remove(uuid);
    System.out.println("인증 시작 - uuid: " + uuid);
    System.out.println("이메일 인증 처리 - email: " + email);

    return true;
  }

  // 인증된 사용자 조회 (세션 등록용)
  public Member getMemberByEmail(String email) {
    return mapper.selectByEmail(email);
  }


  public void resendAuthEmail(String email) {
    UUID uuid = UUID.randomUUID();
    RedisUtil.set("email:" + uuid, email, 300);

    // 인증 링크 생성
    String link = "http://localhost:8080/member/email-check?uuid=" + uuid;

    // 메일 내용 생성
    String html = "<h3>아래 링크를 클릭하여 인증을 완료해주세요</h3>" +
      "<a href='" + link + "' target='_blank'>" + link + "</a>";

    // 메일 전송
    mailUtil.sendEmail(email, "Happygivers 이메일 재인증", html);
  }

}

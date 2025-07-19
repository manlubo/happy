package com.gitbaby.happygivers.config.filter;

import com.gitbaby.happygivers.domain.Member;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import com.gitbaby.happygivers.mapper.AutoLoginMapper;
import com.gitbaby.happygivers.service.MemberService;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.SessionAttribute;

import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


@Slf4j
@Component
@AllArgsConstructor
public class AutoLoginFilter implements Filter {
  private MemberService memberService;
  private AutoLoginMapper autoLoginMapper;

  @Override
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

    HttpServletRequest req = (HttpServletRequest) request;
    HttpServletResponse resp = (HttpServletResponse) response;

    HttpSession session = req.getSession(false);

    // 이미 로그인된 상태면 필터 통과
    if (session != null && session.getAttribute("member") != null) {
      chain.doFilter(request, response);
      return;
    }

    HttpSession newSession = req.getSession();
    Cookie[] cookies = req.getCookies();
    if (cookies != null) {
      for (Cookie c : cookies) {
        if ("autologin".equals(c.getName())) {
          String token = c.getValue();
          Long mno = autoLoginMapper.selectMnoByToken(token);

          if (mno != null) {
            newSession.setAttribute("member", memberService.findByMno(mno));
            newSession.setMaxInactiveInterval(60 * 60);
            log.info("[AutoLoginFilter] 자동 로그인 완료" + mno);
          } else {
            log.warn("[AutoLoginFilter] 유효하지 않거나 만료된 토큰");
          }
          break;
        }
      }
    } else {
      log.info("[AutoLoginFilter] 쿠키가 존재하지 않습니다.");
    }
    chain.doFilter(request,response);
  }
}


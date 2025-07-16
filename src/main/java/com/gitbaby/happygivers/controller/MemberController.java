package com.gitbaby.happygivers.controller;

import com.gitbaby.happygivers.domain.Member;
import com.gitbaby.happygivers.domain.Tos;
import com.gitbaby.happygivers.domain.en.Mtype;
import com.gitbaby.happygivers.service.BoardService;
import com.gitbaby.happygivers.service.EmailCheckService;
import com.gitbaby.happygivers.service.MemberService;
import com.gitbaby.happygivers.service.TosService;
import com.gitbaby.happygivers.util.MailUtil;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.servlet.http.HttpSession;
import java.util.UUID;

@Controller
@AllArgsConstructor
@RequestMapping("member")
public class MemberController {
  private final BoardService boardService;
  private MemberService memberService;
  private EmailCheckService emailCheckService;
  private TosService tosService;

  @GetMapping("register")
  public void registerForm(){

  }

  @Transactional
  @PostMapping("register")
  public String register(Member member){
    if(member.getName() == null){
      member.setName("이름없음");
    }
    if(member.getMtype() == Mtype.USER){
      member.setNickname("익명의 기부천사" + (int) (Math.random() + 1) * 9999);
    }
    member.setProfile("https://spu.ac.ug/wp-content/uploads/2024/08/profile.jpg");

    memberService.register(member);

    // 이메일 인증을 위한 UUID 생성 및 Redis 저장
    String uuid = UUID.randomUUID().toString();

    emailCheckService.saveToken(uuid, member.getEmail());

    //인증 링크 생성
    String authLink = ServletUriComponentsBuilder.fromCurrentRequest()
      .replacePath("/email-check")
      .queryParam("uuid", uuid)
      .build()
      .toUriString();

    //  인증 메일 HTML 작성
    String html = "<h3>아래 링크를 클릭하여 인증을 완료해주세요</h3>" +
      "<a href='" + authLink + "' target='_blank'>" + authLink + "</a>";

    //  메일 전송
    MailUtil.sendEmail(member.getEmail(), "Happygivers 이메일 인증", html);

    Tos terms = Tos.builder()
      .mno(member.getMno())
      .tosver("v1.0")
      .agrcheck(true)
      .type("TERMS")
      .build();

    Tos privacy = Tos.builder()
      .mno(member.getMno())
      .tosver("v1.0")
      .agrcheck(true)
      .type("PRIVACY")
      .build();

    tosService.save(terms);
    tosService.save(privacy);

    return "redirect:/";
  }

  @GetMapping("login")
  public void loginForm(@ModelAttribute Mtype mtype){

  }

  @PostMapping("login")
  public String login(Member member, HttpSession session, RedirectAttributes redirectAttributes){
    Boolean login = memberService.login(member.getId(), member.getPw(), member.getMtype());
    if(!login){
      redirectAttributes.addFlashAttribute("msg", "fail");
      return "login";
    }
    session.setAttribute("member", memberService.findById(member.getId()));
    return "redirect:/";
  }

  @RequestMapping (value = "logout", method = {RequestMethod.GET, RequestMethod.POST})
  public String logout(HttpSession session){
    session.invalidate();
    return "redirect:/";
  }

}

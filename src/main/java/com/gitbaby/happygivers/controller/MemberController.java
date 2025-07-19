package com.gitbaby.happygivers.controller;

import com.gitbaby.happygivers.domain.Member;
import com.gitbaby.happygivers.domain.Tos;
import com.gitbaby.happygivers.domain.en.Mtype;
import com.gitbaby.happygivers.mapper.AutoLoginMapper;
import com.gitbaby.happygivers.service.BoardService;
import com.gitbaby.happygivers.service.EmailCheckService;
import com.gitbaby.happygivers.service.MemberService;
import com.gitbaby.happygivers.service.TosService;
import com.gitbaby.happygivers.util.MailUtil;
import com.gitbaby.happygivers.util.RedisUtil;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.UUID;

@Controller
@AllArgsConstructor
@RequestMapping("member")
public class MemberController {
  private final BoardService boardService;
  private final AutoLoginMapper autoLoginMapper;
  private MemberService memberService;
  private EmailCheckService emailCheckService;
  private TosService tosService;
  private MailUtil mailUtil;


  // 회원가입
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
    mailUtil.sendEmail(member.getEmail(), "Happygivers 이메일 인증", html);

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


  // 로그인
  @GetMapping("login")
  public void loginForm(@ModelAttribute Mtype mtype){

  }

  @PostMapping("login")
  public String login(Member member, HttpSession session, RedirectAttributes redirectAttributes, @RequestParam(value = "autologin", required = false) String autologin, HttpServletResponse resp){
    Boolean login = memberService.login(member.getId(), member.getPw(), member.getMtype());
    if(!login){
      redirectAttributes.addFlashAttribute("msg", "fail");
      return "login";
    }

    if(autologin != null){
      String token = UUID.randomUUID().toString();
      LocalDateTime expireDate = LocalDateTime.now().plusDays(7);
      Cookie cookie = new Cookie("autologin", token);
      cookie.setPath("/");
      cookie.setMaxAge(60 * 60 * 24 * 7); // 7일
      resp.addCookie(cookie);
      memberService.saveAutoLogin(memberService.findById(member.getId()).getMno(), token, expireDate);
    }

    session.setAttribute("member", memberService.findById(member.getId()));
    return "redirect:/";
  }



  // 로그아웃
  @RequestMapping (value = "logout", method = {RequestMethod.GET, RequestMethod.POST})
  public String logout(HttpSession session, @SessionAttribute("member") Member member){
    autoLoginMapper.delete(member.getMno());
    session.invalidate();

    return "redirect:/";
  }


  // 아이디찾기
  @GetMapping("find-id")
  public String findIdForm(){
    return "member/findId";
  }

  @PostMapping("find-id")
  public String findId(Member member, Model model){
    model.addAttribute("memberList", memberService.findIdsByEmailAndName(member.getEmail(), member.getName()));
    return "member/findIdResult";
  }



  // 비밀번호 찾기
  @GetMapping("findpw")
  public void findPwForm(){
  }



  // 비밀번호 재설정 이메일 전송
  @PostMapping("send-reset-mail")
  public String resetMail(Member member, Model model){
    if (!member.getEmail().matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")){
      return "findpw?error=invalidEmail";
    }
    Member m = memberService.findById(member.getId());
    if(m == null || !m.getEmail().equals(member.getEmail())){
      return "findpw?error=1";
    }

    String uuid = UUID.randomUUID().toString();
    RedisUtil.set(uuid, member.getId(), 300);

    String link = ServletUriComponentsBuilder.fromCurrentRequest()
      .replacePath("/resetpw")
      .queryParam("uuid", uuid)
      .build()
      .toUriString();

    String subject = "[해피기버즈] 비밀번호 재설정 링크";
    String content = "비밀번호 재설정 링크입니다.<br>아래 링크를 클릭하세요:<br><a href='" + link + "'>" + link + "</a>";

    mailUtil.sendEmail(member.getEmail(), subject, content);

    model.addAttribute("sent", true);
    return "findpw";
  }


  // 비밀번호 재설정
  @GetMapping("resetpw")
  public String resetPwForm(@RequestParam("uuid") String uuid, Model model){
    String id = RedisUtil.get(uuid);


    if(id == null){
      return "member/findpw?error=expired";
    }

    String tempPw = UUID.randomUUID().toString().substring(0, 8);

    memberService.updatePassword(id, tempPw);
    RedisUtil.remove(String.valueOf(uuid));

    model.addAttribute("tempPw", tempPw);
    return  "member/showtemppw";
  }

  @PostMapping("resetpw")
  public String resetPw(@RequestParam("uuid") String uuid, @RequestParam("pw") String pw, @RequestParam("pw2") String pw2){
    if(!pw.equals(pw2)){
      return "redirect:member/resetpw?uuid=" + uuid +  "&error=1" ;
    }

    String id = RedisUtil.get(uuid);
    if(id == null){
      return "redirect:member/findpw?error=expired";
    }

    memberService.updatePassword(id, pw);

    RedisUtil.remove(uuid);

    return "redirect:member/login?reset=success";
  }




}

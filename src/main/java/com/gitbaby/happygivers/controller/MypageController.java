package com.gitbaby.happygivers.controller;

import com.gitbaby.happygivers.domain.*;
import com.gitbaby.happygivers.service.*;
import com.gitbaby.happygivers.util.AlertUtil;
import com.gitbaby.happygivers.util.PasswordEncoder;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("mypage")
@AllArgsConstructor
public class MypageController {
  private final DonateService donateService;
  private final PayService payService;
  private final BoardService boardService;
  private final ReplyService replyService;
  private MemberService memberService;
  private PasswordEncoder passwordEncoder;

  // 마이페이지
  @GetMapping
  public String mypageForm(@SessionAttribute(value = "member", required = false) Member member, Model model) {
    if (member == null) {
      return AlertUtil.alert("로그인후 마이페이지 접속이 가능합니다.", "/", model);
    }

    return "member/mypage";
  }

  // ================================ 회원 ===========================================

  // 프로필 수정
  @GetMapping("editprofile")
  public String editProfileForm() {
    return "member/mypage/editprofile";
  }

  // ------ 프로필 사진 업로드 -----
  @PostMapping("editprofile")
  public String editProfile(Attach attach, Model model, HttpSession session) {
    if(attach.getUuid() == null || attach.getUuid().isEmpty() || attach.getMno() == null){
      return AlertUtil.alert("프로필 사진 변경에 실패했습니다.", "editprofile", model);
    }
      memberService.changeProfile(attach);

      session.setAttribute("member", memberService.findByMno(attach.getMno()));
      return AlertUtil.alert("프로필 사진을 변경했습니다.", "editprofile", model);
  }

  // 회원정보 수정
  @GetMapping("updateinfo")
  public String updateinfoForm() {
    return "member/mypage/updateinfo";
  }

  @PostMapping("updateinfo")
  public String updateinfo(Member modifymember, @SessionAttribute("member") Member member, Model model) {
    if (!modifymember.getName().equals(member.getName())) {
      member.setName(modifymember.getName());
    }
    if (!modifymember.getNickname().equals(member.getNickname())) {
      member.setNickname(modifymember.getNickname());
    }
    if (!modifymember.getTel().equals(member.getTel())) {
      member.setTel(modifymember.getTel());
    }
    if (!modifymember.getLocation().equals(member.getLocation())) {
      member.setLocation(modifymember.getLocation());
    }

    memberService.update(member);

    return AlertUtil.alert("회원 정보 수정이 완료되었습니다.", "/mypage", model);
  }


  // 비밀번호 변경
  @GetMapping("updatepw")
  public String updatepwForm() {
    return "member/mypage/updatepw";
  }

  @PostMapping("updatepw")
  public String updatepw(@SessionAttribute("member") Member member, Model model, @RequestParam("currentPw") String currentPw, @RequestParam("newPw") String newPw, HttpSession session) {
    if(!passwordEncoder.matches(currentPw, member.getPw()) || passwordEncoder.matches(newPw, member.getPw())){
      return AlertUtil.alert("현재 비밀번호가 일치하지 않거나, 현재 비밀번호와 변경할 비밀번호가 동일합니다.", "updatepw", model);
    }
    memberService.updatePassword(member.getId(), newPw);
    session.setAttribute("member", memberService.findByMno(member.getMno()));
    return AlertUtil.alert("비밀번호가 변경되었습니다.", "updatepw", model);
  }

  // ================================ 기부 / 결제 ===========================================

  // 기부내역 조회
  @GetMapping("action/list")
  public String actionListForm(@SessionAttribute("member") Member member, Model model) {
    List<DonateAction> actions = donateService.myActionList(member.getMno());
    model.addAttribute("actions", actions);
    return "member/mypage/actionlist";
  }

  // 결제내역 조회
  @GetMapping("pay/list")
  public String payListForm(@SessionAttribute("member") Member member, Model model) {
    List<Pay> pays = payService.findByMno(member.getMno());
    model.addAttribute("pays", pays);
    return "member/mypage/paylist";
  }

  // ================================ 게시판 ===========================================

  // 내가 쓴 게시글 조회
  @GetMapping("board/list")
  public String boardListForm(@SessionAttribute("member") Member member, Model model) {
    List<Board> boards = boardService.myBoardList(member.getMno());
    model.addAttribute("boards", boards);
    return "member/mypage/boardlist";
  }
  // 내가 쓴 댓글 조회
  @GetMapping("reply/list")
  public String replyListForm(@SessionAttribute("member") Member member, Model model) {
    List<Reply> replys = replyService.myReplys(member.getMno());
    model.addAttribute("replys", replys);
    return "member/mypage/replylist";
  }

}

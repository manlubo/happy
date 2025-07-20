package com.gitbaby.happygivers.controller;

import com.gitbaby.happygivers.domain.Attach;
import com.gitbaby.happygivers.domain.Member;
import com.gitbaby.happygivers.service.MemberService;
import com.gitbaby.happygivers.util.AlertUtil;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("mypage")
@AllArgsConstructor
public class MypageController {
  private MemberService memberService;

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


  // ================================ 기부 / 결제 ===========================================

  // 기부내역 조회


  // 결제내역 조회


  // ================================ 게시판 ===========================================

  // 내가 쓴 게시글 조회


  // 내가 쓴 댓글 조회


}

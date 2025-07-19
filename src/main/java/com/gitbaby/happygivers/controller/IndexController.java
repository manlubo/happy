package com.gitbaby.happygivers.controller;

import com.gitbaby.happygivers.domain.Member;
import com.gitbaby.happygivers.service.BoardService;
import com.gitbaby.happygivers.service.DonateService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

@Controller
@AllArgsConstructor
public class IndexController {
  private DonateService donateService;
  private BoardService boardService;


  @GetMapping({"/", "index"})
  public String index(@SessionAttribute(value = "member", required = false) Member member, Model model) {
    if(member != null) {
      // 내 후원 게시글목록
      model.addAttribute("myDonates", boardService.findMnoDonateList(member.getMno()));
      // 내 결제금액
      model.addAttribute("myTotalAmount", donateService.findMyTotalAmount(member.getMno()));
    }

    // 공지사항
    model.addAttribute("notices", boardService.findNoticeList());
    // Q&A
    model.addAttribute("qnas", boardService.findQnaList());
    // 새 기부 게시글
    model.addAttribute("newBoards", boardService.findNewList());
    // 마감임박 게시글
    model.addAttribute("deadlineBoard", boardService.findByDeadline());
    // 전체 금액
    model.addAttribute("totalAmount", donateService.findTotalAmount());

    return "index";
  }
}

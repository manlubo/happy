package com.gitbaby.happygivers.controller;

import com.gitbaby.happygivers.domain.Board;
import com.gitbaby.happygivers.domain.Member;
import com.gitbaby.happygivers.domain.dto.Criteria;
import com.gitbaby.happygivers.domain.dto.PageDto;
import com.gitbaby.happygivers.domain.en.Ctype;
import com.gitbaby.happygivers.domain.en.Mtype;
import com.gitbaby.happygivers.domain.en.Status;
import com.gitbaby.happygivers.service.BoardService;
import com.gitbaby.happygivers.service.DonateService;
import com.gitbaby.happygivers.service.MemberService;
import com.gitbaby.happygivers.util.AlertUtil;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Controller
@AllArgsConstructor
@Slf4j
public class BoardController {
  private BoardService boardService;
  private DonateService donateService;
  private MemberService memberService;
  // 리스트
  @GetMapping({"board/list", "notice/list", "qna/list"})
  public String boardList(Criteria cri, Model model, HttpServletRequest req) {
    log.info("{}", cri);
    if(cri == null) {
      cri = new Criteria();
    }
    String path = req.getServletPath();
    cri.setStatus(Status.ACTIVE);

    List<Board> boards = null;
    // 기부 게시글 리스트 처리
    if ("/board/list".equals(path)) {
      cri.setCtype(Ctype.DONATE);
      boards = boardService.list(cri);
    }

    // 공지 게시글 리스트 처리
    else if ("/notice/list".equals(path)) {
      cri.setCtype(Ctype.NOTICE);
      boards = boardService.list(cri);
    }

    // Q&A 게시글 리스트 처리
    else if ("/qna/list".equals(path)) {
      cri.setCtype(Ctype.QNA);
      boards = boardService.list(cri);
    }

    model.addAttribute("pageDto", new PageDto(cri, boardService.getCount(cri)));
    model.addAttribute("boards", boards);
    return "board/list";
  }


  // 기부 게시글 상세
  @GetMapping("board/view")
  public String viewForm(@SessionAttribute(value = "member", required = false) Member member, @RequestParam("bno") Long bno, Criteria cri, Model model) {
    if(bno == null) {
      return AlertUtil.alert("해당 글이 없습니다.", "list", model);
    }
    if(cri == null) {
      cri = new Criteria();
    }
    Board board = boardService.findByBno(bno);
    int replyCount = boardService.getReplyCount(bno);
    long myamount = 0;
    if(member != null) {
      myamount = donateService.findMyTotalAmount(member.getMno());
      board.setLiked(boardService.checkBoardLiked(board.getBno(), member.getMno()));
    }
    List<Board> orgDonates = boardService.findMnoDonateList(board.getMno());
    Member owner = memberService.findByMno(board.getMno());

    model.addAttribute("board", board);
    model.addAttribute("orgDonates", orgDonates);
    model.addAttribute("myamount", myamount);
    model.addAttribute("cri", cri);
    model.addAttribute("replyCount", replyCount);
    model.addAttribute("owner", owner);
    return "board/view";
  }

  @GetMapping({"board/write", "notice/write", "qna/write"})
  public String boardWriteForm(@SessionAttribute(value = "member", required = false) Member member, Model model, Criteria cri, HttpServletRequest req) {
    if(member == null || !member.getStatus().equals(Status.ACTIVE)) {
      return AlertUtil.alert("접근 권한이 없습니다.", "list", model);
    }
    if(cri == null) {
      cri = new Criteria();
    }
    String path = req.getServletPath();
    // 기부 게시글 작성
    if ("/board/write".equals(path)) {
      if(!(member.getStatus().equals(Status.ACTIVE) && member.getMtype().equals(Mtype.ORG) || member.getMtype().equals(Mtype.ADMIN))) {
        return AlertUtil.alert("접근 권한이 없습니다.", "list", model);
      }
      cri.setCtype(Ctype.DONATE);
    }

    // 공지 게시글 작성
    else if ("/notice/write".equals(path)) {
      if(!(member.getMtype().equals(Mtype.MANAGER) || member.getMtype().equals(Mtype.ADMIN))) {
        return AlertUtil.alert("접근 권한이 없습니다.", "list", model);
      }
      cri.setCtype(Ctype.NOTICE);
    }

    // QNA 게시글 작성
    else if ("/qna/write".equals(path)) {
      if(!(member.getMtype().equals(Mtype.MANAGER) || member.getMtype().equals(Mtype.ADMIN))) {
        return AlertUtil.alert("접근 권한이 없습니다.", "list", model);
      }
      cri.setCtype(Ctype.QNA);
    }
    model.addAttribute("cri", cri);
    return "board/write";
  }






  // 수정
  @GetMapping({"board/modify", "notice/modify", "qna/modify"})
  public String modify(@SessionAttribute(value = "member", required = false) Member member, Model model, HttpServletRequest req, @RequestParam(value = "bno", required = false) Long bno, Criteria cri, HttpServletResponse resp) throws ServletException, IOException {
    if (cri == null) {
      cri = new Criteria();
    }
    Board board = boardService.findByBno(bno);
    if(member == null || bno == null || !(member.getStatus().equals(Status.ACTIVE) &&  (member.getMno().equals(board.getMno()) || member.getMtype().equals(Mtype.ADMIN)))) {
      return AlertUtil.alert("접근 권한이 없습니다.", "list", model);
    }
    String path = req.getServletPath();

    if ("/board/modify".equals(path)) {
      cri.setCtype(Ctype.DONATE);
      board.setRound(boardService.findRound(board.getDrno()));
    }

    // 공지 게시글 수정 처리
    if ("/notice/modify".equals(path)) {
      cri.setCtype(Ctype.NOTICE);
    }

    // Q&A 게시글 수정 처리
    if ("/qna/modify".equals(path)) {
      cri.setCtype(Ctype.QNA);
    }

    model.addAttribute("board", board);
    model.addAttribute("cri", cri);
    return "board/modify";
  }

}

package com.gitbaby.happygivers.controller;

import com.gitbaby.happygivers.domain.*;
import com.gitbaby.happygivers.domain.dto.Criteria;
import com.gitbaby.happygivers.domain.dto.PageDto;
import com.gitbaby.happygivers.domain.en.Ctype;
import com.gitbaby.happygivers.domain.en.Mtype;
import com.gitbaby.happygivers.domain.en.Status;
import com.gitbaby.happygivers.service.BoardService;
import com.gitbaby.happygivers.service.DonateService;
import com.gitbaby.happygivers.service.MemberService;
import com.gitbaby.happygivers.service.ReplyService;
import com.gitbaby.happygivers.util.AlertUtil;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.beans.PropertyEditorSupport;
import java.io.IOException;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;

@Controller
@AllArgsConstructor
@Slf4j
public class BoardController {
  private ReplyService replyService;
  private BoardService boardService;
  private DonateService donateService;
  private MemberService memberService;


  // 문자열 null을 null 처리하는 binder
  @InitBinder
  public void initBinder(WebDataBinder binder) {
    binder.registerCustomEditor(Integer.class, new PropertyEditorSupport() {
      @Override
      public void setAsText(String text) {
        if (text == null || text.equals("") || text.equalsIgnoreCase("null")) {
          setValue(null);
        } else {
          setValue(Integer.parseInt(text));
        }
      }
    });
  }






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
      myamount = donateService.findMyAmount(board.getDrno(), member.getMno());
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

  // 게시글 작성 폼
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

  @PostMapping({"board/write", "notice/write", "qna/write"})
  public String boardWrite(@SessionAttribute(value = "member", required = false) Member member, Model model, Board board, Donate donate, DonateRound round, Attach attach, @RequestParam("imgList") String imgListJson, Criteria cri, HttpServletRequest req) {
    if(member == null || !member.getStatus().equals(Status.ACTIVE)) {
      return AlertUtil.alert("접근 권한이 없습니다.", "list", model);
    }
    String path = req.getServletPath();
    if (cri == null) {
      cri = new Criteria();
    }
    if(attach.getUuid() != null) {
      attach.setMno(null);
      board.setAttach(attach);
    }
    List<Attach> images = null;
    if(imgListJson != null && !imgListJson.isEmpty()) {
      Gson gson = new Gson();
      Type listType = new TypeToken<List<Attach>>(){}.getType();
      images = gson.fromJson(imgListJson, listType);

      board.setImages(images);
    }

    if ("/board/write".equals(path)) {
      boardService.write(board, donate, round);
    }
    else if("/notice/write".equals(path)){
      boardService.write(board);
    }
    else if("/qna/write".equals(path)){
      boardService.write(board);
    }

    return AlertUtil.alert("글이 등록되었습니다.", "list", model);
  }




  // 수정
  @GetMapping({"board/modify", "notice/modify", "qna/modify"})
  public String modifyForm(@SessionAttribute(value = "member", required = false) Member member, Model model, HttpServletRequest req, @RequestParam(value = "bno", required = false) Long bno, Criteria cri) throws ServletException, IOException {
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

  @PostMapping({"board/modify", "notice/modify", "qna/modify"})
  public String modify(@SessionAttribute(value = "member", required = false) Member member, Board modifyBoard, HttpServletRequest req, Model model , Attach attach, @RequestParam("imgList") String imgListJson) throws ServletException, IOException {
    if(member == null || !member.getStatus().equals(Status.ACTIVE)) {
      return AlertUtil.alert("접근 권한이 없습니다.", "list", model);
    }

    if(attach.getUuid() != null) {
      attach.setMno(null);
      modifyBoard.setAttach(attach);
    }

    List<Attach> images = null;
    if(imgListJson != null && !imgListJson.isEmpty()) {
      Gson gson = new Gson();
      Type listType = new TypeToken<List<Attach>>(){}.getType();
      images = gson.fromJson(imgListJson, listType);
      modifyBoard.setImages(images);
    }

    boardService.modify(modifyBoard);

    return AlertUtil.alert("글이 수정되었습니다.", "list", model);
  }


  // 피드 리스트
  @GetMapping("feed/list")
  public String feedListForm(Criteria cri, Model model){
    if(cri == null) {
      cri = new Criteria();
    }
    cri.setStatus(Status.ACTIVE);
    cri.setCtype(Ctype.FEED);
    List<Board> feeds = boardService.list(cri);

    model.addAttribute("pageDto", new PageDto(cri, boardService.getCount(cri)));
    model.addAttribute("feeds", feeds);

    return "board/feed/list";
  }


  // 피드 비동기 처리
  @ResponseBody
  @GetMapping("api/feed/view")
  public Map<String, Object> feedViewForm(@RequestParam("bno") Long bno, @SessionAttribute(value = "member", required = false) Member member, Model model){
    Board board = boardService.findByBno(bno);
    Long mno = (member == null) ? null : member.getMno();
    if(board == null) {
      AlertUtil.alert("해당 글을 찾을 수 없습니다.", "list", model);
    }

    List<Reply> replys = replyService.list(bno, mno, null);
    String profile = memberService.findByMno(board.getMno()).getProfile();
    board.setLiked(boardService.checkBoardLiked(board.getBno(), mno));

    Map<String, Object> data = Map.of(
      "board", board,
      "replys", replys,
      "profile", profile
    );

    return data;
  }



  // 피드 게시글 작성
  @GetMapping("feed/write")
  public String feedWriteForm(@SessionAttribute(value = "member", required = false) Member member, Model model){
    if(member == null ||  !member.getStatus().equals(Status.ACTIVE)) {
      return AlertUtil.alert("회원가입이 완료된 회원만 글을 작성하실 수 있습니다.", "list", model);
    }
    return "board/feed/write";
  }

  @PostMapping("feed/write")
  public String feedWrite(@SessionAttribute(value = "member", required = false) Member member, Board board, Attach attach, Model model){
    if(member == null ||  !member.getStatus().equals(Status.ACTIVE)) {
      return AlertUtil.alert("회원가입이 완료된 회원만 글을 작성하실 수 있습니다.", "list", model);
    }
    if(attach.getUuid() != null) {
      attach.setMno(null);
      board.setAttach(attach);
    }

    boardService.write(board);
    return AlertUtil.alert("글이 등록되었습니다.", "list", model);
  }

  // 피드 수정
  @GetMapping("feed/modify")
  public String feedModifyForm(@SessionAttribute(value = "member", required = false) Member member, Model model, @RequestParam("bno") Long bno){
    if(member == null ||  !member.getStatus().equals(Status.ACTIVE) || !(member.getMno() == boardService.findByBno(bno).getMno() || member.getMtype().equals(Mtype.ADMIN))) {
      return AlertUtil.alert("자신의 글만 수정이 가능합니다.", "list", model);
    }

    model.addAttribute("feed", boardService.findByBno(bno));
    return "board/feed/modify";
  }

  @PostMapping("feed/modify")
  public String feedModify(Board board, Attach attach, Model model){
    if(attach.getUuid() != null) {
      attach.setMno(null);
      board.setAttach(attach);
    }
    boardService.modify(board);
    return AlertUtil.alert("수정이 완료되었습니다.", "list", model);
  }

  // 공지사항 Q&A 상세
  @GetMapping({"notice/view", "qna/view"})
  public String normalViewForm(@RequestParam("bno") Long bno, Model model, HttpServletRequest req, Criteria cri) {
    if(bno == null) {
      return AlertUtil.alert("잘못된 접근입니다.", "list", model);
    }
    String path = req.getServletPath();
    log.info("{}", path);

    if(cri == null) {
      cri = new Criteria();
    }

    if ("/notice/view".equals(path)) {
      cri.setCtype(Ctype.NOTICE);
    }
    else if ("/qna/view".equals(path)) {
      cri.setCtype(Ctype.QNA);
    }

    model.addAttribute("board", boardService.findByBno(bno));
    model.addAttribute("cri", cri);
    return "board/other/view";
  }


  @RequestMapping("remove")
  public ResponseEntity<?> remove(@RequestParam("bno") Long[] bno) {
    try{
      if(bno != null && bno.length > 0) {
        for(Long b : bno) {
          boardService.remove(b);
        }
      }
      return ResponseEntity.ok().build();
    }
    catch(Exception e){
      e.printStackTrace();
      return ResponseEntity.status(500).build();
    }
  }






}

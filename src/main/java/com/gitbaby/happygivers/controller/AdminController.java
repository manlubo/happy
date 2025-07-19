package com.gitbaby.happygivers.controller;

import com.gitbaby.happygivers.domain.*;
import com.gitbaby.happygivers.domain.dto.Criteria;
import com.gitbaby.happygivers.domain.en.Status;
import com.gitbaby.happygivers.service.*;
import com.gitbaby.happygivers.util.AlertUtil;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("admin")
@AllArgsConstructor
public class AdminController {
  private final ReplyService replyService;
  private AdminService adminService;
  private DonateService donateService;
  private PayService payService;
  private BoardService boardService;


  @GetMapping
  public String adminIndexForm(Model model) {

    // 1. 새 게시글 수
    int todayBoardCount = boardService.todayBoardCount();
    // 2. 승인 대기 기부게시글 수
    Criteria cri = new Criteria();
    cri.setStatus(Status.READY);
    int readyCount = boardService.list(cri).size();
    // 3. 모금기간 만료 게시글 수
    int totalVoidCount = boardService.totalVoidCount();
    // 4. 전체 게시글 수
    int totalBoardCount = boardService.totalBoardCount();
    // 5. 신규 결제 수
    int todayPayCount = payService.todayPaidCount();
    // 6. 환불 횟수
    int totalRefundCount = payService.allRefundCount();
    // 7. 전체 결제 횟수
    int totalPayCount = payService.allPayCount();
    // 8. 전체 결제 금액
    long totalAmount = donateService.findTotalAmount();

    model.addAttribute("todayBoardCount", todayBoardCount);
    model.addAttribute("readyCount", readyCount);
    model.addAttribute("totalVoidCount", totalVoidCount);
    model.addAttribute("totalBoardCount", totalBoardCount);
    model.addAttribute("todayPayCount", todayPayCount);
    model.addAttribute("totalRefundCount", totalRefundCount);
    model.addAttribute("totalPayCount", totalPayCount);
    model.addAttribute("totalAmount", totalAmount);

    return "admin/adminindex";
  }
  
  
  // ==================================== 멤버 ====================================================
  // 회원목록 조회

  // 기관회원 승인
  @GetMapping("member/orgapprove")
  public String orgApproveForm(Model model) {
    List<Member> pendingList = adminService.getPendingOrgMembers();
    model.addAttribute("pendingList", pendingList);
    return "admin/member/orgapprove";
  }

  @PostMapping("member/orgapprove")
  public String orgApprove(@RequestParam("mno") Long mno, @RequestParam("appr") int appr, @RequestParam(value = "reason", required = false) String reason, @SessionAttribute("member") Member member, Model model) {
    boolean result = adminService.approveOrReject(mno, appr, reason, member.getMno());
    if (!result) {
      return AlertUtil.alert("기관회원 승인에 실패했습니다.", "orgapprove", model);
    }
    return AlertUtil.alert(mno + "번 회원의 승인이 완료되었습니다.", "orgapprove", model);
  }


  // 기관회원 승인여부 조회
  @GetMapping("member/orgstatus")
  public String orgStatusForm(Model model) {
    List<ApprLog> logs = adminService.getApprovalLogs();
    model.addAttribute("logs", logs);
    return "admin/member/orgstatus";
  }


  // 서브 관리자 생성


  // ==================================== 기부 / 결제 ====================================================
  
  // 모금함 조회
  @GetMapping("donate/roundlist")
  public String roundlistForm(Criteria cri ,Model model) {
    List<Board> boards = boardService.list(cri);
    model.addAttribute("boards", boards);
    model.addAttribute("cno", cri.getCno());
    return "admin/donate/roundlist";
  }


  // 기부내역 조회
  @GetMapping("donate/actionlist")
  public String actionlistForm(Model model) {
    List<DonateAction> actions = donateService.actionList();
    model.addAttribute("actions", actions);
    return "admin/donate/actionlist";
  }


  // 결제내역 조회
  @GetMapping("donate/paylist")
  public String paylistForm(Model model) {
    List<Pay> pays = payService.allPayList();
    model.addAttribute("pays", pays);
    return "admin/donate/paylist";
  }



  // 환불 로그
  @GetMapping("donate/refundlist")
  public String refundlistForm(Model model) {
    List<PayLog> logs = payService.payLogList();
    model.addAttribute("logs", logs);
    return "admin/donate/refundlist";
  }



  // ==================================== 게시판 ====================================================
  
  // 기부 게시글 승인
  @GetMapping("board/orgcheck")
  public String orgCheckForm(Criteria cri , Model model) {
    cri.setStatus(Status.READY);
    List<Board> boards = boardService.list(cri);
    if(boards == null || boards.size() < 1) {
      return AlertUtil.alert("승인할 글이 없습니다.", "list", model);
    }
    model.addAttribute("boards", boards);
    return "admin/board/orgcheck";
  }

  // 기부게시글 상태변경 처리
  @GetMapping("board/orgboardstatuschange")
  public String orgBoardStatusChange(@RequestParam("bno") Long bno, @RequestParam("status") Status status, Model model) {
    boardService.changeStatus(bno, status);
    return AlertUtil.alert(bno + "번 글의 상태가 변경되었습니다.", "list", model);
  }


  // 게시글 관리
  @GetMapping("board/list")
  public String boardListForm(Criteria cri , Model model) {
    List<Board> boards = boardService.list(cri);
    for(Board b : boards){
      String content = b.getContent();
      b.setContent(boardService.removeImgContent(content));
    }

    model.addAttribute("cno",cri.getCno());
    model.addAttribute("boards", boards);
    return "admin/board/boardlist";
  }


  // 댓글 관리
  @GetMapping("reply/list")
  public String replyListForm(Model model) {
    List<Reply> replys = replyService.allList();

    model.addAttribute("replys", replys);
    return "admin/board/replylist";
  }
  
  // 댓글 삭제
  @GetMapping("reply/delete")
  public String replyDeleteForm(@RequestParam("rno") Long rno, Model model) {
    if(rno == null){
      return AlertUtil.alert("존재하지 않는 댓글입니다.", "list", model);
    }
    replyService.remove(rno);
    return AlertUtil.alert("해당 댓글이 삭제되었습니다.", "list", model);
  }
  @PostMapping("reply/delete")
  public ResponseEntity<?> replyDelete(@RequestParam("rno") Long[] rnos) {
    try{
      if(rnos != null || rnos.length > 0){
        for(Long rno : rnos){
          replyService.remove(rno);
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

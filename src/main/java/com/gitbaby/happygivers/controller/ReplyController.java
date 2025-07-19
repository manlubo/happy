package com.gitbaby.happygivers.controller;

import com.gitbaby.happygivers.domain.Member;
import com.gitbaby.happygivers.domain.Reply;
import com.gitbaby.happygivers.service.BoardService;
import com.gitbaby.happygivers.service.ReplyService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@AllArgsConstructor
@Slf4j
@RestController
@RequestMapping("reply")
public class ReplyController {
  private ReplyService replyService;

  @GetMapping("{rno}")
  public Reply get(@PathVariable Long rno){
    return replyService.findBy(rno);
  }

  @GetMapping({"list/{bno}", "list/{bno}/{lastRno}"})
  public List<Reply> list(@PathVariable Long bno, @PathVariable(required = false) Long lastRno, @SessionAttribute(value = "member", required = false ) Member member){
    Long mno = member == null ? 0L : member.getMno();
    return replyService.list(bno, mno, lastRno);
  }

  @PostMapping("/")
  public Map<String,Object> write(@RequestBody Reply reply){
    replyService.register(reply);
    return Map.of("result", true, "reply", reply);
  }

  @PutMapping("{rno}")
  public Map<String,Object> write(@RequestBody Reply reply, @PathVariable Long rno){
    replyService.modify(reply);
    return Map.of("result", true, "reply", reply);
  }

  @DeleteMapping("{rno}")
  public ResponseEntity<Map<String,Object>> delete(@PathVariable Long rno){
    replyService.remove(rno);
    return ResponseEntity.ok().body(Map.of("result", true));
  }

}

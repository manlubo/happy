package com.gitbaby.happygivers.controller;

import com.gitbaby.happygivers.domain.Like;
import com.gitbaby.happygivers.domain.Member;
import com.gitbaby.happygivers.service.LikeService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("api/like")
@AllArgsConstructor
public class LikeController {
  private LikeService likeService;

  @GetMapping
  public int getLike(@RequestParam(value = "bno", required = false) Long bno, @RequestParam(value = "rno", required = false) Long rno){
    int count = 0;
    if(bno != null){
      count = likeService.countByBno(bno);
    }
    if(rno != null){
      count = likeService.countByRno(rno);
    }

    return count;
  }

  @PostMapping
  public Map<String, Object> postLike(@ModelAttribute Like like){
    return Map.of("liked", likeService.toggleLike(like));
  }
}

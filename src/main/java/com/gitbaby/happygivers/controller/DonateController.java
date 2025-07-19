package com.gitbaby.happygivers.controller;

import com.gitbaby.happygivers.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("api/donate")
public class DonateController {
  @Autowired
  private BoardService boardService;

  @Value("${spring.portone.storeId}")
  private String storeId;
  @Value("${spring.portone.channelKey}")
  private String channelKey;
  @Value("${spring.portone.currency}")
  private String currency;

  @GetMapping
  protected Map<String, Object> donate(@RequestParam("bno") Long bno){
    Map<String, Object> donate = new HashMap<>();

    donate.put("storeId", storeId);
    donate.put("channelKey", channelKey);
    donate.put("board", boardService.findByBno(bno));
    donate.put("currency", currency);

    return donate;
  }

}

package com.gitbaby.happygivers.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TosController {

  @GetMapping("terms")
  public String terms(){
    return "tos/terms";
  }
  @GetMapping("privacy")
  public String privacy(){
    return "tos/privacy";
  }
}

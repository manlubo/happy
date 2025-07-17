package com.gitbaby.happygivers.util;

import lombok.extern.slf4j.Slf4j;
import org.springframework.ui.Model;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@Slf4j
public class AlertUtil {
  public static String alert(String msg, String url, Model model) {
    model.addAttribute("msg", msg);
    model.addAttribute("url", url);
    return "common/alert"; // view 이름만 반환
  }

  public static String alert(String msg, String url, String returnUrl, Model model) {
    String encoded = URLEncoder.encode(returnUrl, StandardCharsets.UTF_8);
    return alert(msg, url + "&url=" + encoded, model);
  }
}

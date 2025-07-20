package com.gitbaby.happygivers.config.listener;


import com.gitbaby.happygivers.schedule.GhostFileCleanupJob;
import com.gitbaby.happygivers.util.S3Util;
import org.quartz.*;
import org.quartz.impl.StdSchedulerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;


@Component
@WebListener
public class ContextPathListener implements ServletContextListener { // 서버 실행시 딱 한번만 하는것
  @Autowired
  private S3Util s3Util;
  @Autowired
  private GhostFileCleanupJob ghostFileCleanupJob;
  private Scheduler scheduler;

  @Override
  public void contextInitialized(ServletContextEvent sce) {
    ServletContext sc = sce.getServletContext();
    // 컨텍스트 패스 설정
    sc.setAttribute("cp", sc.getContextPath());


    // s3url 설정
    String s3url = String.format("https://%s.s3.%s.amazonaws.com/upload/", s3Util.getBucketName(), s3Util.getRegionName());
    sc.setAttribute("s3url", s3url);

  }


}




package com.gitbaby.happygivers.schedule;

import com.gitbaby.happygivers.domain.Attach;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import com.gitbaby.happygivers.mapper.AttachMapper;
import org.apache.ibatis.session.SqlSession;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import com.gitbaby.happygivers.util.S3Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Slf4j
@Component
@RequiredArgsConstructor
public class GhostFileCleanupJob {
  private final S3Util s3Util;
  private final AttachMapper attachMapper;

  @Scheduled(cron = "0 0 2 * * ?")
  public void cleanGhostFiles() {
    log.info("고스트 파일 정리 시작");

    long date = System.currentTimeMillis() - 1000 * 60 * 60 * 24;
    String folder = new SimpleDateFormat("/yyyy/MM/dd").format(new Date(date));
    String s3Prefix = "upload" + folder + "/";

    List<String> dbKeyList = attachMapper.selectYesterdayList().stream()
      .map(Attach::getS3Key)
      .toList();

    List<String> s3KeyList = s3Util.listObjects(s3Prefix);
    s3KeyList.removeAll(dbKeyList);

    int deleted = s3Util.removeAll(s3KeyList);
    log.info("고스트 파일 정리 완료 - {}개 삭제", deleted);
  }
}

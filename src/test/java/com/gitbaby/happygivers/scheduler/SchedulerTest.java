package com.gitbaby.happygivers.scheduler;

import com.gitbaby.happygivers.schedule.GhostFileCleanupJob;
import lombok.AllArgsConstructor;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class SchedulerTest {
  @Autowired
  private GhostFileCleanupJob ghostFileCleanupJob;
  
  @Test
  @DisplayName("고스트파일 정리 테스트")
  public void testGostFileCleanup() throws JobExecutionException {
    ghostFileCleanupJob.cleanGhostFiles();
  }
}

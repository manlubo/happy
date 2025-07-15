package com.gitbaby.happygivers.service;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import com.gitbaby.happygivers.domain.Member;
import com.gitbaby.happygivers.domain.ApprLog;
import com.gitbaby.happygivers.mapper.AdminMapper;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@AllArgsConstructor
public class AdminService {
  private AdminMapper adminMapper;

  public List<Member> getPendingOrgMembers() {
    return adminMapper.selectPendingOrgMembers();
  }

  //기관회원승인여부
  public boolean approveOrReject(long mno, int appr, String reason, long admno) {
    String status = (appr == 1) ? "ACTIVE" : "DISABLED";  // 상태값은 String
    int result1 = adminMapper.updateMemberStatus(mno, status); // 결과는 int

    ApprLog log = new ApprLog();
    log.setMno(mno);
    log.setAppr(appr);
    log.setReason(reason);
    log.setAdmno(admno);
    int result2 = adminMapper.insertApprLog(log);

    return result1 > 0 && result2 > 0;
  }

  // 기관회원 정보 조회
  public List<ApprLog> getApprovalLogs() {
    return adminMapper.selectApprovalLogs();
  }


}
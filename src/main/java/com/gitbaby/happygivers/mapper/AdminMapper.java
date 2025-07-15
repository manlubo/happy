package com.gitbaby.happygivers.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gitbaby.happygivers.domain.Member;
import com.gitbaby.happygivers.domain.ApprLog;

public interface AdminMapper {
    // 승인 대기 중인 기관회원 목록
    List<Member> selectPendingOrgMembers();

    // 회원 상태 업데이트
    int updateMemberStatus(@Param("mno") long mno, @Param("status") String status);

    // 승인/거절 로그 기록
    int insertApprLog(ApprLog log);

    //기관회원 정보 승인조회기능
    List<ApprLog> selectApprovalLogs();
}


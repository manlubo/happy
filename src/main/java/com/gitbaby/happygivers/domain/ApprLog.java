package com.gitbaby.happygivers.domain;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Alias("apprlog")
public class ApprLog {
    private long apprlogno;
    private long mno;          // 대상 회원 번호
    private int appr;          // 승인 여부 (1=승인, 0=거절)
    private String reason;     // 거절 사유 (nullable)
    private long admno;        // 처리한 관리자 번호
    private Timestamp regdate; // 처리 일시
    private String id;
    private String email;
}

package com.gitbaby.happygivers.domain;

import java.time.LocalDateTime;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Alias("tos")
public class Tos {
	private Long agrno;         // 동의 고유번호
	private Long mno;           // 회원 번호
	private String tosver;      // 약관 버전
	private LocalDateTime agrdate; // 동의 일시
	private boolean agrcheck;   // 동의 여부 (1: 동의, 0: 거절)
	private String type;        // 약관 종류 (TERMS, PRIVACY 등)
	private String regadmin;    // 등록자 구분 (user, admin
	private boolean withdrawn;  // 탈퇴 여부
}

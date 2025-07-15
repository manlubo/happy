package com.gitbaby.happygivers.domain;

import org.apache.ibatis.type.Alias;

import com.gitbaby.happygivers.domain.en.Status;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Alias("donateRound")
public class DonateRound {
	private Long drno; // 모금 회차 고유번호
	private Long dno; // 모금함 번호
	@Builder.Default
	private Integer round = 1; // 회차 순서
	private int goalamount; // 모금 목표액수
	private String regdate; // 생성일
	private String voiddate; // 마감일
	private Status status; // 모금함 상태
	
	private int nowamount; // 현재 모금액
	private int donatecount; // 참여인원수
	private List<Member> top3; // 상위 멤버 세명
}

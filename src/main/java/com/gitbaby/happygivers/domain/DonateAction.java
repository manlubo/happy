package com.gitbaby.happygivers.domain;

import org.apache.ibatis.type.Alias;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Alias("donateAction")
public class DonateAction {
	private Long dano; // 후원 번호
	private Long drno; // 후원한 모금회차 번호
	private Long mno; //후원한 회원 번호
	private int amount; // 후원 금액
	private String regdate; // 후원 일시
	
	private String name; // 기부자 이름
	private String orgname; // 후원기관 이름
	private String title; // 게시글 제목
	private String bno; // 게시글 번호
}

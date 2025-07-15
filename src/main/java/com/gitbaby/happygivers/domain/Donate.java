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
@Alias("donate")
public class Donate {
	private Long dno; // 모금함 번호
	private String title; // 모금함 제목
	private String content; // 모금함 내용
	private Long mno; // 생성 멤버 번호
	private String regdate; // 생성일
}

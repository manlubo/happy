package com.gitbaby.happygivers.domain;




import java.util.List;

import com.gitbaby.happygivers.domain.en.Ctype;
import org.apache.ibatis.type.Alias;

import com.gitbaby.happygivers.domain.en.Status;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Alias("board")
public class Board {
	private Long bno; //게시글 번호
	private String title; // 제목
	private String content; // 내용
	private String regdate; // 생성일
	private String moddate; // 수정일
	private Long mno; // 작성자
	private int cno; // 카테고리 번호
	private int cnt; // 조회수
	private Status status; // 게시글 상태
	private Long drno; // 연결된 모금회차 고유번호

	private Ctype ctype; // 카테고리 타입
	private String thumbnail; // 썸네일
	private DonateRound round; // 라운드 개체
	private String cname; // 카테고리명
	private String name; // 작성자 이름
	private String nickname; // 작성자 닉네임
	
	private Attach attach; // 첨부파일 - 썸네일 제작시 사용
	private List<Attach> images; // 게시글 내부 이미지
	private int likeCnt; // 좋아요 수
	private boolean liked;
}

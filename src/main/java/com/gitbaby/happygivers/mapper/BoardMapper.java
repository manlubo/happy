package com.gitbaby.happygivers.mapper;


import java.util.List;

import com.gitbaby.happygivers.domain.Board;
import com.gitbaby.happygivers.domain.dto.Criteria;

public interface BoardMapper {
	void insert(Board board);
	void delete(Long bno);
	void update(Board board);
	
	
	List<Board> list(Criteria cri);
	long getCount(Criteria cri);
	
	
	Board selectOne(Long bno);

	// 메인 - 마감일이 얼마 남지 않고, 목표 달성전인 기부 게시글  
	Board selectOneDeadline();
	
	// 메인 - 신규 기부 게시글
	List<Board> listNew();

	// 메인 - 공지사항
	List<Board> listNotice();

	// 메인 - Q&A
	List<Board> listQna();

	// mno로 작성한 기부 게시글 리스트 가져오기
	List<Board> listByMnoDonate(Long mno);

	// 전체 게시글 수 (ACTIVE)
	int totalBoardCount();

	// 마감된 게시글 수
	int totalVoidCount();

	// 오늘 작성된 게시글 수
	int todayBoardCount();


	// 마이페이지 - 작성한 게시글 전부 가져오기
	List<Board> myBoardList(Long mno);
}

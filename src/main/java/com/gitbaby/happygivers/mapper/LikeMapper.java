package com.gitbaby.happygivers.mapper;

import com.gitbaby.happygivers.domain.ApprLog;
import com.gitbaby.happygivers.domain.Like;
import com.gitbaby.happygivers.domain.Member;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface LikeMapper {
   // 좋아요
    void insert(Like like);

    // 좋아요 해제
    void delete(Like like);

    // 게시글 좋아요 수
    int countBoard(Long bno);

    // 댓글 좋아요 수
    int countReply(Long rno);

    List<Like> findByBno(Long bno);

    int isLiked(Like like);

    void deleteByBno(Long bno);
    void deleteByRno(Long rno);

    boolean checkBoardLiked(@Param("bno") Long bno, @Param("mno") long mno);
}


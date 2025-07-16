package com.gitbaby.happygivers.service;

import com.gitbaby.happygivers.domain.Like;
import com.gitbaby.happygivers.mapper.LikeMapper;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;


import java.util.List;

@Service
@AllArgsConstructor
@Slf4j
public class LikeService {
  private LikeMapper mapper;

  // 좋아요가 있는 상태면 true 없는상태면 false 반환하도록
  public boolean isLiked(Like like) {
    return mapper.isLiked(like) > 0;
  }

  public boolean toggleLike(Like like) {
    boolean liked = mapper.isLiked(like) > 0;
    if (liked) {
      mapper.delete(like);
    } else {
      mapper.insert(like);
    }
    return !liked;
  }

  public int countByBno(Long bno) {
    return mapper.countBoard(bno);
  }

  public int countByRno(Long rno) {
    return mapper.countReply(rno);
  }
}

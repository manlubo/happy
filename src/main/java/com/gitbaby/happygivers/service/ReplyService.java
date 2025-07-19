package com.gitbaby.happygivers.service;

import java.util.List;

import com.gitbaby.happygivers.mapper.LikeMapper;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import com.gitbaby.happygivers.domain.Reply;
import com.gitbaby.happygivers.mapper.MemberMapper;
import com.gitbaby.happygivers.mapper.ReplyMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@AllArgsConstructor
@Service
public class ReplyService {
  private ReplyMapper mapper;
  private MemberMapper memberMapper;
  private LikeMapper likeMapper;


  public Reply findBy(Long rno) {
    Reply reply = mapper.selectOne(rno);
    reply.setName(memberMapper.findByMno(reply.getMno()).getName());
    reply.setNickname(memberMapper.findByMno(reply.getMno()).getNickname());
    return reply;
  }

  public List<Reply> list(Long bno, Long mno, Long lastRno) {
    List<Reply> list = mapper.list(bno, mno, lastRno);
    for (Reply r : list) {
      r.setName(memberMapper.findByMno(r.getMno()).getName());
      r.setNickname(memberMapper.findByMno(r.getMno()).getNickname());
    }
    return list;
  }

  // 어드민 - 전체 댓글목록 가져오기
  public List<Reply> allList() {
    List<Reply> list = mapper.listAll();
    for (Reply r : list) {
      r.setName(memberMapper.findByMno(r.getMno()).getName());
      r.setNickname(memberMapper.findByMno(r.getMno()).getNickname());
    }
    return list;
  }

  // 마이페이지 - 작성한 댓글목록 가져오기
  public List<Reply> myReplys(Long mno) {
    return mapper.selectByMno(mno);
  }


  public void register(Reply Reply) {
    mapper.insert(Reply);
  }

  public void modify(Reply Reply) {
    mapper.update(Reply);
  }

  @Transactional
  public void remove(Long rno) {
    likeMapper.deleteByRno(rno);
    mapper.delete(rno);
  }
}

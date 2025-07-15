package com.gitbaby.happygivers.service;

import java.util.List;

import mapper.LikeMapper;
import org.apache.ibatis.session.SqlSession;

import domain.Reply;
import mapper.MemberMapper;
import mapper.ReplyMapper;
import util.MybatisUtil;

public class ReplyService {
	public Reply findBy(Long rno) {
		try(SqlSession session = MybatisUtil.getSqlSession()) {
			ReplyMapper mapper = session.getMapper(ReplyMapper.class);
			return mapper.selectOne(rno);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	public List<Reply> list(Long bno, Long mno, Long lastRno) {
		try(SqlSession session = MybatisUtil.getSqlSession()) {
			ReplyMapper mapper = session.getMapper(ReplyMapper.class);
			MemberMapper memberMapper = session.getMapper(MemberMapper.class);
			List<Reply> list = mapper.list(bno, mno,lastRno);
			for(Reply r : list) {
				r.setName(memberMapper.findByMno(r.getMno()).getName());
				r.setNickname(memberMapper.findByMno(r.getMno()).getNickname());
			}
			return list;
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return null;
	}

	// 어드민 - 전체 댓글목록 가져오기
	public List<Reply> allList() {
		try(SqlSession session = MybatisUtil.getSqlSession()) {
			ReplyMapper mapper = session.getMapper(ReplyMapper.class);
			MemberMapper memberMapper = session.getMapper(MemberMapper.class);
			List<Reply> list = mapper.listAll();
			for(Reply r : list) {
				r.setName(memberMapper.findByMno(r.getMno()).getName());
				r.setNickname(memberMapper.findByMno(r.getMno()).getNickname());
			}
			return list;
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return null;
	}

	// 마이페이지 - 작성한 댓글목록 가져오기
	public List<Reply> myReplys(Long mno) {
		try(SqlSession session = MybatisUtil.getSqlSession()) {
			ReplyMapper mapper = session.getMapper(ReplyMapper.class);

			List<Reply> list = mapper.selectByMno(mno);

			return list;
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return null;
	}


	
	
	
	public void register(Reply Reply) {
		try(SqlSession session = MybatisUtil.getSqlSession()) {
			ReplyMapper mapper = session.getMapper(ReplyMapper.class);
			mapper.insert(Reply);
		}
		catch (Exception e){
			e.printStackTrace();
		}
	}
	
	public void modify(Reply Reply) {
		try(SqlSession session = MybatisUtil.getSqlSession()) {
			ReplyMapper mapper = session.getMapper(ReplyMapper.class);
			mapper.update(Reply);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		
	}
	
	public void remove(Long rno) {
		SqlSession session = MybatisUtil.getSqlSession(false);
		try{
			ReplyMapper mapper = session.getMapper(ReplyMapper.class);
			LikeMapper likeMapper = session.getMapper(LikeMapper.class);
			mapper.delete(rno);
			likeMapper.deleteByRno(rno);
			session.commit();
		}
		catch (Exception e){
			session.rollback();
			e.printStackTrace();
		}
		finally{
			session.close();
		}
	}
}

package com.gitbaby.happygivers.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import domain.Board;
import domain.Donate;
import domain.DonateAction;
import domain.DonateRound;
import domain.Pay;
import domain.PayLog;
import mapper.BoardMapper;
import mapper.DonateMapper;
import mapper.PayMapper;

import util.MybatisUtil;

public class PayService {
	public Pay findBy(Long pno) {
		try(SqlSession session = MybatisUtil.getSqlSession()) {
			PayMapper mapper = session.getMapper(PayMapper.class);
			return mapper.selectOne(pno);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return null;
	}

	public Pay findByUuid(String uuid) {
		try(SqlSession session = MybatisUtil.getSqlSession()) {
			PayMapper mapper = session.getMapper(PayMapper.class);
			return mapper.findByUuid(uuid);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	// 모금회차 하나의 리스트
	public List<Pay> list(Long drno) {
		try(SqlSession session = MybatisUtil.getSqlSession()) {
			PayMapper mapper = session.getMapper(PayMapper.class);
			List<Pay> list = mapper.list(drno);
			
			return list;
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return null;
	}

	// 전체의 리스트 (admin)
	public List<Pay> allPayList() {
		try(SqlSession session = MybatisUtil.getSqlSession()) {
			PayMapper mapper = session.getMapper(PayMapper.class);
			List<Pay> list = mapper.adminPayList();
			
			return list;
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	
	
	
	// 결제시 등록
	public void register(DonateAction action, Pay pay, PayLog log) {
		SqlSession session = MybatisUtil.getSqlSession(false);
		try {
			DonateMapper donateMapper = session.getMapper(DonateMapper.class);
			PayMapper payMapper = session.getMapper(PayMapper.class);
			donateMapper.insertAction(action);
			pay.setDano(action.getDano());
			payMapper.insert(pay);
			log.setPno(pay.getPno());
			payMapper.insertLog(log);
			
			session.commit();
		}
		catch (Exception e){
			session.rollback();
			e.printStackTrace();
		}
		finally {
			session.close();
		}
	}
	
	
	public void modify(Pay pay, PayLog log) {
		SqlSession session = MybatisUtil.getSqlSession(false);
		try {
			PayMapper mapper = session.getMapper(PayMapper.class);
			mapper.update(pay);
			mapper.insertLog(log);
			session.commit();
		}
		catch (Exception e){
			session.rollback();
			e.printStackTrace();
		}
		finally {
			session.close();
		}
	}
	
	public void remove(Long pno) {
		try(SqlSession session = MybatisUtil.getSqlSession()) {
			PayMapper mapper = session.getMapper(PayMapper.class);
			mapper.delete(pno);
		}
		catch (Exception e){
			e.printStackTrace();
		}
	}
	
	// 결제 로그 리스트 (환불)
	public List<PayLog> payLogList() {
		try(SqlSession session = MybatisUtil.getSqlSession()) {
			PayMapper mapper = session.getMapper(PayMapper.class);
			return mapper.listLog();
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return null;
	}

	// 전체 결제 횟수 (paid인것만)
	public int allPayCount() {
		try(SqlSession session = MybatisUtil.getSqlSession()) {
			PayMapper mapper = session.getMapper(PayMapper.class);
			return mapper.totalPaidCount();
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return 0;
	}
	// 전체 환불 횟수 (paid인것만)
	public int allRefundCount() {
		try(SqlSession session = MybatisUtil.getSqlSession()) {
			PayMapper mapper = session.getMapper(PayMapper.class);
			return mapper.totalRefundCount();
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return 0;
	}

	// 오늘 결제 횟수 (paid인것만)
	public int todayPaidCount() {
		try(SqlSession session = MybatisUtil.getSqlSession()) {
			PayMapper mapper = session.getMapper(PayMapper.class);
			return mapper.todayPaidCount();
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return 0;
	}
	// mno로 결제 리스트 찾기
	public List<Pay> findByMno(Long mno) {
		try(SqlSession session = MybatisUtil.getSqlSession()) {
			PayMapper mapper = session.getMapper(PayMapper.class);
			return mapper.findByMno(mno);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return null;
	}

}

package com.gitbaby.happygivers.service;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import com.gitbaby.happygivers.domain.DonateAction;

import com.gitbaby.happygivers.domain.Pay;
import com.gitbaby.happygivers.domain.PayLog;

import com.gitbaby.happygivers.mapper.DonateMapper;
import com.gitbaby.happygivers.mapper.PayMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@AllArgsConstructor
public class PayService {
  private PayMapper mapper;
  private DonateMapper donateMapper;

  public Pay findBy(Long pno) {
    return mapper.selectOne(pno);
  }

  public Pay findByUuid(String uuid) {
    return mapper.findByUuid(uuid);
  }

  // 모금회차 하나의 리스트
  public List<Pay> list(Long drno) {
    return mapper.list(drno);
  }

  // 전체의 리스트 (admin)
  public List<Pay> allPayList() {
    return mapper.adminPayList();
  }

  // 결제시 등록
  @Transactional
  public void register(DonateAction action, Pay pay, PayLog log) {
    donateMapper.insertAction(action);
    pay.setDano(action.getDano());
    mapper.insert(pay);
    log.setPno(pay.getPno());
    mapper.insertLog(log);
  }

  @Transactional
  public void modify(Pay pay, PayLog log) {
    mapper.update(pay);
    mapper.insertLog(log);
  }


  public void remove(Long pno) {
    mapper.delete(pno);
  }

  // 결제 로그 리스트 (환불)
  public List<PayLog> payLogList() {
    return mapper.listLog();
  }

  // 전체 결제 횟수 (paid인것만)
  public int allPayCount() {
    return mapper.totalPaidCount();
  }

  // 전체 환불 횟수 (paid인것만)
  public int allRefundCount() {
    return mapper.totalRefundCount();
  }

  // 오늘 결제 횟수 (paid인것만)
  public int todayPaidCount() {
    return mapper.todayPaidCount();
  }

  // mno로 결제 리스트 찾기
  public List<Pay> findByMno(Long mno) {
    return mapper.findByMno(mno);
  }

}

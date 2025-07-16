package com.gitbaby.happygivers.service;

import java.util.ArrayList;
import java.util.List;

import com.gitbaby.happygivers.domain.Member;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import com.gitbaby.happygivers.domain.DonateAction;
import com.gitbaby.happygivers.domain.DonateRound;
import com.gitbaby.happygivers.mapper.DonateMapper;
import org.springframework.stereotype.Service;


@Service
@AllArgsConstructor
@Slf4j
public class DonateService {
  private DonateMapper donateMapper;
	private MemberService memberService;

  // drno로 round개체 찾아오기
  public DonateRound findByDrno(Long drno) {
    return donateMapper.selectOneRound(drno);
  }

  // round 수정
  public void updateRound(DonateRound round) {
    donateMapper.updateRound(round);
  }

  // 위치한 기부함에 기부한 금액 가져오기
  public long findMyAmount(Long drno, Long mno) {
    return donateMapper.findMyAmount(drno, mno);
  }

  // 플랫폼에 기부한 전체 금액 가져오기
  public long findMyTotalAmount(Long mno) {
    return donateMapper.findMyTotalAmount(mno);
  }

  // 플랫폼에 기부된 전체 금액 가져오기
  public long findTotalAmount() {
    return donateMapper.findTotalAmount();
  }


  // 기부 상태가 paid인 모든 기부내역 가져오기
  public List<DonateAction> actionList() {
    return donateMapper.adminActionList();
  }

  // 기부 게시글에 있는 회차번호로 top 3의 번호를 가져옴
  public List<Member> findTop3(Long drno) {
    List<Member> top3 = new ArrayList<>();
    List<Long> list = donateMapper.findTop3(drno);

    for (Long mno : list) {
      top3.add(memberService.findByMno(mno));
    }
    return top3;
  }

  // 기부 상태가 paid인 유저한명의 기부내역 가져오기
  public List<DonateAction> myActionList(Long mno) {
    return donateMapper.myActionList(mno);
  }

}

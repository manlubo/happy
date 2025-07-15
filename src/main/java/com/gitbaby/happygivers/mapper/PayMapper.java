package com.gitbaby.happygivers.mapper;


import java.util.List;


import com.gitbaby.happygivers.domain.Pay;
import com.gitbaby.happygivers.domain.PayLog;

public interface PayMapper {
	void insert(Pay pay);
	void delete(Long pno);
	void update(Pay pay);
	
	// 모금회차 하나의 결제정보
	List<Pay> list(Long drno);
	
	// 전체 결제 정보
	List<Pay> adminPayList();
	
	Pay selectOne(Long pno);
	Pay findByUuid(String uuid);

	void insertLog(PayLog log);
	void deleteLog(Long plno);
	void updateLog(PayLog log);
	
	
	List<PayLog> listLog();
	
	PayLog selectOneLog(Long plno);

	// 전체 결제 횟수 - PAID 인것만
	int totalPaidCount();

	// 전체 환불 횟수
	int totalRefundCount();

	// 오늘 결제 횟수
	int todayPaidCount();

	// 유저 한명의 결제내역
	List<Pay> findByMno(Long mno);
}

package com.gitbaby.happygivers.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gitbaby.happygivers.domain.Donate;
import com.gitbaby.happygivers.domain.DonateAction;
import com.gitbaby.happygivers.domain.DonateRound;


public interface DonateMapper {
	void insert(Donate donate);
	void delete(Long dno);
	void update(Donate donate);
	Donate selectOne(Long dno);
	
	void insertRound(DonateRound round);
	void deleteRound(Long drno);
	void updateRound(DonateRound round);
	DonateRound selectOneRound(Long drno);
	int findByMaxRound(Long dno);
	
	
	void insertAction(DonateAction action);
	void deleteAction(Long dano);
	void updateAction(DonateAction action);
	List<DonateAction> adminActionList();
	DonateAction selectOneAction(Long dano);
	long findMyAmount(@Param("drno") Long drno,@Param("mno") Long mno);
	long findMyTotalAmount(Long mno);
	long findTotalAmount();
	List<DonateAction> myActionList(Long mno);


	List<Long> findTop3(Long drno);
}

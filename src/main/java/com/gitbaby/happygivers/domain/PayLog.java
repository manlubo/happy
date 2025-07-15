package com.gitbaby.happygivers.domain;



import org.apache.ibatis.type.Alias;

import com.gitbaby.happygivers.domain.en.Mtype;
import com.gitbaby.happygivers.domain.en.PayStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Alias("paylog")
public class PayLog {
	private Long plno;
	private Long pno;
	private PayStatus paystatus;
	private String result;
	private Mtype mtype;
	private String moddate;
	
	
}

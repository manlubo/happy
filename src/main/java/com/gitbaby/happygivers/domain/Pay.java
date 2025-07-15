package com.gitbaby.happygivers.domain;



import org.apache.ibatis.type.Alias;

import com.gitbaby.happygivers.domain.en.PayStatus;
import com.gitbaby.happygivers.domain.en.PayType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Alias("pay")
public class Pay {
	private Long pno;
	private Long dano;
	private Long mno;
	private int payamount;
	private PayType paytype;
	private PayStatus paystatus;
	private String confirm;
	private String receipt;
	private String uuid;
	private String regdate;
	private String voiddate;
	private String moddate;
	
	private String name;
}

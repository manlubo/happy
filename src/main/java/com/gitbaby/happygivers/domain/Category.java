package com.gitbaby.happygivers.domain;

import com.gitbaby.happygivers.domain.en.Ctype;
import org.apache.ibatis.type.Alias;

import com.gitbaby.happygivers.domain.en.Status;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Alias("category")
public class Category {
	private Integer cno;
	private String cname;
	private String regdate;
	private Integer odr;
	private Status status;
	private Ctype ctype;
}

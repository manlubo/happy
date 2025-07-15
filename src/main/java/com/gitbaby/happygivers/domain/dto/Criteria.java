package com.gitbaby.happygivers.domain.dto;


import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;

import com.gitbaby.happygivers.domain.en.Ctype;
import com.gitbaby.happygivers.domain.en.Status;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Data
@Slf4j
@NoArgsConstructor
@AllArgsConstructor
public class Criteria { //페이지 관련
	
	public Criteria(int page, int amount, int cno) {
		this.page = page;
		this.amount = amount;
		this.cno = cno;
		
	}

	private int page = 1;
	private int amount = 10;
	private Integer cno;
	private Status status;
	private String type = ""; // TCI
	private String keyword = "";
	private Ctype ctype;
	
	public int getOffset() {
		int offset = amount * (page-1);
		return offset;
	}

	public String[] getTypes() {
		String[] arr = null;
		if(type != null && !type.equals("")) {
			arr = type.split("");
		}
		return arr;
	}
	
	
	public static Criteria init(HttpServletRequest req) { // 판단 기준
		Criteria cri = new Criteria();
		try {
			cri.cno = Integer.parseInt(req.getParameter("cno"));
			cri.page = Integer.parseInt(req.getParameter("page"));
			cri.amount = Integer.parseInt(req.getParameter("amount"));
			cri.type = req.getParameter("type");
			cri.status = Status.valueOf(req.getParameter("status"));
			cri.keyword = URLDecoder.decode(req.getParameter("keyword"),"utf-8");
		}
		catch (Exception e) {
		} 
		return cri;
	}
			
	public String getQs() { // 검색
		String[] strs = {"cno=" + cno, "amount=" + amount, "type=" + type, "keyword=" + keyword};
		String str = String.join("&", strs);
		return str;
	}
	
	public String getQs2() {
		return getQs() + "&page=" + page; // 게시글 상세보기, 작성, 조회, 수정
	}
	
	
	
}

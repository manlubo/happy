package com.gitbaby.happygivers.domain;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import com.gitbaby.happygivers.domain.en.Mtype;
import com.gitbaby.happygivers.domain.en.Status;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Alias("member")
public class Member {
	private Long mno; //회원번호
	private String id;//로그인아이디
	private String pw;//비밀번호
	private String name;//이름
	private String email;//이메일주소
	private String tel;//전화번호
	private Date regdate;//회원가입일
	private Mtype mtype;//회원 유형
	private Status status;//회원 상태
	private boolean bdgstatus;//배지노출
	private String nickname;//닉네임 
	private String location;//주소
	private String content;//소개글
	private boolean emailcheck;//이메일 인증
	private String profile;//프로필
	

}

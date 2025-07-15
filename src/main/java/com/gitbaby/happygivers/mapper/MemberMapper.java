package com.gitbaby.happygivers.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gitbaby.happygivers.domain.Member;

public interface MemberMapper {

    // 1. 회원가입
    int insert(Member member);

    // 2. 아이디로 회원 조회
    Member findById(String id);

    // 3. 회원번호로 조회  /자동로그인
    Member findByMno(Long mno);

    // 4. 이메일과 이름으로 아이디 찾기
    List<Member> findIdsByEmailAndName(@Param("email") String email, @Param("name") String name);

    void updateMember(Member member); // 회원정보 업데이트용 메서드
    
    // 5. 이메일 인증 여부 업데이트 (tbl_member)
    void updateEmailCheckByEmail(String email); // 인증 성공 시 emailcheck = 1

    // 6. 이메일로 회원 조회
    Member selectByEmail(String email);

    // 7. 이메일 중복 검사용
    Member findByEmail(String email);

    // 8. tbl_email_check 테이블에서 check 컬럼 true로 바꾸기
    void verifyEmail(String uuid);
    
    void updateProfile(Member member);
    
 // 비밀번호찾기
    void updatePassword(@Param("id") String id, @Param("pw") String pw);

    			//비밀번호 변경
    int updatePasswordByUuid(@Param("uuid") String uuid, @Param("pw") String pw);
    
    //프로필사진 업데이트
    void updateProfileImage(Member member); 

    

 


}

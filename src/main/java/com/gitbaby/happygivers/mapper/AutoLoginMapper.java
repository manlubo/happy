package com.gitbaby.happygivers.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.gitbaby.happygivers.domain.AutoLogin;

public interface AutoLoginMapper {

@Insert("insert into tbl_autologin (mno, token, voiddate) values(#{mno}, #{token}, #{voiddate})")
void insert(AutoLogin login);

@Delete("delete from tbl_autologin where mno = #{mno}")
void delete(Long mno);

@Select("select mno from tbl_autologin where token = #{token}")
Long selectMnoByToken(String token);
}
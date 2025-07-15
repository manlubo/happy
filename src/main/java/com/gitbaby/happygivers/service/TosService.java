package com.gitbaby.happygivers.service;

import org.apache.ibatis.session.SqlSession;

import domain.Tos;
import mapper.TosMapper;
import util.MybatisUtil;

public class TosService {

    // 약관 동의 저장
    public void save(Tos tos) {
        try (SqlSession session = MybatisUtil.getSqlSession()) {
            TosMapper mapper = session.getMapper(TosMapper.class);
            mapper.insert(tos);
            session.commit();
        }
    }
}

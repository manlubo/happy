package com.gitbaby.happygivers.service;

import domain.Like;
import mapper.LikeMapper;
import org.apache.ibatis.session.SqlSession;
import util.MybatisUtil;

import java.util.List;

public class LikeService {

    // 좋아요가 있는 상태면 true 없는상태면 false 반환하도록
    public boolean isLiked(Like like) {
        try (SqlSession session = MybatisUtil.getSqlSession()) {
            LikeMapper mapper = session.getMapper(LikeMapper.class);
            return mapper.isLiked(like) > 0;
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }

    public boolean toggleLike(Like like) {
        try (SqlSession session = MybatisUtil.getSqlSession()) {
            LikeMapper mapper = session.getMapper(LikeMapper.class);
            boolean liked = mapper.isLiked(like) > 0;
            if (liked) {
                mapper.delete(like);
            } else {
                mapper.insert(like);
            }
            session.commit();
            return !liked;
        }
    }


    public int countByBno(Long bno){
        try (SqlSession session = MybatisUtil.getSqlSession()) {
            LikeMapper mapper = session.getMapper(LikeMapper.class);
            return mapper.countBoard(bno);
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return 0;
    }

    public int countByRno(Long rno){
        try (SqlSession session = MybatisUtil.getSqlSession()) {
            LikeMapper mapper = session.getMapper(LikeMapper.class);
            return mapper.countReply(rno);
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return 0;
    }
}

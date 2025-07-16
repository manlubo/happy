package com.gitbaby.happygivers.util;

import redis.clients.jedis.JedisPooled;

public class RedisUtil {
    // Redis 서버와 연결된 JedisPooled 객체 생성
    // localhost:6380 > Redis 서버 주소와 포트
    private static final JedisPooled JEDIS_POOLED = new JedisPooled("localhost", 6380);

    // 기본 저장 (10분짜리 데이터 저장)
    public static void set(String key, String value) {
        set(key, value, 600);
        // 기본 TTL(만료시간) 600초 = 10분으로 설정
    }

    //  key-value 데이터 저장 + 만료시간 직접 설정 가능
    public static void set(String key, String value, int expiry) {
        JEDIS_POOLED.setex(key, expiry, value);
        // key에 value를 저장하고, expiry초(초 단위) 후에 자동 삭제
        // 예: set("email:uuid123", "user@email.com", 300);
        // 5분 뒤 자동 삭제됨        
    }

    //  key로부터 value 가져오기
    public static String get(String key) {
        return JEDIS_POOLED.get(key);
        // 저장된 데이터를 조회
        // 예: get("email:uuid123") > "user@email.com"        
    }

    //  key의 남은 유효시간(TTL: Time To Live) 조회
    public static Long ttl(String key) {
        return JEDIS_POOLED.ttl(key);
        // key가 만료되기까지 남은 시간(초)을 반환        
        // 예: ttl("email:uuid123") → 270 (초 단위)
    }

    //  key 삭제 (1회용 인증 토큰 삭제 or 로그아웃 처리)
    public static void remove(String key) {
        JEDIS_POOLED.del(key);
        
   // 예: remove("email:uuid123") Redis에서 해당 key 완전히 제거됨
   //응용: 자동 로그인 토큰 삭제, 로그아웃 처리 시 사용 가능!
    }

    //  key 존재 여부 확인 (true or false)
    public static boolean exists(String key) {
        return JEDIS_POOLED.exists(key);
        
        // 예: exists("email:uuid123") → true or false
        // → 인증 토큰이 아직 살아있는지 체크할 때 사용
    }
}

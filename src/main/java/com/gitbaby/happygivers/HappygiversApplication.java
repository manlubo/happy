package com.gitbaby.happygivers;

import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@MapperScan("com.gitbaby.happygivers.mapper")
@SpringBootApplication
@Slf4j
@EnableScheduling
public class HappygiversApplication {

	public static void main(String[] args) {
		log.info("HappygiversApplication start");
		SpringApplication.run(HappygiversApplication.class, args);
	}

}

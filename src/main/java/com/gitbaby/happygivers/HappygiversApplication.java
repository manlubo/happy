package com.gitbaby.happygivers;

import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.scheduling.annotation.EnableScheduling;

@MapperScan("com.gitbaby.happygivers.mapper")
@SpringBootApplication
@Slf4j
@EnableScheduling
public class HappygiversApplication extends SpringBootServletInitializer {
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(HappygiversApplication.class);
	}

	public static void main(String[] args) {
		SpringApplication.run(HappygiversApplication.class, args);
	}

}

package com.gitbaby.happygivers.config;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;


@Component
@Slf4j
@Data
public class S3Config {
  @Value("${spring.aws.s3.access-key}")
  private String accessKey;

  @Value("${spring.aws.s3.secret-key}")
  private String secretKey;

  @Value("${spring.aws.s3.bucket-name}")
  private String bucketName;

  @Value("${spring.aws.s3.region-name}")
  private String regionName;

  @PostConstruct
  public void print() {
    System.out.println("accessKey: " + accessKey);
    System.out.println("bucketName: " + bucketName);
  }

}

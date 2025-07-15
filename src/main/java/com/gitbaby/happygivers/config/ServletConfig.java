package com.gitbaby.happygivers.config;

import com.gitbaby.happygivers.config.filter.CorsFilter;
import com.gitbaby.happygivers.config.filter.EncodeFilter;
import com.gitbaby.happygivers.config.listener.ContextPathListener;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.servlet.ServletContextListener;

@Configuration
public class ServletConfig {

  @Bean
  public ServletContextListener sevletContextListener(){
    return new ContextPathListener();
  }

  @Bean
  public FilterRegistrationBean<EncodeFilter> encodeFilterRegi(EncodeFilter encodeFilter){
    FilterRegistrationBean<EncodeFilter> registrationBean = new FilterRegistrationBean<>();
    registrationBean.setFilter(encodeFilter);
    registrationBean.addUrlPatterns("/*");
    registrationBean.setOrder(1);
    return registrationBean;
  }

  @Bean
  public FilterRegistrationBean<CorsFilter> corsFilterRegi(CorsFilter corsFilter){
    FilterRegistrationBean<CorsFilter> registrationBean = new FilterRegistrationBean<>();
    registrationBean.setFilter(corsFilter);
    registrationBean.addUrlPatterns("/*");
    registrationBean.setOrder(2);
    return registrationBean;
  }
}

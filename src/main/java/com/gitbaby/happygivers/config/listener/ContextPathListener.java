package com.gitbaby.happygivers.config.listener;


import com.gitbaby.happygivers.mapper.CategoryMapper;
import com.gitbaby.happygivers.util.PropsLoaderUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.Properties;

//import mapper.CategoryMapper;
//import util.MybatisUtil;

@Component
@WebListener
public class ContextPathListener implements ServletContextListener{ // 서버 실행시 딱 한번만 하는것
	

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ServletContext sc = sce.getServletContext();
		sc.setAttribute("cp", sc.getContextPath());
		
		Properties props = PropsLoaderUtil.getProperties("secret/aws_s3.properties");
		String s3url = String.format("https://%s.s3.%s.amazonaws.com/upload/", props.get("bucket-name"), props.get("region-name"));
		sc.setAttribute("s3url", s3url);
	}


}




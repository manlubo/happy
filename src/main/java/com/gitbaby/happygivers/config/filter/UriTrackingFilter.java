package com.gitbaby.happygivers.config.filter;

import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@Component
public class UriTrackingFilter implements Filter {
  @Override
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

    if (request instanceof HttpServletRequest) {
      HttpServletRequest req = (HttpServletRequest) request;

      String uri = req.getRequestURI();
      req.setAttribute("reqUri", uri);
    }

    chain.doFilter(request, response);
  }
}

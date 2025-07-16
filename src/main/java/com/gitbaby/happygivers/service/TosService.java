package com.gitbaby.happygivers.service;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;


import com.gitbaby.happygivers.domain.Tos;
import com.gitbaby.happygivers.mapper.TosMapper;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@AllArgsConstructor
public class TosService {
  private TosMapper mapper;

  // 약관 동의 저장
  public void save(Tos tos) {
    mapper.insert(tos);
  }

}

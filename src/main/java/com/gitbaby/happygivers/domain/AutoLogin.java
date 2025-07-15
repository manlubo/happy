package com.gitbaby.happygivers.domain;

import java.time.LocalDateTime;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AutoLogin {
private Long tno;
private Long mno;
private String token;
private LocalDateTime voiddate;
}
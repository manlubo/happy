package com.gitbaby.happygivers.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.ibatis.type.Alias;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Alias("like")
public class Like {
    private Long lno;
    private Long bno;
    private Long rno;
    private Long mno;
    private String regdate;


}

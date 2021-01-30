package com.example.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class NoticeLikeVo {
	
	private Integer num;
	private String userId;
	private String noticeNum;
	private Integer isLike;

}






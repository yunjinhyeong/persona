package com.example.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class CardInfoVo {
	
	private int num;
	private String uuid;
	private String filename;
	private String uploadpath;
	private int noNum;
}

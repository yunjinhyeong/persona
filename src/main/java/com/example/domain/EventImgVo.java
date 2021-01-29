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
public class EventImgVo {
	private Integer eNum;
	private String eSection;
	private String eTitle;
	private String startDate;
	private String endDate;
	private Timestamp regDate;
	private int num;
	private String uuid;
	private String filename;
	private String uploadpath;
	private int noNum;
}


	

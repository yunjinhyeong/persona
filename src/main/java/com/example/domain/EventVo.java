package com.example.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class EventVo {
	
	private int eNum;
	private String eSection;
	private String eTitle;
	private String startDate;
	private int endDate;
	private Timestamp regDate;
	
	private List<EventPosterVo> eventPosterList;
	
}






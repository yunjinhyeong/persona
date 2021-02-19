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
public class ReservationSeatVo {
	
	private int num;
	private String id;
	private String name;
	private String seat;
	private String area;
	private String date;
	private String theater;
	private Timestamp regDate;
}

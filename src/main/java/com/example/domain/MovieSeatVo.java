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
public class MovieSeatVo {

	private String id;
	private String name;
	private String seat;
	private int noNum;
	private Timestamp regDate;
	private String date;
	private String area;
	private String gender;
}

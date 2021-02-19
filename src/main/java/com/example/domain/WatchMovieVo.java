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
public class WatchMovieVo {

	private int num;
	private String name;
	private String area;
	private String date;
	private String theater;
	private Timestamp regDate;
}

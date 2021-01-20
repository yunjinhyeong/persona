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
public class PageDto {
	
	private String category;
	private String search;
	private int count;
	private int pageCount;
	private int pageBlock;
	private int startPage;
	private int endPage;
}

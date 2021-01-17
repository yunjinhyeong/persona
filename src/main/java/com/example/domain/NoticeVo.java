package com.example.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class NoticeVo {
	
	private int num;
	private String id;
	private String subject;
	private String content;
	private int readcount;
	private Timestamp regDate;
	private String ip;
	private int reRef;
	private int reLev;
	private int reSeq;
}

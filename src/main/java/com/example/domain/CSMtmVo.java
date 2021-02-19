package com.example.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class CSMtmVo {

	private int mnum;
	private String mid;
	private int mquestion;
	private int mkinds;
	private String msubject;
	private String mcontents;
	private Timestamp regDate;
	private int reRef;
	private int reLev;
	private int reSeq;
	private String questioner;
	
}

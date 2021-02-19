package com.example.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;

@Data
public class CSNoticeVo {

	private int num;
	private String id;
	private String csSubject;
	private String csContents;
	private Timestamp regDate;
	private int rank; //1= �����Ȱ���, 2= ��ȭ�� ����, 3= ��ȭ����
	
//	private List<AttachVo> attachList;
}

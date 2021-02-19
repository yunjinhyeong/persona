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
public class MemberVo {

	private String id;
	private String passwd;
	private String name;
	private Integer yy;
	private Integer mm;
	private Integer dd;
	private String gender;
	private String email;
	private String postcode;
	private String address;
	private String address2;
	private Timestamp regDate;
	private String grade;
}






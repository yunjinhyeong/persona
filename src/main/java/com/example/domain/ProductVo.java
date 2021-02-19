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
public class ProductVo {

	private Integer num;
	private String name;
	private String content;
	private String id;
	private Integer price;
	private Timestamp regDate;

}

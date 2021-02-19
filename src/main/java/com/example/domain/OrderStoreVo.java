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
public class OrderStoreVo {
	private Integer num;
	private String name;
	private Integer price;
	private String content;
	private Integer count;
	private Integer total;
	private String id;
	private Timestamp regDate;
}

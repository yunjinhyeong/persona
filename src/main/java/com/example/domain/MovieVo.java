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
public class MovieVo {
	private Integer mNum;
	private String theater;
	private String rank; // 12 15 19
	private String mName;
	private Integer mScore; // 평점
	private Integer mRate; // 예매율
	private String mGenre;
	private Integer mRuntime;
	private String mDirector;
	private String mActor;
	private Integer mLike;
	private Timestamp regDate;
	
	private List<MImgTrailerVo> mImgTrailerList; 
}

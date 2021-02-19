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
public class MovieMImgVo {
	private Integer mNum;
	private String theater;
	private String mRank; // 12 15 19
	private String mName;
	private double mScore; // 평점
	private double mRate; // 예매율
	private String mGenre;
	private Integer mRuntime;
	private String mDirector;
	private String mActor;
	private String mStart;
	private String mEnd;
	private Integer mLike;
	private Timestamp regDate;
	private int num;
	private String uuid;
	private String filename;
	private String uploadpath;
	private String image;
	private int noNum;
}

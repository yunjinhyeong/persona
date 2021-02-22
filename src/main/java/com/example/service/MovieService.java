package com.example.service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.AttachVo;
import com.example.domain.MImgTrailerVo;
import com.example.domain.MovieMImgVo;
import com.example.domain.MovieVo;
import com.example.domain.NoticeVo;
import com.example.mapper.AttachMapper;
import com.example.mapper.MCommentMapper;
import com.example.mapper.MImgTrailerMapper;
import com.example.mapper.MovieMapper;
import com.example.mapper.NoticeMapper;

import lombok.extern.java.Log;

@Log
@Service
public class MovieService {

	@Autowired
	private MovieMapper movieMapper;

	@Autowired
	private MImgTrailerMapper mImgTrailerMapper;

	@Autowired
	private MCommentMapper mcommentMapper;

	public void updateScoreByMnum(double score ,int mNum){
		movieMapper.updateScoreByMnum(score, mNum);
	}

	public void updateMrateByName(String name, double bookrate) {
		movieMapper.updateMrateByName(name, bookrate);
	}

	public List<Map<String, Object>> getDateAtMovie() {
		List<Map<String, Object>> list = movieMapper.getDateAtMovie();
		return list;
	}

	// 주글쓰기
	public void addMovie(MovieVo movieVo) {
		movieMapper.addMovie(movieVo);
	}

	public void addTotalReplyCount(int totalCount, int nno) {
		movieMapper.addTotalReplyCount(totalCount, nno);
	}


	public MovieVo getNoticeByNum(int num) {
		MovieVo movieVo = movieMapper.getMovieByNum(num);
		return movieVo;
	}



	public void updateReadcount(int num) {
		movieMapper.updateReadcount(num);
	}


	public int getCount() {
		int count = movieMapper.getCount();
		return count;
	}


	public int getCountAll() {
		int count = movieMapper.getCountAll();
		return count;
	}


	public List<MovieVo> getMovies(int startRow, int pageSize) {
		List<MovieVo> list = movieMapper.getMovies(startRow, pageSize);
		return list;
	}


	public List<MovieMImgVo> getMoviesMImg(int startPage, int pageSize) {
		List<MovieMImgVo> list = movieMapper.getMoviesMImg(startPage, pageSize);
		return list;
	}

	//메인용
	public List<MovieMImgVo> getMoviesMImgForMain(int startPage, int pageSize) {
		List<MovieMImgVo> list = movieMapper.getMoviesMImgForMain(startPage, pageSize);
		return list;
	}


	public int countMoviesMImg(int startPage, int pageSize) {
		int count = movieMapper.countMoviesMImg(startPage, pageSize);
		return count;
	}


	public void updateMovie(MovieVo movieVo) {
		movieMapper.updateMovie(movieVo);
	}

	public void deleteMovieByNum(int num) {
		movieMapper.deleteMovieByNum(num);
	}

	@Transactional
	public void deleteMovieAndMImgTrailer(int num) {
		movieMapper.deleteMovieByNum(num);
		mImgTrailerMapper.deleteMImgTrailerByNoNum(num);
	}

	public void deleteAll() {
		movieMapper.deleteAll();
	}

	public int getCountBySearch(String category, String search) {
		int count = movieMapper.getCountBySearch(category, search);
		return count;
	}


	public List<MovieVo> getMoviesBySearch(int startRow, int pageSize, String category, String search) {
		return movieMapper.getMoviesBySearch(startRow, pageSize, category, search);
	}


	public MovieVo getMovieAndMImgTrailers(int num) {
		return movieMapper.getMovieAndMImgTrailers(num);
	}

	//public List<NoticeVo> getNoticesByNums(List<Integer> numList)
	public List<MovieVo> getMoviesByNums(Integer... numArr) {

		List<Integer> numList = Arrays.asList(numArr);

		return movieMapper.getMoviesByNums(numList);
	}

	@Transactional
	public void addMovieAndMImgTrailer(MovieVo movieVo, List<MImgTrailerVo> mimgtrailerList) {
		// 게시글 등록
		movieMapper.addMovie(movieVo);

		// 첨부파일정보 등록
		for (MImgTrailerVo mImgTrailerVo : mimgtrailerList) {
			mImgTrailerMapper.insertMImgTrailer(mImgTrailerVo);
		}
	}


	@Transactional
	public void updateMovieAndAddMImgTrailersAndDeleteMImgTrailers(MovieVo movieVo, List<MImgTrailerVo> mImgTrailers, List<Integer> delFileNums) {

		movieMapper.updateMovie(movieVo);
		log.info("delFIleNums: " + delFileNums);

		for (MImgTrailerVo mImgTrailerVo : mImgTrailers) {
			mImgTrailerMapper.insertMImgTrailer(mImgTrailerVo);
		}

		if (delFileNums != null) {
			mImgTrailerMapper.deleteMImgTrailersByNums(delFileNums);
		}
	}

	public void plusLikesByNum(int num) {
		movieMapper.plusLikesByNum(num);
	}

	public void minusLikesByNum(int num) {
		movieMapper.minusLikesByNum(num);
	}

}






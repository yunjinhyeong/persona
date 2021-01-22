package com.example.service;

import java.util.Arrays;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.AttachVo;
import com.example.domain.MImgTrailerVo;
import com.example.domain.MovieVo;
import com.example.domain.NoticeVo;
import com.example.mapper.AttachMapper;
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
	
	
	// 주글쓰기
	public void addMovie(MovieVo movieVo) {
		movieMapper.addMovie(movieVo);
	}
	
	
	public MovieVo getNoticeByNum(int num) {
		MovieVo movieVo = movieMapper.getMovieByNum(num);
		return movieVo;
	}
	
	
	
	public void updateReadcount(int num) {
		movieMapper.updateReadcount(num);
	}
	
	
	
	public int getCountAll() {
		int count = movieMapper.getCountAll();
		return count;
	}
	
	
	public List<MovieVo> getMovies(int startRow, int pageSize) {
		List<MovieVo> list = movieMapper.getMovies(startRow, pageSize);
		return list;
	}
	
	
	public void updateMovie(MovieVo movieVo) {
		movieMapper.updateMovie(movieVo);
	}
	
	public void deleteMovieByNum(int num) {
		movieMapper.deleteMovieByNum(num);
	}
	
	@Transactional
//	public void deleteMovieAndAttaches(int num) {
//		movieMapper.deleteMovieByNum(num);
//		actorMapper.deleteAttachesByNoNum(num);
//	}
	
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
	
	
//	@Transactional
//	public void updateNoticeAndAddAttachesAndDeleteAttaches(MovieVo movieVo, List<ActorVo> actors, List<Integer> delFileNums) {
//		movieMapper.updateMovie(movieVo);
//		
//		for (ActorVo actorVo : actors) {
//			actorMapper.insertActor(actorVo);
//		}
//		
//		actorMapper.deleteAttachesByNums(delFileNums);
//	}
	
}






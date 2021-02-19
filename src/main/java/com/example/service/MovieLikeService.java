package com.example.service;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.example.mapper.MovieLikeMapper;

import lombok.extern.java.Log;

@Log
@Service
@Transactional  // 이 클래스의 모든 메소드가 각각 한개의 트랜잭션 단위로 수행됨
public class MovieLikeService {

	// 스프링 빈으로 등록된 객체들 중에서
	// 타입으로 객체의 참조를 가져와서 참조변수에 저장해줌
	private MovieLikeMapper movieLikeMapper;
	
	@Autowired
	public void setmovieLikeMapper(MovieLikeMapper movieLikeMapper) {
		this.movieLikeMapper = movieLikeMapper;
	}
	
	public int getCountByNumAndId(int movie_num, String id) {
		int count = movieLikeMapper.getCountByNumAndId(movie_num, id);
		return count;
	}
				
	public int getIsLikeByNumAndId(int movie_num, String id) {
		int isLike = movieLikeMapper.getIsLikeByNumAndId(movie_num, id);
		return isLike;
	}
	
	public void addMovieLike(String userId, int movie_num, int isLike) {
		movieLikeMapper.addMovieLike(userId,movie_num,isLike);
	}
	
	public void plusMovieLike(int movie_num, String id) {
		movieLikeMapper.plusMovieLike(movie_num, id);
	}
	
	public void minusMovieLike(int movie_num, String id) {
		movieLikeMapper.minusMovieLike(movie_num, id);
	}
	
}








package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.MovieVo;
import com.example.domain.NoticeVo;

public interface MovieMapper {

//	@Insert("INSERT INTO notice (theater, rank, m_name, m_img, m_score, m_rate, m_genre, m_runtime, m_director, m_tailer, m_like, reg_date) "
//			+ "VALUES (#{theater}, #{rank}, #{mName}, #{mImg}, #{mScore}, #{mRate}, #{mGenre}, #{mRuntime}, #{mDirector}, #{mTailer}, #{mLike}, #{regDate})")
	void addMovie(MovieVo movieVo);	
	
	@Select("SELECT * FROM movie WHERE m_num = #{num}")
	MovieVo getMovieByNum(int num);
	
	
	void updateReadcount(int num);
	
	
//	@Select("SELECT COUNT(*) FROM notice")
	int getCountAll();
	
	
	List<MovieVo> getMovies(@Param("startRow") int startRow, @Param("pageSize") int pageSize);
	
	
	void updateMovie(MovieVo movieVo);
	
	@Delete("DELETE FROM movie WHERE m_num = #{num}")
	void deleteMovieByNum(int num);
	
	@Delete("DELETE FROM movie")
	void deleteAll();
	
	
	void updateReSeq(
			@Param("reRef") int reRef, 
			@Param("reSeq") int reSeq);
	
	
	
	int getCountBySearch(
			@Param("category") String category, 
			@Param("search") String search);
	
	
	List<MovieVo> getMoviesBySearch(
			@Param("startRow") int startRow, 
			@Param("pageSize") int pageSize, 
			@Param("category") String category, 
			@Param("search") String search);
	
	
	MovieVo getMovieAndMImgTrailers(int num);
	
	
	
	List<MovieVo> getMoviesByNums(@Param("numList") List<Integer> numList);
	
	
}







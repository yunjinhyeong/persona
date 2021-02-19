package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.domain.MovieMImgVo;
import com.example.domain.MovieVo;
import com.example.domain.NoticeVo;

public interface MovieMapper {

	void addTotalReplyCount(
		@Param("totalCount") int totalCount,
		@Param("num") int nno);

//	@Insert("INSERT INTO notice (theater, rank, m_name, m_img, m_score, m_rate, m_genre, m_runtime, m_director, m_tailer, m_like, reg_date) "
//			+ "VALUES (#{theater}, #{rank}, #{mName}, #{mImg}, #{mScore}, #{mRate}, #{mGenre}, #{mRuntime}, #{mDirector}, #{mTailer}, #{mLike}, #{regDate})")
	void addMovie(MovieVo movieVo);

	@Select("SELECT * FROM movie WHERE m_num = #{num}")
	MovieVo getMovieByNum(int num);

	List<Map<String, Object>> getDateAtMovie();
	
	void updateReadcount(int num);

	@Select("SELECT COUNT(*) FROM movie")
	int getCount();

//	@Select("SELECT COUNT(*) FROM notice")
	int getCountAll();
	
	@Select("SELECT * FROM movie")
	List<MovieVo> getMovies(@Param("startRow") int startRow, @Param("pageSize") int pageSize);

	List<MovieMImgVo> getMoviesMImg(@Param("startPage") int startPage, @Param("pageSize") int pageSize);

	//���ο�
	List<MovieMImgVo> getMoviesMImgForMain(@Param("startPage") int startPage, @Param("pageSize") int pageSize);

	int countMoviesMImg(@Param("startPage") int startPage, @Param("pageSize") int pageSize);

	void updateMovie(MovieVo movieVo);

	@Delete("DELETE FROM movie WHERE m_num = #{mNum}")
	void deleteMovieByNum(int mNum);

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

	void plusLikesByNum(int num);
	void minusLikesByNum(int num);


	@Update("UPDATE movie SET m_score = ${score} WHERE m_num = ${mNum}")
	void updateScoreByMnum(double score, int mNum);

	@Update("UPDATE movie SET m_rate = ${bookrate} WHERE m_name = \"${name}\" ")
	void updateMrateByName(String name, double bookrate);
}







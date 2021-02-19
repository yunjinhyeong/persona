package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.BookMovieVo;
import com.example.domain.EventImgVo;
import com.example.domain.EventVo;
import com.example.domain.MovieSeatVo;
import com.example.domain.NoticeVo;
import com.example.domain.ReservationSeatVo;
import com.example.domain.WatchMovieVo;

public interface WatchMovieMapper {

	@Select("Select COUNT(*) FROM bisp.movieseat")
	int getTotalCount();

	@Select("Select count(*) from bisp.movieseat where name = #{movieName} ")
	int getScount(String movieName);


//	@Insert("INSERT INTO notice (id, subject, content, readcount, reg_date, ip, re_ref, re_lev, re_seq) "
//			+ "VALUES (#{id}, #{subject}, #{content}, #{readcount}, #{regDate}, #{ip}, #{reRef}, #{reLev}, #{reSeq})")
	void addWatchMovie(WatchMovieVo watchMovieVo);

	List<String> getMoviesName(String area, String rule);

	List<WatchMovieVo> getMoviesDate(String name, String area);

	int getSeatAble(int noNum, String seat);

	List<ReservationSeatVo> getReservationSeats(String id);

	@Select("SELECT * FROM notice WHERE num = #{num}")
	NoticeVo getNoticeByNum(int num);

	void updateReadcount(int num);

	int getNoNum(String area, String name, String date, String theater);

//	@Select("SELECT COUNT(*) FROM notice")
	int getCountAll();


	List<NoticeVo> getNotices(@Param("startRow") int startRow, @Param("pageSize") int pageSize);


	void updateWatchMovie(WatchMovieVo watchMovieVo);

	void addSeat(MovieSeatVo movieSeatVo);

	void addBookedMovie(BookMovieVo bookMovieVo);

	@Delete("DELETE FROM event WHERE e_num = #{num}")
	void deleteEventByNum(int num);

	@Delete("DELETE FROM notice")
	void deleteAll();


	void updateReSeq(
			@Param("reRef") int reRef,
			@Param("reSeq") int reSeq);

	@Delete("DELETE FROM watchmovie WHERE num = #{num}")
	void deleteWatchMovie(int num);

	@Delete("DELETE FROM movieseat WHERE no_num = #{num}")
	void deleteMovieSeat(int num);

	@Delete("DELETE FROM movieseat WHERE no_num = #{num} AND seat = #{seat}")
	void deleteSeat(int num, String seat);

	List<Map<String, Object>> getSalesByDay();

	List<Map<String, Object>> getNameTheatherCount();

	List<Map<String, Object>> getCountByArea();

	List<Map<String, Object>> getAreaDateTheaterByArea();

	int getCountBySearch(
			@Param("category") String category,
			@Param("search") String search);

	int getCountEvent();
	int getCountByMovie();
	int getCountByPremiere();
	int getCountByHOT();
	int getCountByDiscount();

	EventImgVo getEventByENum(int num);

	List<WatchMovieVo> getWatchMoviesBySearch(
			@Param("startRow") int startRow,
			@Param("pageSize") int pageSize,
			@Param("category") String category,
			@Param("search") String search);

	List<EventVo> getMovie();
	List<EventVo> getPremiere();
	List<EventVo> getHOT();
	List<EventVo> getDiscount();

	WatchMovieVo getWatchMovie(int num);

	EventVo getEventAndEventPosters(int num);

	List<EventImgVo> getEventMovieImg();
	List<EventImgVo> getEventPremiereImg();
	List<EventImgVo> getEventHOTImg();
	List<EventImgVo> getEventDiscountImg();

	List<EventImgVo> getEventMovieImgAll();
	List<EventImgVo> getEventPremiereImgAll();
	List<EventImgVo> getEventHOTImgAll();
	List<EventImgVo> getEventDiscountImgAll();

	List<NoticeVo> getNoticesByNums(@Param("numList") List<Integer> numList);

	@Select("SELECT gender, count(*) as cnt "
			+ "FROM movieseat "
			+ "WHERE name = #{name}"
			+ "GROUP BY gender ")
	List<Map<String, Object>> getGenderPerCount(String name);


}







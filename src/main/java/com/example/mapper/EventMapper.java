package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.EventImgVo;
import com.example.domain.EventVo;
import com.example.domain.NoticeVo;

public interface EventMapper {

//	@Insert("INSERT INTO notice (id, subject, content, readcount, reg_date, ip, re_ref, re_lev, re_seq) "
//			+ "VALUES (#{id}, #{subject}, #{content}, #{readcount}, #{regDate}, #{ip}, #{reRef}, #{reLev}, #{reSeq})")
	void addEvent(EventVo eventVo);
	
	
	@Select("SELECT * FROM notice WHERE num = #{num}")
	NoticeVo getNoticeByNum(int num);	
	
	void updateReadcount(int num);
	
	
//	@Select("SELECT COUNT(*) FROM notice")
	int getCountAll();
	
	
	List<NoticeVo> getNotices(@Param("startRow") int startRow, @Param("pageSize") int pageSize);
	
	
	void updateBoard(EventVo eventVo);
	
	@Delete("DELETE FROM event WHERE e_num = #{num}")
	void deleteEventByNum(int num);
	
	@Delete("DELETE FROM notice")
	void deleteAll();
	
	
	void updateReSeq(
			@Param("reRef") int reRef, 
			@Param("reSeq") int reSeq);
	
	
	
	int getCountBySearch(
			@Param("category") String category, 
			@Param("search") String search);
	
	int getCountEvent();
	int getCountByMovie();
	int getCountByPremiere();
	int getCountByHOT();
	int getCountByDiscount();
	
	EventImgVo getEventByENum(int num);
	
	List<EventVo> getEventsBySearch(
			@Param("startRow") int startRow, 
			@Param("pageSize") int pageSize, 
			@Param("category") String category, 
			@Param("search") String search);
	
	List<EventVo> getMovie();
	List<EventVo> getPremiere();
	List<EventVo> getHOT();
	List<EventVo> getDiscount();	
	
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
	
	
}







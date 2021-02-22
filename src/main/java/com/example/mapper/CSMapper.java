package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.CSMtmVo;
import com.example.domain.CSNoticeVo;
import com.example.domain.NoticeVo;

public interface CSMapper {

//	@Insert("INSERT INTO notice (id, subject, content, readcount, reg_date, ip, re_ref, re_lev, re_seq) "
//			+ "VALUES (#{id}, #{subject}, #{content}, #{readcount}, #{regDate}, #{ip}, #{reRef}, #{reLev}, #{reSeq})")
	void addNotice(CSNoticeVo csNoticeVo);

	void MtmaddNotice(CSMtmVo csMtmVo);


	@Select("SELECT * FROM csnotice WHERE num = #{num}")
	CSNoticeVo getNoticeByNum(int num);

	@Select("SELECT * FROM csmtm WHERE mnum = #{mnum}")
	CSMtmVo mtmgetNoticeByNum(int num);



	void updateReadcount(int num);


//	@Select("SELECT COUNT(*) FROM notice")
	int getCountAll();


	List<CSNoticeVo> getNotices(@Param("startRow") int startRow, @Param("pageSize") int pageSize);

	List<CSNoticeVo> getNoticesOnly();

	void updateBoard(CSNoticeVo csNoticeVo);

	@Delete("DELETE FROM csnotice WHERE num = #{num}")
	void deleteNoticeByNum(int num);

	@Delete("DELETE FROM csnotice")
	void deleteAll();

	@Delete("DELETE FROM csnotice where num = #{num}")
	void delete(int num);

	@Delete("DELETE FROM csmtm where reref = #{reRef}")
	void CSmtmDelete(int num, int reRef);

	@Select("SELECT * FROM csmtm where mid = #{id}")
	void mtmSearch(String id);


	void updateReSeq(
			@Param("reRef") int reRef,
			@Param("reSeq") int reSeq);



	int getCountBySearch(
			@Param("category") String category,
			@Param("search") String search);

	int mtmgetCountBySearch(
			@Param("category") String category,
			@Param("search") String search,
			@Param("id") String id,
			@Param("reRef") int reRef);

	int NoticeCountById(
			@Param("category") String category,
			@Param("search") String search,
			@Param("id") String id);

	int getCountOfNotice();
	
	List<CSNoticeVo> getNoticesBySearch(
			@Param("startRow") int startRow,
			@Param("pageSize") int pageSize,
			@Param("category") String category,
			@Param("search") String search);

	List<CSMtmVo> mtmgetNoticesBySearch(
			@Param("startRow") int startRow,
			@Param("pageSize") int pageSize,
			@Param("category") String category,
			@Param("search") String search,
			@Param("id") String id,
			@Param("reRef") int reRef);

	List<CSMtmVo> NoticeById(
			@Param("startRow") int startRow,
			@Param("pageSize") int pageSize,
			@Param("category") String category,
			@Param("search") String search);


	CSNoticeVo getNoticeAndAttaches(int num);



	List<CSNoticeVo> getNoticesByNums(@Param("numList") List<Integer> numList);


}







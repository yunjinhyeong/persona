package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.CardCardInfoVo;
import com.example.domain.CardInfoVo;
import com.example.domain.CardVo;

public interface CardMapper {

	@Insert("INSERT INTO card (c_name, c_sale, c_onoff, c_discount, c_kinds) "
			+ "VALUES (#{cName}, #{cSale}, #{cOnoff}, #{cDiscount}, #{cKinds})")
	void addCard(CardVo cardVo);	
	
//	@Select("SELECT * FROM movie WHERE m_num = #{num}")
//	MovieVo getMovieByNum(int num);
//	
//	
//	void updateReadcount(int num);
//	
	@Select("SELECT COUNT(*) FROM card")
	int getCount();
//	
////	@Select("SELECT COUNT(*) FROM notice")
//	int getCountAll();
//	
//	List<MovieVo> getMovies(@Param("startRow") int startRow, @Param("pageSize") int pageSize);
//	
	List<CardCardInfoVo> getCardCardInfo(int startPage, int pageSize);
	
	List<CardCardInfoVo> getCardCardInfoByCKinds(int startPage, int pageSize, String CKinds);
	
	int countCardCardInfo(@Param("startPage") int startPage, @Param("pageSize") int pageSize);
	
	int countCardCardInfoByCKinds(@Param("startPage") int startPage, @Param("pageSize") int pageSize, @Param("CKinds") String CKinds);
	
	void updateCard(CardVo cardVo);
	
	@Delete("DELETE FROM card WHERE c_num = #{cNum}")
	void deleteCardByNum(int cNum);
	
	@Delete("DELETE FROM card")
	void deleteAll();
	
	
//	void updateReSeq(
//			@Param("reRef") int reRef, 
//			@Param("reSeq") int reSeq);
//	
//	
//	
	int getCountBySearch(
			@Param("category") String category, 
			@Param("search") String search);
	
	
	List<CardVo> getCardsBySearch(
			@Param("startRow") int startRow, 
			@Param("pageSize") int pageSize, 
			@Param("category") String category, 
			@Param("search") String search);
	
	
	CardCardInfoVo getCardAndCardInfo(int num);
	
	
	
//	List<MovieVo> getMoviesByNums(@Param("numList") List<Integer> numList);
//	
//	
}







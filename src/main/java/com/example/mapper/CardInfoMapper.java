package com.example.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.example.domain.CardInfoVo;


public interface CardInfoMapper {
	@Insert("INSERT INTO cardinfo (uuid, filename, uploadpath, no_num) "
			+ "VALUES (#{uuid}, #{filename}, #{uploadpath}, #{noNum})")
	void addCardInfo(CardInfoVo cardInfoVo);
	
//	@Select("SELECT * FROM mimgtrailer WHERE num = #{num}")
//	MImgTrailerVo getImgTrailerByNum(int num);
	
	@Select("SELECT * FROM cardinfo WHERE no_num = #{noNum}")
	CardInfoVo getCardInfoByNoNum(int noNum);
	
//	@Delete("DELETE FROM mimgtrailer where num = #{num}")
//	int deleteAttachByNum(int num);
	
	@Delete("DELETE FROM cardinfo where no_num = #{noNum}")
	int deleteCardInfoByNoNum(int noNum);
	
}





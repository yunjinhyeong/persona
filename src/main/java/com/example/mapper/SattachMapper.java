package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.AttachVo;
import com.example.domain.MemberVo;
import com.example.domain.PattachVo;
import com.example.domain.SattachVo;

public interface SattachMapper {

	int insertSattach(SattachVo sattachVo);

	@Select("SELECT * FROM bisp.sattach WHERE pname = #{pname}")
	List<SattachVo> getSattachByName(String pname);


	@Delete("DELETE FROM bisp.sattach WHERE pname = #{pname} ")
	void deleteByName(String pname);

	@Select("SELECT * FROM bisp.sattach WHERE pname = #{pname}")
	SattachVo getSattachByPname(String pname);

	@Select("SELECT * FROM bisp.sattach WHERE nnum = #{num}")
	SattachVo getSattachByNum(int num);
//
//	@Select("SELECT * FROM pattach WHERE id = #{id}")
//	PattachVo getPattachById2(String id);
//
//	void deletePattachedByNums(@Param("numList") List<Integer> numList);

	void deleteByNums(@Param("numList") List<Integer> numList);

}

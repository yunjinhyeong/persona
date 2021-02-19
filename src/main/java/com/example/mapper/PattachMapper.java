package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.AttachVo;
import com.example.domain.PattachVo;

public interface PattachMapper {

	int insertPattach(PattachVo pattachVo);

	@Select("SELECT * FROM bisp.pattach WHERE id = #{id}")
	List<PattachVo> getPattachById(String id);

	@Select("SELECT * FROM pattach WHERE id = #{id}")
	PattachVo getPattachById2(String id);

	void deletePattachedByNums(@Param("numList") List<Integer> numList);

	@Delete("DELETE FROM pattach WHERE id = #{id} ")
	void deleteById(String id);

}
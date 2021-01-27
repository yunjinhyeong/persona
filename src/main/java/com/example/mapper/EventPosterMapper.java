package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.AttachVo;
import com.example.domain.EventPosterVo;

public interface EventPosterMapper {
	
	int insertEventPoster(EventPosterVo eventPosterVo);
	
	@Select("SELECT * FROM eventposter WHERE num = #{num}")
	EventPosterVo getEventPosterByNum(int num);
	
	@Select("SELECT * FROM attach WHERE no_num = #{noNum}")
	List<AttachVo> getAttachesByNoNum(int noNum);
	
	@Delete("DELETE FROM attach where num = #{num}")
	int deleteAttachByNum(int num);
	
	@Delete("DELETE FROM attach where no_num = #{noNum}")
	int deleteAttachesByNoNum(int noNum);
	
	
	void deleteAttachesByNums(@Param("numList") List<Integer> numList);
}





package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.domain.CommentVo;
import com.example.domain.Criteria;
import com.example.domain.MCommentVo;
import com.example.domain.MCriteria;

public interface MCommentMapper {

	@Select("SELECT COUNT(*) FROM mcomment WHERE mno = #{mno}")
	int getTotalCountByMno(int mno);

	@Select("SELECT SUM(score) FROM mcomment WHERE mno =  #{mno}")
	int getTotalScoreByMno(int mno);

	@Insert("INSERT INTO mcomment (mno, id, content, re_ref, re_lev, re_seq, score) "
			+ "VALUES (#{mno}, #{id}, #{content}, #{reRef}, #{reLev}, #{reSeq}, #{score})")
	int insert(MCommentVo McommentVo);

	@Select("SELECT * FROM mcomment WHERE cno = #{cno}")
	MCommentVo getCommentByCno(int cno);

	@Delete("DELETE FROM mcomment WHERE cno = #{cno}")
	int deleteByCno(int cno);

	@Delete("DELETE FROM mcomment WHERE mno=#{num}")
	void deleteByMno(int num);

	@Update("UPDATE mcomment "
			+ "SET content = #{content}, update_date = CURRENT_TIMESTAMP "
			+ "WHERE cno = #{cno}")
	void update(MCommentVo McommentVo);

	@Select("SELECT * "
			+ "FROM mcomment "
			+ "WHERE mno = #{mno} "
			+ "ORDER BY re_ref ASC, re_seq ASC ")
	List<MCommentVo> getComments(int mno);

	@Select("SELECT * "
			+ "FROM mcomment "
			+ "WHERE mno = #{mno} "
			+ "ORDER BY re_ref ASC, re_seq ASC "
			+ "LIMIT #{mcri.startRow}, #{mcri.amount} ")
	List<MCommentVo> getCommentsWithPaging(@Param("mno") int mno, @Param("mcri") MCriteria mcri);

	@Update("UPDATE mcomment "
			+ "SET re_seq = re_seq + 1 "
			+ "WHERE re_ref = #{reRef} "
			+ "AND re_seq > #{reSeq} ")
	void updateReSeq(@Param("reRef") int reRef, @Param("reSeq") int reSeq);

}







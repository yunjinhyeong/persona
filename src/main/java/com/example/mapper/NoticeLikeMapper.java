package com.example.mapper;

import java.util.List;
import java.util.Map;

import com.example.domain.MemberVo;
import com.example.domain.NoticeLikeVo;

public interface NoticeLikeMapper {
	
//	<select id="getCountByNumAndId">
//	SELECT count(*) FROM notice_like WHERE notice_num = #{notice_num} AND user_id = #{id}
//	</select>
	
	int getCountByNumAndId(int notice_num, String id);

	
//	<select id="getIsLikeByNumAndId" resultType="NoticeLikeVo">
//	SELECT is_like FROM notice_like WHERE notice_num = #{notice_num} AND user_id #{id}
//	</select>
	
	int getIsLikeByNumAndId(int notice_num, String id);
	
//	<insert id="addNoticeLike">
//	INSERT INTO notice_like (user_id, notice_num, is_like)
//	VALUES (#{id}, #{notice_num}, 1)
//	</insert>
	
	void addNoticeLike(String userId, int noticeNum, int isLike);
	
//<update id="plusNoticeLike">
//	UPDATE notice_like set is_like = 1
//	WHERE notice_num = #{notice_num} AND user_id = #{user_id}
//</update>
	
	void plusNoticeLike(int notice_num, String id);
	
//<update id="minusNoticeLike">
//	UPDATE notice_like set is_like = 0
//	WHERE notice_num = #{notice_num} AND user_id = #{user_id}
//</update>
	
	void minusNoticeLike(int notice_num, String id);
	
}







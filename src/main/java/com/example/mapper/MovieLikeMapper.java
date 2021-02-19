package com.example.mapper;

import java.util.List;
import java.util.Map;

import com.example.domain.MemberVo;
import com.example.domain.NoticeLikeVo;

public interface MovieLikeMapper {
	
//	<select id="getCountByNumAndId">
//	SELECT count(*) FROM notice_like WHERE movie_num = #{movie_num} AND user_id = #{id}
//	</select>
	
	int getCountByNumAndId(int movie_num, String id);

	
//	<select id="getIsLikeByNumAndId" resultType="NoticeLikeVo">
//	SELECT is_like FROM notice_like WHERE movie_num = #{movie_num} AND user_id #{id}
//	</select>
	
	int getIsLikeByNumAndId(int movie_num, String id);
	
//	<insert id="addNoticeLike">
//	INSERT INTO notice_like (user_id, movie_num, is_like)
//	VALUES (#{id}, #{movie_num}, 1)
//	</insert>
	
	void addMovieLike(String userId, int movie_num, int isLike);
	
//<update id="plusNoticeLike">
//	UPDATE notice_like set is_like = 1
//	WHERE movie_num = #{movie_num} AND user_id = #{user_id}
//</update>
	
	void plusMovieLike(int movie_num, String id);
	
//<update id="minusNoticeLike">
//	UPDATE notice_like set is_like = 0
//	WHERE movie_num = #{movie_num} AND user_id = #{user_id}
//</update>
	
	void minusMovieLike(int movie_num, String id);
	
}







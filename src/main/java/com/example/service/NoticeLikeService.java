package com.example.service;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.example.domain.NoticeLikeVo;
import com.example.mapper.NoticeLikeMapper;

import lombok.extern.java.Log;

@Log
@Service
@Transactional  // 이 클래스의 모든 메소드가 각각 한개의 트랜잭션 단위로 수행됨
public class NoticeLikeService {

	// 스프링 빈으로 등록된 객체들 중에서
	// 타입으로 객체의 참조를 가져와서 참조변수에 저장해줌
	private NoticeLikeMapper noticeLikeMapper;
	
	@Autowired
	public void setNoticeLikeMapper(NoticeLikeMapper noticeLikeMapper) {
		this.noticeLikeMapper = noticeLikeMapper;
	}
	
	public int getCountByNumAndId(int notice_num, String id) {
		int count = noticeLikeMapper.getCountByNumAndId(notice_num, id);
		return count;
	}
				
	public int getIsLikeByNumAndId(int notice_num, String id) {
		int isLike = noticeLikeMapper.getIsLikeByNumAndId(notice_num, id);
		return isLike;
	}
	
	public void addNoticeLike(String userId, int noticeNum, int isLike) {
		noticeLikeMapper.addNoticeLike(userId,noticeNum,isLike);
	}
	
	public void plusNoticeLike(int notice_num, String id) {
		noticeLikeMapper.plusNoticeLike(notice_num, id);
	}
	
	public void minusNoticeLike(int notice_num, String id) {
		noticeLikeMapper.minusNoticeLike(notice_num, id);
	}
	
}








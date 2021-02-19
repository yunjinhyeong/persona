package com.example.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.CardCardInfoVo;
import com.example.domain.CardInfoVo;
import com.example.domain.CardVo;
import com.example.mapper.CardInfoMapper;
import com.example.mapper.CardMapper;

import lombok.extern.java.Log;

@Log
@Service
public class CardService {
	
	@Autowired
	private CardMapper cardMapper;
	
	@Autowired
	private CardInfoMapper cardInfoMapper;
	
	
	// 주글쓰기
	public void addCard(CardVo cardVo) {
		cardMapper.addCard(cardVo);
	}
	
	
//	public MovieVo getNoticeByNum(int num) {
//		MovieVo movieVo = movieMapper.getMovieByNum(num);
//		return movieVo;
//	}
//	
//	
//	
//	public void updateReadcount(int num) {
//		movieMapper.updateReadcount(num);
//	}
//	
//	
	public int getCount() {
		int count = cardMapper.getCount();
		return count;
	}
//	
//	
//	public int getCountAll() {
//		int count = movieMapper.getCountAll();
//		return count;
//	}
//	
//	
//	public List<MovieVo> getMovies(int startRow, int pageSize) {
//		List<MovieVo> list = movieMapper.getMovies(startRow, pageSize);
//		return list;
//	}
//	
//	
	public List<CardCardInfoVo> getCardCardInfo(int startPage, int pageSize) {
		List<CardCardInfoVo> list = cardMapper.getCardCardInfo(startPage, pageSize);
		return list;
	}
	
	public List<CardCardInfoVo> getCardCardInfoByCKinds(int startPage, int pageSize, String CKinds) {
		List<CardCardInfoVo> list = cardMapper.getCardCardInfoByCKinds(startPage, pageSize, CKinds);
		return list;
	}
	
	
	public int countCardCardInfo(int startPage, int pageSize) {
		int count = cardMapper.countCardCardInfo(startPage, pageSize);
		return count;
	}
	
	public int countCardCardInfoByCKinds(int startPage, int pageSize, String CKinds) {
		int count = cardMapper.countCardCardInfoByCKinds(startPage, pageSize, CKinds);
		return count;
	}
//	
//	
//	public void updateMovie(MovieVo movieVo) {
//		movieMapper.updateMovie(movieVo);
//	}
//	
//	public void deleteMovieByNum(int num) {
//		movieMapper.deleteMovieByNum(num);
//	}
	
	@Transactional
	public void deleteCardAndCardInfoByNum(int num) {
		cardMapper.deleteCardByNum(num);
		cardInfoMapper.deleteCardInfoByNoNum(num);
	}
	
	public void deleteAll() {
		cardMapper.deleteAll();
	}	
	
	public int getCountBySearch(String category, String search) {
		int count = cardMapper.getCountBySearch(category, search);
		return count;
	}
	
	
	public List<CardVo> getCardsBySearch(int startRow, int pageSize, String category, String search) {
		return cardMapper.getCardsBySearch(startRow, pageSize, category, search);
	}
	
	
	public CardCardInfoVo getCardAndCardInfo(int num) {
		return cardMapper.getCardAndCardInfo(num);
	}
	
//	//public List<NoticeVo> getNoticesByNums(List<Integer> numList)
//	public List<MovieVo> getMoviesByNums(Integer... numArr) {
//		
//		List<Integer> numList = Arrays.asList(numArr);
//		
//		return movieMapper.getMoviesByNums(numList);
//	}
	
	@Transactional
	public void addCardAndCardInfo(CardVo cardVo, CardInfoVo cardInfoVo) {
		// 게시글 등록
		cardMapper.addCard(cardVo);
		
		// 첨부파일정보 등록
		cardInfoMapper.addCardInfo(cardInfoVo);
	}
	
	@Transactional
	public void updateCardAndCardInfoAndDeleteCardInfo(CardVo cardVo, CardInfoVo cardInfoVo, Integer delFileNum) {
		if (delFileNum != null) {
			cardInfoMapper.deleteCardInfoByNoNum(delFileNum);
		}
		cardMapper.updateCard(cardVo);
		cardInfoMapper.addCardInfo(cardInfoVo);
	}
	
}






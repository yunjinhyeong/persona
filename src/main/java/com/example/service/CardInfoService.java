package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.CardInfoVo;
import com.example.mapper.CardInfoMapper;

import lombok.extern.java.Log;

@Log
@Service
@Transactional
public class CardInfoService {

	@Autowired
	private CardInfoMapper cardInfoMapper;
	
	public void addCardInfo(CardInfoVo cardInfoVo) {
		cardInfoMapper.addCardInfo(cardInfoVo);
	}
	
//	public MImgTrailerVo getImgTrailerByNum(int num) {
//		MImgTrailerVo mImgTrailerVo = mImgTrailerMapper.getImgTrailerByNum(num);
//		return mImgTrailerVo;
//	}
//	
	public CardInfoVo getCardInfoByNoNum(int noNum) {
		CardInfoVo cardInfoVo = cardInfoMapper.getCardInfoByNoNum(noNum);
		return cardInfoVo;
	}
//	
//	public void deleteAttachByNum(int num) {
//		mImgTrailerMapper.deleteAttachByNum(num);
//	}
//	
//	public void deleteAttachesByNoNum(int noNum) {
//		mImgTrailerMapper.deleteMImgTrailerByNoNum(noNum);
//	}
//	
//	public void deleteMImgTrailersByNums(List<Integer> numList) {
//		mImgTrailerMapper.deleteMImgTrailersByNums(numList);
//	}
	
}

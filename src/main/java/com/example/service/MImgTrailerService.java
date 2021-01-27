package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.AttachVo;
import com.example.domain.MImgTrailerVo;
import com.example.mapper.AttachMapper;
import com.example.mapper.MImgTrailerMapper;

import lombok.extern.java.Log;

@Log
@Service
@Transactional
public class MImgTrailerService {

	@Autowired
	private MImgTrailerMapper mImgTrailerMapper;
	
	public void insertMImgTrailer(MImgTrailerVo mImgTrailerVo) {
		mImgTrailerMapper.insertMImgTrailer(mImgTrailerVo);
	}
	
	public MImgTrailerVo getImgTrailerByNum(int num) {
		MImgTrailerVo mImgTrailerVo = mImgTrailerMapper.getImgTrailerByNum(num);
		return mImgTrailerVo;
	}
	
	public List<MImgTrailerVo> getImgTrailersByNoNum(int noNum) {
		List<MImgTrailerVo> mImgTrailerList = mImgTrailerMapper.getImgTrailersByNoNum(noNum);
		return mImgTrailerList;
	}
	
	public void deleteAttachByNum(int num) {
		mImgTrailerMapper.deleteAttachByNum(num);
	}
	
	public void deleteAttachesByNoNum(int noNum) {
		mImgTrailerMapper.deleteMImgTrailerByNoNum(noNum);
	}
	
	public void deleteMImgTrailersByNums(List<Integer> numList) {
		mImgTrailerMapper.deleteMImgTrailersByNums(numList);
	}
	
}

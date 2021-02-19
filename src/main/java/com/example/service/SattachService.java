package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.SattachVo;
import com.example.mapper.SattachMapper;

@Service
@Transactional
public class SattachService {

	@Autowired
	private SattachMapper sattachMapper;

	public List<SattachVo> getSattachByName(String pname){
		List<SattachVo> sattachList = sattachMapper.getSattachByName(pname);
		return sattachList;
	}

	public void deleteByName(String pname) {
		sattachMapper.deleteByName(pname);
	}


}
